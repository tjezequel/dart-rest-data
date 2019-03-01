import 'package:cinderblock/data/interfaces.dart';
import 'package:cinderblock/data/serializers/json_api.dart';

class JsonApiModel implements Model {
  JsonApiDocument jsonApiDoc;

  JsonApiModel(this.jsonApiDoc);

  JsonApiModel.create(String type, Map<String, dynamic> attributes,
      [Map<String, dynamic> relationships]) {
    jsonApiDoc = JsonApiDocument.create(type, attributes, relationships);
  }

  Map<String, dynamic> get attributes => jsonApiDoc.attributes;
  Map<String, dynamic> get relationships => jsonApiDoc.relationships;
  Iterable<dynamic> get included => jsonApiDoc.included;
  Iterable<dynamic> get errors => jsonApiDoc.errors;

  @override
  String get id => jsonApiDoc.id;

  @override
  String get type => jsonApiDoc.type;

  bool get isNew => jsonApiDoc.isNew;

  bool get hasErrors => errors.isNotEmpty;

  @override
  String serialize() => JsonApiSerializer().serialize(jsonApiDoc);

  String idFor(String relationshipName) => jsonApiDoc.idFor(relationshipName);

  Iterable<String> idsFor(String relationshipName) =>
      jsonApiDoc.idsFor(relationshipName);

  Iterable<JsonApiDocument> includedDocs(String type) {
    return included.where((record) => record['type'] == type).map((record) =>
        JsonApiDocument(record['id'], record['type'], record['attributes'],
            record['relationships']));
  }

  Iterable<String> errorsFor(String attributeName) {
    return errors
        .where((error) =>
            error['source']['pointer'] == "/data/attributes/$attributeName")
        .map((error) => error['detail']);
  }

  void setHasOne(String relationshipName, JsonApiModel model) {
    if (relationships.containsKey(relationshipName)) {
      relationships[relationshipName]['data']['id'] = model.id;
    } else
      relationships[relationshipName] = {
        'data': {'id': model.id, 'type': model.type}
      };
  }
}
