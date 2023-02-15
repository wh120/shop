import '../../../../core/api/core_models/base_result_model.dart';
import '../../../../core/api/data_source/remote_data_source.dart';
import '../../../../core/api/http/api_urls.dart';
import '../../../../core/api/http/http_method.dart';
import '../../data/products_list_response.dart';

class ProductsRepository {

  static Future<BaseResultModel> getAllMyMedia(data) async {
    var res = await RemoteDataSource.request<ProductsList>(
      isLaravel: true,
        converter: (json) => ProductsList.fromJson(json),
        method: HttpMethod.get,
        queryParameters: data.toJson(),
        withAuthentication: false,

        url: ApiURLs.getAllProducts);
    return res;
  }
}