import 'dart:js';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipeapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:recipeapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:recipeapp/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipeapp/recipes/presentation/bloc/recipe_state.dart';
import 'package:recipeapp/screens/detail_screen.dart';
import 'package:recipeapp/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<RecipeBloc>().add(FetchRecipes());
          },
          child:
              BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
            if (state is RecipeInitial) {
              context.read<RecipeBloc>().add(FetchRecipes());
            }

            if (state is RecipeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RecipeError) {
              return Center(child: Text(state.message));
            }

            if (state is RecipeSuccess) {
              return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .7),
                  itemCount: state.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = state.recipes[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(recipe: recipe)));
                      },
                      child: Card(
                          child: Column(children: [
                        Image.network(recipe.image,
                            height: 120, fit: BoxFit.cover),
                        Text(
                          recipe.name,
                          maxLines: 2,
                        ),
                        Text("⭐ ${recipe.rating}"),
                        Text(recipe.cuisine)
                      ])),
                    );
                  });
            }

            return Container();
          }),
        ));
  }
}
