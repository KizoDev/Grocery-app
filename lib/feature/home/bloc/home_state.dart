part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class homeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class homeLoadingState extends HomeState {}

class homeLoadedSuccessState extends HomeState {
  final List<productDataModel> products;

  homeLoadedSuccessState({required this.products});
}

class homeErrorState extends HomeState {}

class homeNavitageToWishlistPageActionSate extends homeActionState {}

class homeNavitageToCartPageActionSate extends homeActionState {}
