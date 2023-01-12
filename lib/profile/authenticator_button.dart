import 'package:conferenceapp/common/europe_text_field.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticatorButton extends StatelessWidget {
  const AuthenticatorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => showLoginDialog(context),
        ),
      ],
    );
  }

  void showLoginDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        String username = '';
        String password = '';
        return SimpleDialog(
          title: Column(
            children: <Widget>[
              Text(
                S.current.login,
                textAlign: TextAlign.center,
              ),
              EuropeTextFormField(
                hint: S.current.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  username = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
              EuropeTextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                hint: S.current.password,
                onChanged: (value) {
                  password = value;
                },
              ),
            ],
          ),
          children: <Widget>[
            TextButton(
              child: Text(S.current.login),
              onPressed: () async {
                final FirebaseAuth auth0 = FirebaseAuth.instance;
                try {
                  final _ = await auth0.signInWithEmailAndPassword(
                    email: username,
                    password: password,
                  );
                  Fluttertoast.showToast(
                    msg: S.current.logged,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    fontSize: 16.0,
                  );
                  Navigator.pop(context);
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: S.current.errorLogin,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  logger.errorException(e);
                }
              },
            ),
            TextButton(
              child: Text(S.current.register),
              onPressed: () async {
                final FirebaseAuth auth0 = FirebaseAuth.instance;
                try {
                  final result = await auth0.createUserWithEmailAndPassword(
                    email: username,
                    password: password,
                  );
                  logger.info(result.toString());
                  Fluttertoast.showToast(
                    msg: S.current.registered,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    fontSize: 16.0,
                  );
                  Navigator.pop(context);
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: S.current.errorRegister,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  logger.errorException(e);
                  Navigator.pop(context);
                }
              },
            ),
            TextButton(
              child: Text(S.current.logout),
              onPressed: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                Fluttertoast.showToast(
                  msg: S.current.loggedOut,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  fontSize: 16.0,
                );
                try {
                  await auth.signOut();
                } catch (e, s) {
                  logger.errorException(e, s);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
