import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/auth_provider.dart';
import 'package:our_story/infrastructure/firebase/service.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    goHome(BuildContext context) {
      context.go('/home');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: authState.when(
          data: (user) {
            if (user == null) {
              // サインインしていない場合のUI
              return ElevatedButton(
                onPressed: () async {
                  final service = AuthService();
                  try {
                    await service.signIn();
                    debugPrint('サインイン完了');
                    goHome(context);
                  } catch (error) {
                    debugPrint('サインインエラー : $error');
                  }
                },
                child: const Text('Sign In'),
              );
            } else {
              // サインイン済みの場合のUI
              return Text('Signed in as: ${user.displayName}');
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
    );
  }
}
