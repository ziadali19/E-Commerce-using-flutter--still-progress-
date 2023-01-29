import 'package:e_commerce/features/cart/presentaion/screens/cart_screen.dart';
import 'package:e_commerce/features/categories/presentaion/screens/categories_screen.dart';

import 'package:e_commerce/features/settings/presentation/screens/my_account_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favorite/presentation/screens/favtorite_screen.dart';
import '../../presentation/screens/home_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) {
    return BlocProvider.of(context);
  }

  //bottom navbar change index
  int currentIndex = 0;
  navBar(int newIndex) {
    currentIndex = newIndex;
    emit(ChangeNavBarIndex());
  }

  //screens list
  List screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const MyAccountScreen()
  ];
  List titles = ['', 'Categories', 'Favorite', 'Cart', 'My Account'];
}
