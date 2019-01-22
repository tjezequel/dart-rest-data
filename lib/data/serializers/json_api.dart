import 'dart:convert';

import 'package:cinderblock/data/interfaces.dart';

class JsonApiSerializer implements Serializer {
  @override
  JsonApiDocument deserializeOne(String payload) {
    Map<String, dynamic> parsed = json.decode(payload);
    return JsonApiDocument(
        parsed['data']['attributes'], parsed['data']['relationships']);
  }

  @override
  Iterable<JsonApiDocument> deserializeMany(String payload) {
    Map<String, dynamic> parsed = json.decode(payload);
    return (parsed['data'] as List).map(
        (item) => JsonApiDocument(item['attributes'], item['relationships']));
  }

  @override
  String serialize(dynamic document) {
    if (document is JsonApiDocument) {
      return json.encode({
        'data': {
          'attributes': document.attributes,
          'relationships': document.relationships
        }
      });
    } else {
      throw ArgumentError('document must be a JsonApiDocument');
    }
  }
}

class JsonApiDocument {
  Map<String, dynamic> attributes;
  Map<String, dynamic> relationships;

  JsonApiDocument(this.attributes, this.relationships);
}