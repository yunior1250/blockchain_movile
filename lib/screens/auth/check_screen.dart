///////////////// CHECK SCREEN

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blckchain_movile/screens/screens.dart';
import 'package:blckchain_movile/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.checkAuth(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                Future.microtask(() async {
                  final user = await authService.readUser();

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(idUser: user.id.toString()),
                      ),
                      (route) => false,
                    );
                  }
                });
                return Container();
              } else {
                return const LoginScreen();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.redAccent,
                    radius: 30,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
