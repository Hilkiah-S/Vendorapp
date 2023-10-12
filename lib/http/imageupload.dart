import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

uploadImages(List<String> imagePaths, String Category, String title,
    String description, int price, int quantity) async {
  final dio = Dio();
  var secStore = SecureStorage();
  var token = await secStore.readSecureData('token');
  final Options options = Options(
    headers: {
      "Authorization": "Bearer ${token}",
    },
  );
  List<MultipartFile> multipartImageFiles = [];

  for (var path in imagePaths) {
    multipartImageFiles.add(await MultipartFile.fromFile(path));
  }

  var formData = FormData.fromMap({
    "name": title,
    "product_img[]": multipartImageFiles,
    "unit_price": price,
    "description": description,
    "sku": quantity,
    "sub_category": 1,
    "discount": 10,
  });

  try {
    var response = await dio.post("https://api.semer.dev/api/product/create",
        data: formData, options: options);
    print(response.data);
  } catch (e) {
    print(e);
  }
}
