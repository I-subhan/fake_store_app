import 'package:bloc/bloc.dart';
import 'package:fake_store_app/data/repositories/cart_repository.dart';
import '../data/models/product_model.dart';
import '../data/models/cart_item.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit(CartRepository cartRepository) : super([]);


  void addToCart(ProductModel product, int quantity) {

    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {

      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + quantity,
      );
      final newState = List<CartItem>.from(state);
      newState[index] = updatedItem;
      emit(newState);
    } else {

      emit([...state, CartItem(product: product, quantity: quantity)]);
    }
  }


  void remove(int index) {
    final newState = List<CartItem>.from(state);
    newState.removeAt(index);
    emit(newState);
  }


  void increase(int index) {
    final newState = List<CartItem>.from(state);
    newState[index] =
        newState[index].copyWith(quantity: newState[index].quantity + 1);
    emit(newState);
  }


  void decrease(int index) {
    final newState = List<CartItem>.from(state);
    if (newState[index].quantity > 1) {
      newState[index] =
          newState[index].copyWith(quantity: newState[index].quantity - 1);
      emit(newState);
    }
  }


  double get totalPrice {
    return state.fold(
        0,
            (previousValue, element) =>
        previousValue + element.product.price * element.quantity);
  }


  void loadCart(int userId) {

    emit(state);
  }
}
