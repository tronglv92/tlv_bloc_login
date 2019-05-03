import 'package:test_serializers/service/core/models/base_response_message.dart';
import 'package:test_serializers/service/models/category.dart';
import 'package:test_serializers/service/core/network/network_utils.dart';

class CategoryApi{
  static List<Category> listCategoryFromJson(Object o)
  {
    var list = o as List ;

    List<Category> categories = list.map((i) => Category.fromJson(i)).toList();
    return categories;
  }
//  static Auth authFromJson(Object o)
//  {
//    Auth auth = Auth.fromJson(o);
//    return auth;
//  }

  static Future<List<Category>> getCategory() async{
    String url = "/categories/categories?page=1&pageSize=20";
    Map<String,dynamic> response = await NetworkUtils().request(url,"GET");
    BaseResponseMessage result = BaseResponseMessage<List<Category>>.fromJson(response,listCategoryFromJson);

    return result.data;
  }
//  static Future<Auth> login() async{
//    String url = "/auth/signIn";
//    var data={ "email": "bss.team.dev@gmail.com",
//      "password": "Bss12345",
//      "device_platform": "ios",
//      "device_token": "a437dd18254449779569cc1322a87791a426ad0c3e33aaf92379fac65d89758e"};
//    Map<String,dynamic> response = await NetworkUtils().request(url,"POST",data: data);
//    BaseResponseMessage result = BaseResponseMessage<Auth>.fromJson(response,authFromJson);
//
//    return result.data;
//  }
}