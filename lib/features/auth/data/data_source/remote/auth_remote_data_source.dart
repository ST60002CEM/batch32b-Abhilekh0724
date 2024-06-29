import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; // Add this import if not already imported
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../model/auth_api_model.dart';

final authRemoteDataSourceProvider = Provider(
      (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    authApiModel: ref.read(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.authApiModel,
  });

  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      // Example of GET request to fetch current user from API
      Response response = await dio.get(
        ApiEndpoints.currentUser,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${await userSharedPrefs.getUserToken()}',
          },
        ),
      );
      if (response.statusCode == 200) {
        AuthEntity user = AuthEntity.fromJson(response.data);
        return Right(user);
      } else {
        return Left(Failure(
          error: 'Failed to get current user',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      var response = await dio.post(
        ApiEndpoints.register,
        data: authApiModel.fromEntity(user).toJson(),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        String token = response.data["token"];
        // Save token to shared prefs
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
