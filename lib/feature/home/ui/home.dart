import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/cart/ui/cart.dart';
import 'package:grocery_app/feature/home/bloc/home_bloc.dart';
import 'package:grocery_app/feature/wishlist/ui/Wishlist.dart';

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
           listenWhen: (previous, current) => current is homeActionState,
           buildWhen: (previous, current) => current is !homeActionState,
      listener: (context, state) {
        if (state is homeNavitageToCartPageActionSate) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is homeNavitageToWishlistPageActionSate) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case homeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case homeLoadedSuccessState:
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('KIZO SHOPPING MALL'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent());
                      },
                      icon: Icon(Icons.shopping_basket))
                ],
              ),
            );
          case homeErrorState:
            return Scaffold(
              body: Center(
                child: Text('error'),
              ),
            );
        }
      },
    );
  }
}
