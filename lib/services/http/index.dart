import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/model/populartv_model.dart';
import 'package:test/services/http/api.dart';

class PopularTV extends Api {
  PopularTV();
  final api_key = dotenv.env["API_KEY"];
  Future<Populartv_Model> me() async {
    final res = await Api.get("$apiUrl/3/tv/popular?api_key=$api_key");
    return Populartv_Model.fromJson(res.data);
  }
}
