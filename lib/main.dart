import 'package:woodiex/woodiex.dart';
import 'core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: Woodiex(
        appRouter: AppRouter(),
      ),
    ),
  );
}