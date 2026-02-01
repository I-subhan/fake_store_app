import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    final res = await DioClient.dio.get(ApiConstants.products);

    return (res.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  Future<ProductModel> getProduct(int id) async {
    final res = await DioClient.dio.get("${ApiConstants.products}/$id");
    return ProductModel.fromJson(res.data);
  }

  Future<List<String>> getCategories() async {
    final res = await DioClient.dio.get("/products/categories");
    return List<String>.from(res.data);
  }

  Future<List<ProductModel>> getByCategory(String category) async {
    final res =
    await DioClient.dio.get("/products/category/$category");

    return (res.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }




}
