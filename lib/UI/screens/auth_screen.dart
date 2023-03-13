import 'dart:io';

import '../widgets/in_case_signup.dart';
import '../../constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  Auth auth = Auth.login;
  bool _obscureTextPass = true;
  bool _obscureTextConfirmPass = true;
  final _key = GlobalKey<FormState>();
  bool isLoading = false;

  File? userImageFile;

  fetchImage(File? imageCapture) {
    userImageFile = imageCapture;
  }

  void _submit(BuildContext context) async {
    UserCredential userData;
    final authInstance = FirebaseAuth.instance;
    FocusScope.of(context).unfocus();
    if (!_key.currentState!.validate()) {
      return;
    } else {
      try {
        if (auth == Auth.login) {
          setState(() => isLoading = true);
          userData = await authInstance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        } else {
          if (userImageFile == null) {
            displayDialog(
              context: context,
              message: 'please picked image from \nyour camera or gallery.',
            );
            return;
          }
          setState(() => isLoading = true);
          userData = await authInstance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          /// add user image in FirebaseStorage
          final ref = FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(userData.user!.uid);
          await ref.putFile(userImageFile!);

          /// create image Url   after added in FirebaseStorage to use in app
          final userImage = await ref.getDownloadURL();
          FirebaseFirestore.instance
              .collection('users')
              .doc(userData.user!.uid)
              .set({
            'userName': _nameController.text.trim(),
            'userPassword': _passwordController.text.trim(),
            'userImage': userImage,
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() => isLoading = false);
        String errorMessage = 'Authentication field';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }

        displayDialog(context: context, message: errorMessage);
      } catch (error) {
        setState(() => isLoading = false);

        displayDialog(context: context, message: error.toString());
      }
    }
  }

  void _switchAuthMode() {
    if (auth == Auth.login) {
      setState(() => auth = Auth.signUp);
    } else if (auth == Auth.signUp) {
      setState(() => auth = Auth.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    TextTheme textContext = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xffffc300),
                      Color(0xffb04904),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1]),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: deviceSize.height * 0.03,
                  horizontal: deviceSize.width * 0.05,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        if (auth == Auth.signUp)
                          InCaseSignUp(
                            nameController: _nameController,
                            fetchImage: fetchImage,
                          ),
                        CustomField(
                          valueKey: 'email',
                          title: 'E-mail',
                          hint: 'enter your email',
                          controller: _emailController,
                          boardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomField(
                          valueKey: 'password',
                          title: 'Password',
                          hint: 'enter your password',
                          controller: _passwordController,
                          obscureText: _obscureTextPass,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureTextPass
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.black,
                              size: deviceSize.width * 0.06,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureTextPass = !_obscureTextPass;
                              });
                            },
                          ),
                          boardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'This password is too weak';
                            } else {
                              return null;
                            }
                          },
                        ),
                        if (auth == Auth.signUp)
                          CustomField(
                            valueKey: 'confirm password',
                            title: 'Confirm Password',
                            hint: 'enter your password',
                            boardType: TextInputType.text,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'The password is not match';
                              } else {
                                return null;
                              }
                            },
                            obscureText: _obscureTextConfirmPass,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureTextConfirmPass
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined,
                                color: Colors.black,
                                size: deviceSize.width * 0.06,
                              ),
                              onPressed: () {
                                setState(() => _obscureTextConfirmPass =
                                    !_obscureTextConfirmPass);
                              },
                            ),
                          ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () => _submit(context),
                                child: Text(
                                  auth == Auth.login ? 'Login' : 'Sign up',
                                ),
                              ),
                        SizedBox(height: deviceSize.height * 0.01),
                        Row(
                          children: [
                            Text(
                              auth == Auth.login
                                  ? 'Don\'t have an account ?'
                                  : 'Already have account',
                              style: textContext.bodySmall,
                            ),
                            TextButton(
                              onPressed: _switchAuthMode,
                              child: Text(
                                auth == Auth.login ? ' Sign up' : ' Login',
                                style: textContext.bodyMedium,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum Auth {
  login,
  signUp,
}
