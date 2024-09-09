import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/cart/ui/cart.dart';
import 'package:grocery_app/feature/home/bloc/home_bloc.dart';
import 'package:grocery_app/feature/home/ui/product_tile_widget.dart';
import 'package:grocery_app/feature/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: HomeBloc(),
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavitageToCartPageActionSate) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavitageToWishlistPageActionSate) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));

          case const (HomeLoadedSuccessState):
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.teal,
                title: const Text('KIZO SHOPPING MALL'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent());
                      },
                      icon: const Icon(Icons.shopping_basket))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTleWidget(
                        productDataModel: successState.products[index]);
                  }),
            );
          // ignore: type_literal_in_constant_pattern
          case HomeErrorState:
            return const Scaffold(body: Center(child: Text('error')));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
