import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orio_evry_template/model/job_description.dart';
import 'package:orio_evry_template/service/file_converter.dart';

void main() {
  test('convertFileToJobDescriptionList Test', () {
   FileConverter fileConverter = FileConverter();
    List<JobDescription> jobDescriptions = fileConverter.convertFileToJobDescriptionList();
    expect(jobDescriptions.length, equals(559));
  });

  test('getJobDescriptionMapList Test', () {
    FileConverter fileConverter = FileConverter();
    List<Map<String, String>> itemMap = fileConverter.getJobDescriptionMapList();
    expect(itemMap.length, equals(559));
  });
}