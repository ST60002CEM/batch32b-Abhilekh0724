import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:venuevendor/core/failure/failure.dart';
import 'package:venuevendor/features/auth/domain/entity/auth_entity.dart';
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
    const correctUsername = 'abilekhyonjan@gmail.com';
    const correctPassword = '123';

    when(mockAuthUseCase.loginUser(correctUsername, correctPassword))
        .thenAnswer((_) async => const Right(true));

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

    await tester.tap(find.text('Login'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  testWidgets('login test with invalid username and password', (WidgetTester tester) async {
    const incorrectUsername = 'wrong@gmail.com';
    const incorrectPassword = 'wrongpassword';

    when(mockAuthUseCase.loginUser(incorrectUsername, incorrectPassword))
        .thenAnswer((_) async => Left(Failure(error: 'Invalid credentials')));

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

    await tester.tap(find.text('Login'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    expect(authState.isLoading, false);
    expect(authState.error, 'Invalid credentials');
  });

  testWidgets('register test with valid user data', (WidgetTester tester) async {
    final validUser = AuthEntity(
      id: '1',
      fname: 'Test',
      lname: 'User',
      email: 'testuser@example.com',
      password: 'password123',
    );

    when(mockAuthUseCase.registerUser(validUser))
        .thenAnswer((_) async => const Right(true));

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
                        .registerUser(context, validUser);
                  },
                  child: const Text('Register'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Register'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  testWidgets('register test with invalid user data', (WidgetTester tester) async {
    final invalidUser = AuthEntity(
      id: '1',
      fname: '',
      lname: '',
      email: 'invalidemail',
      password: 'short',
    );

    when(mockAuthUseCase.registerUser(invalidUser))
        .thenAnswer((_) async => Left(Failure(error: 'Invalid registration data')));

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
                        .registerUser(context, invalidUser);
                  },
                  child: const Text('Register'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Register'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    expect(authState.isLoading, false);
    expect(authState.error, 'Invalid registration data');
  });

  // Fail scenarios

  test('check for the failed initial state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, 'Initialization failed');
  });

  testWidgets('login test with network error', (WidgetTester tester) async {
    const correctUsername = 'abilekhyonjan@gmail.com';
    const correctPassword = '123';

    when(mockAuthUseCase.loginUser(correctUsername, correctPassword))
        .thenAnswer((_) async => Left(Failure(error: 'Network error')));

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

    await tester.tap(find.text('Login'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    expect(authState.isLoading, false);
    expect(authState.error, 'Network error');
  });

  testWidgets('register test with network error', (WidgetTester tester) async {
    final validUser = AuthEntity(
      id: '1',
      fname: 'Test',
      lname: 'User',
      email: 'testuser@example.com',
      password: 'password123',
    );

    when(mockAuthUseCase.registerUser(validUser))
        .thenAnswer((_) async => Left(Failure(error: 'Network error')));

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
                        .registerUser(context, validUser);
                  },
                  child: const Text('Register'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Register'));
    await tester.pump(); // Rebuild the widget

    final authState = container.read(authViewModelProvider);

    expect(authState.isLoading, false);
    expect(authState.error, 'Network error');
  });
}
