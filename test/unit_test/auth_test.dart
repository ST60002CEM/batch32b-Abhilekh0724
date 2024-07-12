import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:venuevendor/core/failure/failure.dart';
import 'package:venuevendor/features/auth/domain/usecases/auth_usecase.dart';
import 'package:venuevendor/features/auth/presentation/navigator/login_navigator.dart';
import 'package:venuevendor/features/auth/presentation/viewmodel/auth_view_model.dart';


import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),

])
void main() {
  late AuthUseCase mockAuthUsecase;


  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();


    TestWidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
              (ref) => AuthViewModel(mockAuthUsecase,


          ),
        )
      ],
    );
  });

  tearDown(
        () {
      container.dispose();
    },
  );

  test('check for the inital state in Auth state',(){
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);

  });
  test('login test with valid username and password', () async {
    // Arrange
    const correctUsername = 'abilekhyonjan@gmail.com';
    const correctPassword = '123';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('abilekhyonjan@gmail.com', '123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });
}
