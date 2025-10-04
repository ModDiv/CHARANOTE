// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/character_page.dart';
import 'package:project/detail_character.dart';
import 'package:project/detail_project.dart';
import 'package:project/form_add_character.dart';
import 'package:project/form_add_project.dart';
import 'package:project/home_page.dart';
import 'package:project/project_model.dart';
import 'package:project/character_model.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

//URL halaman pertama yang dibuka
final GoRouter router = GoRouter(
  initialLocation: '/projects',
  navigatorKey: _rootNavigatorKey,
  routes: [

    //Main Route untuk Halaman Project
    GoRoute(
      path: '/projects',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const FormAddProject(),
        ),
        GoRoute(
          path: ':projectId',
          builder: (context, state) {
            final project = state.extra as Project;
            return DetailProject(project: project);
          },
          routes: [
            GoRoute(
              path: 'edit',
              builder: (context, state) {
                final project = state.extra as Project;
                return FormAddProject(existingProject: project);
              },
            ),

            //Main Route untuk Halaman Character
            GoRoute(
              path: 'characters',
              builder: (context, state) {
                final projectId = state.pathParameters['projectId']!;
                return CharacterPage(projectId: projectId);
              },

              // URL tambah karakter
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const FormAddCharacter(),
                ),

                // URL lihat detail karakter
                GoRoute(
                  path: ':charId',
                  builder: (context, state) {
                    final character = state.extra as Character;
                    final projectId = state.pathParameters['projectId']!;
                    return DetailCharacter(
                      character: character,
                      projectId: projectId,
                    );
                  },

                  // URL edit karakter
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) {
                        final character = state.extra as Character;
                        return FormAddCharacter(existingCharacter: character);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
