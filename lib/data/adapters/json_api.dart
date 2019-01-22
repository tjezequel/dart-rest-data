import 'package:cinderblock/data/adapters/mixins/http.dart';
import 'package:cinderblock/data/interfaces.dart';
import 'package:cinderblock/data/serializers/json_api.dart';
import 'package:http/http.dart';

class JsonApiAdapter extends Adapter with Http {
  String apiPath;

  JsonApiAdapter(hostname, this.apiPath) : super(JsonApiSerializer()) {
    this.hostname = hostname;
  }

  @override
  Future<JsonApiDocument> find(String endpoint, String id) async {
    final response = await httpGet("$endpoint/$id");
    String payload = checkAndDecode(response);
    return serializer.deserializeOne(payload);
  }

  @override
  Future<Iterable<JsonApiDocument>> findAll(String endpoint) {
    // TODO: implement findAll
    return null;
  }

  @override
  Future<Iterable<JsonApiDocument>> query(
      String endpoint, Map<String, String> params) {
    // TODO: implement query
    return null;
  }

  @override
  Future<JsonApiDocument> save(String endpoint, dynamic document) {
    if (document is JsonApiDocument) {
      // TODO: implement save
      return null;
    } else {
      throw ArgumentError('document must be a JsonApiDocument');
    }
  }

  @override
  Future delete(String endpoint, dynamic document) {
    if (document is JsonApiDocument) {
      // TODO: implement delete
      return null;
    } else {
      throw ArgumentError('document must be a JsonApiDocument');
    }
  }

  Future<Response> httpGet(String relativePath) async {
    return await client.get(uriFor("$apiPath/$relativePath"), headers: headers);
  }
}