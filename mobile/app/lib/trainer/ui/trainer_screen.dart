import 'dart:async';

import 'package:app/routes.dart';
import 'package:app/trainer/bloc/trainer_bloc.dart';
import 'package:app/trainer/bloc/trainer_event.dart';
import 'package:app/trainer/bloc/trainer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class TrainerScreen extends StatefulWidget {
  const TrainerScreen({Key? key}) : super(key: key);

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _verifyTrainer(BuildContext context) async {
    if (emailController.text.isEmpty || firstNameController.text.isEmpty) {
      handleAnimateButtonFail();
      return;
    }
    context
        .read<TrainerBloc>()
        .add(TrainerVerified(emailController.text, firstNameController.text));
  }

  void handleAnimateButtonFail() async {
    _btnController.error();
    await Future.delayed(const Duration(seconds: 2));
    _btnController.reset();
  }

  void handleAnimateButtonSuccess() async {
    _btnController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrainerBloc(httpClient: http.Client()),
      child: Builder(builder: (context) {
        return BlocBuilder<TrainerBloc, TrainerState>(
          builder: (context, state) {
            if (state.status == TrainerStatus.failure) {
              handleAnimateButtonFail();
            }
            if (state.status == TrainerStatus.success ||
                state.status == TrainerStatus.initial) {
              handleAnimateButtonSuccess();
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Welcome Trainer'),
                backgroundColor: const Color(0xffED1729),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 48),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 48.0,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: emailFocusNode,
                      decoration: const InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        hintText: 'Email',
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffbababa),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide: BorderSide(
                                width: 0.7, color: Color(0xffe0e0e0))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffe0e0e0),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffbababa),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffbababa),
                          ),
                        ),
                        counterText: '',
                        errorStyle: TextStyle(
                          fontSize: 12.0,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 48.0,
                    child: TextFormField(
                      obscureText: true,
                      controller: firstNameController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: firstNameFocusNode,
                      decoration: const InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        hintText: 'FirstName',
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffbababa),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide: BorderSide(
                                width: 0.7, color: Color(0xffe0e0e0))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffe0e0e0),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffbababa),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          borderSide: BorderSide(
                            width: 0.7,
                            color: Color(0xffbababa),
                          ),
                        ),
                        counterText: '',
                        errorStyle: TextStyle(
                          fontSize: 12.0,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: RoundedLoadingButton(
                  color: const Color(0xffED1729),
                  child: const Text('Login Pokedex',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: () => _verifyTrainer(context),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
