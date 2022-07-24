import 'package:app/pokemon/bloc/pokemon_bloc.dart';
import 'package:app/pokemon/bloc/pokemon_event.dart';
import 'package:app/pokemon/bloc/pokemon_state.dart';
import 'package:app/pokemon/ui/pokemon_item.dart';
import 'package:app/pokemon/widgets/bottom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return RefreshIndicator(child: Builder(builder: (context) {
          switch (state.status) {
            case PokemonStatus.failure:
              return const Center(child: Text('failed to fetch posts'));
            case PokemonStatus.success:
              if (state.pokemons.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return GridView.builder(
                  itemCount: state.hasReachedMax
                      ? state.pokemons.length
                      : state.pokemons.length + 1,
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return index >= state.pokemons.length
                        ? const BottomLoader()
                        : PokemonItem(
                            pokemon: state.pokemons[index],
                            key: ValueKey(state.pokemons[index]),
                          );
                  });
            default:
              return const Center(child: CircularProgressIndicator());
          }
        }), onRefresh: () {
          context.read<PokemonBloc>().add(PokemonPullToRefresh());
          return Future.value();
        });
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PokemonBloc>().add(PokemonFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
