/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the ToDoModel type in your schema. */
@immutable
class ToDoModel extends Model {
  static const classType = const _ToDoModelModelType();
  final String id;
  final String title;
  final bool isComplete;
  final TemporalDate dueDt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ToDoModel._internal(
      {@required this.id, this.title, this.isComplete, this.dueDt});

  factory ToDoModel(
      {String id, String title, bool isComplete, TemporalDate dueDt}) {
    return ToDoModel._internal(
        id: id == null ? UUID.getUUID() : id,
        title: title,
        isComplete: isComplete,
        dueDt: dueDt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ToDoModel &&
        id == other.id &&
        title == other.title &&
        isComplete == other.isComplete &&
        dueDt == other.dueDt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ToDoModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$title" + ", ");
    buffer.write("isComplete=" +
        (isComplete != null ? isComplete.toString() : "null") +
        ", ");
    buffer.write("dueDt=" + (dueDt != null ? dueDt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  ToDoModel copyWith(
      {String id, String title, bool isComplete, TemporalDate dueDt}) {
    return ToDoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        isComplete: isComplete ?? this.isComplete,
        dueDt: dueDt ?? this.dueDt);
  }

  ToDoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isComplete = json['isComplete'],
        dueDt = json['dueDt'] != null
            ? TemporalDate.fromString(json['dueDt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isComplete': isComplete,
        'dueDt': dueDt?.format()
      };

  static final QueryField ID = QueryField(fieldName: "toDoModel.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField ISCOMPLETE = QueryField(fieldName: "isComplete");
  static final QueryField DUEDT = QueryField(fieldName: "dueDt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ToDoModel";
    modelSchemaDefinition.pluralName = "ToDoModels";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ToDoModel.TITLE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ToDoModel.ISCOMPLETE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ToDoModel.DUEDT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));
  });
}

class _ToDoModelModelType extends ModelType<ToDoModel> {
  const _ToDoModelModelType();

  @override
  ToDoModel fromJson(Map<String, dynamic> jsonData) {
    return ToDoModel.fromJson(jsonData);
  }
}
