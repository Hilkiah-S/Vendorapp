import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

uploadImages(List<String> imagePaths) async {
  final dio = Dio();
  List<MultipartFile> multipartImageFiles = [];

  for (var path in imagePaths) {
    multipartImageFiles.add(await MultipartFile.fromFile(path));
  }

  var formData = FormData.fromMap({
    "files": multipartImageFiles,
  });

  try {
    var response = await dio.post("https://api/", data: formData);
    print(response.data);
  } catch (e) {
    print(e);
  }
}
