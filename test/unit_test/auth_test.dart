import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:venuevendor/core/failure/failure.dart';
import 'package:venuevendor/features/auth/domain/usecases/auth_usecase.dart';
import 'package:venuevendor/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late MockAuthUseCase mockAuthUseCase;
  late ProviderContainer container;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();

    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
              (ref) => AuthViewModel(authUseCase: mockAuthUseCase),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('check for the initial state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  testWidgets('login test with valid username and password', (WidgetTester tester) async {
    // Arrange
    const correctUsername = 'abilekhyonjan@gmail.com';
    const correctPassword = '123';

    when(mockAuthUseCase.loginUser(correctUsername, correctPassword))
        .thenAnswer((_) async => const Right(true));

    // Create a widget to provide the context
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
                (ref) => AuthViewModel(authUseCase: mockAuthUseCase),
          ),
        ],
        child: MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () async {
                    await container
                        .read(authViewModelProvider.notifier)
                        .loginUser(context, correctUsername, correctPassword);
                  },
                  child: const Text('Login'),
                ),
              );
            },
          ),
        ),
      ),
    );

    // Act
    await tester.tap(find.text('Login'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  testWidgets('login test with invalid username and password', (WidgetTester tester) async {
    // Arrange
    const incorrectUsername = 'wrong@gmail.com';
    const incorrectPassword = 'wrongpassword';

    when(mockAuthUseCase.loginUser(incorrectUsername, incorrectPassword))
        .thenAnswer((_) async => Left(Failure(error: 'Invalid credentials')));

    // Create a widget to provide the context
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
                (ref) => AuthViewModel(authUseCase: mockAuthUseCase),
          ),
        ],
        child: MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () async {
                    await container
                        .read(authViewModelProvider.notifier)
                        .loginUser(context, incorrectUsername, incorrectPassword);
                  },
                  child: const Text('Login'),
                ),
              );
            },
          ),
        ),
      ),
    );

    // Act
    await tester.tap(find.text('Login'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.isLoading, false);
    expect(authState.error, 'Invalid credentials');
  });
}
