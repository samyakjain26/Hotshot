import 'package:flutter/material.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:hotshot/services/google_auth.dart';
import 'package:hotshot/constants/loading.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:lottie/lottie.dart';

class ShopkeeperSignIn extends StatefulWidget {
  const ShopkeeperSignIn({super.key});

  @override
  State<ShopkeeperSignIn> createState() => _ShopkeeperSignInState();
}

class _ShopkeeperSignInState extends State<ShopkeeperSignIn> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: Center(
              child: Stack(
                children: [
                  Image.asset('assets/iitg2.jpg'),
                  Container(),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 550,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30))),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Lottie.asset('assets/signin1.json',
                                      repeat: false),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Welcome to Hotshot! Your one stop solution to everything',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: Image.asset(
                                          'assets/google.png',
                                          width: 32,
                                          height: 32,
                                        ),
                                        label: const Text(
                                          'Sign in with Google',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });

                                          await SharedPrefs()
                                              .setIsCustomer(false);
                                          await GoogleAuthentication()
                                              .googleSignIn();
                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                      ),
                                    ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
