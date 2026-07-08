import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipeapp/core/storage/cache_storage.dart';
import 'package:recipeapp/recipes/data/recipe_repository.dart';
import 'package:recipeapp/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/screens/splash_screen.dart';

import 'core/network/dio_client.dart';

import 'core/storage/secure_storage.dart';

import 'features/auth/data/auth_repository.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/auth/presentation/bloc/auth_event.dart';

void main() {
  final storage = SecureStorage();

  final dio = DioClient(storage);

  final authRepository = AuthRepository(dio, storage);

  runApp(MyApp(authRepository, dio));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final DioClient dio;

  const MyApp(this.authRepository, this.dio, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository)..add(CheckAuthStatus())),
          BlocProvider(
              create: (context) =>
                  RecipeBloc(RecipeRepository(dio, CacheStorage())))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}
