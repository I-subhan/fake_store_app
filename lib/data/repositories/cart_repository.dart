import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import 'product_repository.dart';


class CartRepository {
  Future<List<CartItem>> getUserCart(int userId) async {
    final res =
    await DioClient.dio.get("${ApiConstants.carts}/user/$userId");

    final products = res.data[0]['products'] as List;

    return products.map((e) => CartItem.fromJson(e)).toList();
  }

  Future<void> addToCart(int userId, int productId) async {
    await DioClient.dio.post(
      ApiConstants.carts,
      data: {
        "userId": userId,
        "products": [
          {"productId": productId, "quantity": 1}
        ]
      },
    );
  }
}
