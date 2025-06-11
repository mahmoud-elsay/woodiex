import 'dart:io';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_image_request.g.dart';

@JsonSerializable()
class UpdateEngineerProfileRequest {
  @JsonKey(fromJson: FileConverter.fromJson, toJson: FileConverter.toJson)
  final File? profileImageUrl;

  UpdateEngineerProfileRequest({
    this.profileImageUrl,
  });

  factory UpdateEngineerProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateEngineerProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEngineerProfileRequestToJson(this);

  Future<FormData> toFormData() async {
    final formData = FormData();
    if (profileImageUrl != null && await profileImageUrl!.exists()) {
      formData.files.add(
        MapEntry(
          'File', // Match the field name from the curl example (-F 'File=@...')
          await MultipartFile.fromFile(
            profileImageUrl!.path,
            filename: profileImageUrl!.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    return formData;
  }
}

class FileConverter {
  static File? fromJson(String? path) => path != null ? File(path) : null;
  static String? toJson(File? file) => file?.path;
}
