import 'package:bloc/bloc.dart';
import 'package:elwarsha/Presentation/Screens/store/item.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static int price = 0;

  static List<Item> selectedProducts = [];


}
