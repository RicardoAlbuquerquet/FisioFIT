/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;

/** This is an auto generated class representing the Login type in your schema. */
class Login extends amplify_core.Model {
  static const classType = const _LoginModelType();
  final String id;
  final String? _login_email_aws;
  final String? _password_string;
  final String? _User_string_name;
  final amplify_core.TemporalDate? _User_date_Birthday;
  final String? _User_int_phone;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  LoginModelIdentifier get modelIdentifier {
    return LoginModelIdentifier(id: id);
  }

  String get login_email_aws {
    try {
      return _login_email_aws!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get password_string {
    try {
      return _password_string!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String? get User_string_name {
    return _User_string_name;
  }

  amplify_core.TemporalDate? get User_date_Birthday {
    return _User_date_Birthday;
  }

  String? get User_int_phone {
    return _User_int_phone;
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const Login._internal(
      {required this.id,
      required login_email_aws,
      required password_string,
      User_string_name,
      User_date_Birthday,
      User_int_phone,
      createdAt,
      updatedAt})
      : _login_email_aws = login_email_aws,
        _password_string = password_string,
        _User_string_name = User_string_name,
        _User_date_Birthday = User_date_Birthday,
        _User_int_phone = User_int_phone,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory Login(
      {String? id,
      required String login_email_aws,
      required String password_string,
      String? User_string_name,
      amplify_core.TemporalDate? User_date_Birthday,
      String? User_int_phone}) {
    return Login._internal(
        id: id == null ? amplify_core.UUID.getUUID() : id,
        login_email_aws: login_email_aws,
        password_string: password_string,
        User_string_name: User_string_name,
        User_date_Birthday: User_date_Birthday,
        User_int_phone: User_int_phone);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Login &&
        id == other.id &&
        _login_email_aws == other._login_email_aws &&
        _password_string == other._password_string &&
        _User_string_name == other._User_string_name &&
        _User_date_Birthday == other._User_date_Birthday &&
        _User_int_phone == other._User_int_phone;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Login {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("login_email_aws=" + "$_login_email_aws" + ", ");
    buffer.write("password_string=" + "$_password_string" + ", ");
    buffer.write("User_string_name=" + "$_User_string_name" + ", ");
    buffer.write("User_date_Birthday=" +
        (_User_date_Birthday != null ? _User_date_Birthday!.format() : "null") +
        ", ");
    buffer.write("User_int_phone=" + "$_User_int_phone" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Login copyWith(
      {String? login_email_aws,
      String? password_string,
      String? User_string_name,
      amplify_core.TemporalDate? User_date_Birthday,
      String? User_int_phone}) {
    return Login._internal(
        id: id,
        login_email_aws: login_email_aws ?? this.login_email_aws,
        password_string: password_string ?? this.password_string,
        User_string_name: User_string_name ?? this.User_string_name,
        User_date_Birthday: User_date_Birthday ?? this.User_date_Birthday,
        User_int_phone: User_int_phone ?? this.User_int_phone);
  }

  Login copyWithModelFieldValues(
      {ModelFieldValue<String>? login_email_aws,
      ModelFieldValue<String>? password_string,
      ModelFieldValue<String?>? User_string_name,
      ModelFieldValue<amplify_core.TemporalDate?>? User_date_Birthday,
      ModelFieldValue<String?>? User_int_phone}) {
    return Login._internal(
        id: id,
        login_email_aws: login_email_aws == null
            ? this.login_email_aws
            : login_email_aws.value,
        password_string: password_string == null
            ? this.password_string
            : password_string.value,
        User_string_name: User_string_name == null
            ? this.User_string_name
            : User_string_name.value,
        User_date_Birthday: User_date_Birthday == null
            ? this.User_date_Birthday
            : User_date_Birthday.value,
        User_int_phone: User_int_phone == null
            ? this.User_int_phone
            : User_int_phone.value);
  }

  Login.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _login_email_aws = json['login_email_aws'],
        _password_string = json['password_string'],
        _User_string_name = json['User_string_name'],
        _User_date_Birthday = json['User_date_Birthday'] != null
            ? amplify_core.TemporalDate.fromString(json['User_date_Birthday'])
            : null,
        _User_int_phone = json['User_int_phone'],
        _createdAt = json['createdAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'login_email_aws': _login_email_aws,
        'password_string': _password_string,
        'User_string_name': _User_string_name,
        'User_date_Birthday': _User_date_Birthday?.format(),
        'User_int_phone': _User_int_phone,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'login_email_aws': _login_email_aws,
        'password_string': _password_string,
        'User_string_name': _User_string_name,
        'User_date_Birthday': _User_date_Birthday,
        'User_int_phone': _User_int_phone,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final amplify_core.QueryModelIdentifier<LoginModelIdentifier>
      MODEL_IDENTIFIER =
      amplify_core.QueryModelIdentifier<LoginModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final LOGIN_EMAIL_AWS =
      amplify_core.QueryField(fieldName: "login_email_aws");
  static final PASSWORD_STRING =
      amplify_core.QueryField(fieldName: "password_string");
  static final USER_STRING_NAME =
      amplify_core.QueryField(fieldName: "User_string_name");
  static final USER_DATE_BIRTHDAY =
      amplify_core.QueryField(fieldName: "User_date_Birthday");
  static final USER_INT_PHONE =
      amplify_core.QueryField(fieldName: "User_int_phone");
  static var schema = amplify_core.Model.defineSchema(
      define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Login";
    modelSchemaDefinition.pluralName = "Logins";

    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
          authStrategy: amplify_core.AuthStrategy.PUBLIC,
          operations: const [
            amplify_core.ModelOperation.CREATE,
            amplify_core.ModelOperation.UPDATE,
            amplify_core.ModelOperation.DELETE,
            amplify_core.ModelOperation.READ
          ])
    ];

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Login.LOGIN_EMAIL_AWS,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Login.PASSWORD_STRING,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Login.USER_STRING_NAME,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Login.USER_DATE_BIRTHDAY,
        isRequired: false,
        ofType:
            amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.date)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: Login.USER_INT_PHONE,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
            fieldName: 'createdAt',
            isRequired: false,
            isReadOnly: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
            fieldName: 'updatedAt',
            isRequired: false,
            isReadOnly: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)));
  });
}

class _LoginModelType extends amplify_core.ModelType<Login> {
  const _LoginModelType();

  @override
  Login fromJson(Map<String, dynamic> jsonData) {
    return Login.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'Login';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Login] in your schema.
 */
class LoginModelIdentifier implements amplify_core.ModelIdentifier<Login> {
  final String id;

  /** Create an instance of LoginModelIdentifier using [id] the primary key. */
  const LoginModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'LoginModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LoginModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
