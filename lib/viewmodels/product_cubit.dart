import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductState {
  final bool loading;
  final List<ProductModel> products;
  final String? error;

  ProductState({
    this.loading = false,
    this.products = const [],
    this.error,
  });
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.repo) : super(ProductState());

  final ProductRepository repo;

  Future<void> fetchProducts() async {
    emit(ProductState(loading: true));

    try {
      final products = await repo.getProducts();
      emit(ProductState(products: products));
    } catch (e) {
      emit(ProductState(error: "Failed to load products"));
    }
  }

  Future<void> filter(String category) async {
    emit(ProductState(loading: true));

    final list = await repo.getByCategory(category);
    emit(ProductState(products: list));
  }
}
