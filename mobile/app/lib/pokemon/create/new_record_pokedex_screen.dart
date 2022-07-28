import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/create/bloc/record_pokemon_bloc.dart';
import 'package:app/pokemon/repository/pokemon_repository.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class NewRecordPokedexScreen extends StatefulWidget {
  const NewRecordPokedexScreen({Key? key}) : super(key: key);

  @override
  State<NewRecordPokedexScreen> createState() => _NewRecordPokedexScreenState();
}

class _NewRecordPokedexScreenState extends State<NewRecordPokedexScreen> {
  final TextEditingController urlImageController = TextEditingController();
  final FocusNode urlImageFocusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _confirmRecord(BuildContext context) async {
    if (nameController.text.isEmpty || urlImageController.text.isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      _btnController.reset();
      return;
    }
    context.read<RecordPokemonBloc>().add(
        RecordPokemonCreated(nameController.text, urlImageController.text));
  }

  @override
  Widget build(BuildContext context) {
    _btnController.reset();
    return BlocProvider(
      create: (_) =>
          RecordPokemonBloc(repository: PokemonRepository(http.Client())),
      child: BlocListener<RecordPokemonBloc, RecordPokemonState>(
        listener: (context, state) {
          if (state.status == RecordPokemonStatus.success) {
            _showMyDialogSuccess(state.pokemon);
          }
        },
        child: BlocBuilder<RecordPokemonBloc, RecordPokemonState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('New Record Pokedex'),
                backgroundColor: const Color(0xffED1729),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    urlImageController.text.isEmpty
                        ? const SizedBox()
                        : Image.network(urlImageController.text),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 48.0,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {});
                          }
                        },
                        controller: urlImageController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: urlImageFocusNode,
                        decoration: const InputDecoration(
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          hintText: 'add url image',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
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
                        onChanged: (value) {},
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: nameFocusNode,
                        decoration: const InputDecoration(
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          hintText: 'Pokemon Name',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
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
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: RoundedLoadingButton(
                  color: const Color(0xffED1729),
                  child: const Text('Confirm Record',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: () => _confirmRecord(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showMyDialogSuccess(GetPokemonEntity? pokemon) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Record Complete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('New Pokemon has Added to Pokedex'),
                Text("Welcome ${nameController.text}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                AppNavigator.pop(pokemon);
              },
            ),
          ],
        );
      },
    );
  }
}
