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

// Generate mocks for AuthUseCase
@GenerateMocks([AuthUseCase])
void main() {
  late MockAuthUseCase mockAuthUseCase;
  late ProviderContainer container;

  // Setup the mock and provider container before each test
  setUp(() {
    mockAuthUseCase = MockAuthUseCase();

    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWithProvider(
          ChangeNotifierProvider<AuthViewModel>((ref) => AuthViewModel(authUseCase: mockAuthUseCase)),
        ),
      ],
    );
  });

  // Dispose the container after each test
  tearDown(() {
    container.dispose();
  });

  test('check for the initial state in AuthViewModel', () {
    final authViewModel = container.read(authViewModelProvider);
    expect(authViewModel.isLoading, false);
    expect(authViewModel.error, isNull);
  });

  testWidgets('login test with valid username and password', (WidgetTester tester) async {
    const correctUsername = 'abilekhyonjan@gmail.com';
    const correctPassword = '123';

    when(mockAuthUseCase.loginUser(correctUsername, correctPassword))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
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
    await tester.pumpAndSettle(); // Ensure all async operations are complete

    final authViewModel = container.read(authViewModelProvider);

    expect(authViewModel.isLoading, false);
    expect(authViewModel.error, isNull);
  });

  testWidgets('login test with invalid username and password', (WidgetTester tester) async {
    const incorrectUsername = 'wrong@gmail.com';
    const incorrectPassword = 'wrongpassword';

    when(mockAuthUseCase.loginUser(incorrectUsername, incorrectPassword))
        .thenAnswer((_) async => Left(Failure(error: 'Invalid credentials')));

    await tester.pumpWidget(
      ProviderScope(
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
    await tester.pumpAndSettle(); // Ensure all async operations are complete

    final authViewModel = container.read(authViewModelProvider);

    expect(authViewModel.isLoading, false);
    expect(authViewModel.error, 'Invalid credentials');
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
    await tester.pumpAndSettle(); // Ensure all async operations are complete

    final authViewModel = container.read(authViewModelProvider);

    expect(authViewModel.isLoading, false);
    expect(authViewModel.error, isNull);
  });
}
