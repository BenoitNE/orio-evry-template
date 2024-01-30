import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orio_evry_template/model/job_description.dart';
import 'package:orio_evry_template/service/file_converter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('convertFileToJobDescriptionList Test', () async {
   FileConverter fileConverter = FileConverter();
    List<JobDescription> jobDescriptions = await fileConverter.convertFileToJobDescriptionList();
    expect(jobDescriptions.length, equals(559));
  });

  test('getJobDescriptionMapList Test', () async {
    FileConverter fileConverter = FileConverter();
    List<Map<String, String>> itemMap = await fileConverter.getJobDescriptionMapList();
    expect(itemMap.length, equals(559));
  });
}