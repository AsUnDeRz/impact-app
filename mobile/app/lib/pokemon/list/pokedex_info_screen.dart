import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/create/bloc/record_pokemon_bloc.dart';
import 'package:app/pokemon/repository/pokemon_repository.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class PokedexInfoScreen extends StatefulWidget {
  final GetPokemonEntity pokemon;
  const PokedexInfoScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokedexInfoScreen> createState() => _PokedexInfoScreenState();
}

class _PokedexInfoScreenState extends State<PokedexInfoScreen> {
  final RoundedLoadingButtonController _btnEditController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnRemoveController =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController _btnCancelEditController =
      RoundedLoadingButtonController();

  TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  bool requestEditName = false;

  void _confirmEditRecord(BuildContext context) async {
    if (nameController.text.isEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      _btnEditController.reset();
    }
    context.read<RecordPokemonBloc>().add(RecordPokemonEdited(
        GetPokemonEntity.fromJson(widget.pokemon.toJson())
          ..name = nameController.text));
  }

  void _confirmRemoveRecord(BuildContext context) {
    context.read<RecordPokemonBloc>().add(RecordPokemonRemoved(widget.pokemon));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.pokemon.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    _btnEditController.reset();
    _btnRemoveController.reset();
    return BlocProvider(
      create: (_) =>
          RecordPokemonBloc(repository: PokemonRepository(http.Client()))
            ..add(RecordPokemonInit(widget.pokemon)),
      child: BlocListener<RecordPokemonBloc, RecordPokemonState>(
        listener: (context, state) {
          if (state.status == RecordPokemonStatus.success) {
            _showMyDialogSuccess(state.pokemon);
            setState(() {
              requestEditName = false;
            });
          }

          if (state.status == RecordPokemonStatus.removed) {
            _showMyDialogRemoveSuccess();
          }
        },
        child: BlocBuilder<RecordPokemonBloc, RecordPokemonState>(
          builder: (context, state) {
            String title = '';
            if (state.pokemon != null) {
              title = "${state.pokemon?.name ?? ''} - ${state.pokemon?.num}";
            } else {
              title = "${widget.pokemon.name ?? ''} - ${widget.pokemon.num}";
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                backgroundColor: const Color(0xffED1729),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Hero(
                        tag: widget.pokemon.sId ?? '',
                        child: Image.network(
                          widget.pokemon.img ?? '',
                          width: MediaQuery.of(context).size.width - 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    requestEditName
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 10),
                                child: Text("Edit Name"),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 16),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      borderSide: BorderSide(
                                        width: 0.7,
                                        color: Color(0xffbababa),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        borderSide: BorderSide(
                                            width: 0.7,
                                            color: Color(0xffe0e0e0))),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
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
                              )
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.pokemon?.name ?? ''),
                              Text(state.pokemon?.num ?? ''),
                            ],
                          ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      child: RoundedLoadingButton(
                        animateOnTap: false,
                        borderRadius: 8,
                        color: const Color(0xffED1729),
                        child: Text(
                            requestEditName == false
                                ? 'Edit Name Record'
                                : 'Confirm Edit name',
                            style: const TextStyle(color: Colors.white)),
                        controller: _btnEditController,
                        onPressed: () async {
                          if (requestEditName == false) {
                            setState(() {
                              requestEditName = true;
                            });
                          } else {
                            _confirmEditRecord(context);
                          }
                        },
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 5),
                    )),
                    requestEditName == true
                        ? Expanded(
                            child: Padding(
                            child: RoundedLoadingButton(
                              animateOnTap: false,
                              borderRadius: 8,
                              color: Colors.grey,
                              child: const Text('Cancel Edit name',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                setState(() {
                                  requestEditName = false;
                                });
                              },
                              controller: _btnCancelEditController,
                            ),
                            padding: const EdgeInsets.only(left: 5, right: 10),
                          ))
                        : const SizedBox(),
                    requestEditName == false
                        ? Expanded(
                            child: Padding(
                            child: RoundedLoadingButton(
                              animateOnTap: false,
                              borderRadius: 8,
                              color: Colors.black54,
                              child: const Text('Remove record',
                                  style: TextStyle(color: Colors.white)),
                              controller: _btnRemoveController,
                              onPressed: () async {
                                _showMyDialogConfirmRemove(
                                    state.pokemon, context);
                              },
                            ),
                            padding: const EdgeInsets.only(left: 5, right: 10),
                          ))
                        : const SizedBox(),
                  ],
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
          title: const Text('Edited Record Complete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Pokemon has Edit name to Pokedex'),
                Text("My name : ${nameController.text}"),
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

  Future<void> _showMyDialogRemoveSuccess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Record Complete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Pokemon has removed from Pokedex'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                AppNavigator.pop('remove');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogConfirmRemove(
      GetPokemonEntity? pokemon, BuildContext ctxFromBloc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Confirm Remove Pokemon!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Do you want to remove ${nameController.text} from pokedex?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _confirmRemoveRecord(ctxFromBloc);
                },
              )
            ]);
      },
    );
  }
}
