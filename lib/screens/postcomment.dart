import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/screens/app_properties.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Text(
                    "Comment",
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#4f4f4f"),
                    ),
                  ),
                  TextField(
                    controller: comment,
                    maxLines: 7,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.comment),
                      // Add a label here
                      hintText: "Your comment, here",
                      fillColor: HexColor("#f0f3f1"),
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: HexColor("#8d8d8d"),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (comment.text != null) {
                        Comment_post(comment.text);
                      } else {
                        Get.snackbar("Error", "Comment can not be Empty");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
                        height: 55,
                        width: 275,
                        decoration: BoxDecoration(
                          color: HexColor('#44564a'),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Comment",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]))),
          )),
    );
  }

  Comment_post(String comment) async {
    final dio = Dio();
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );

    try {
      var response =
          await dio.post("https://api.semer.dev/api/news/comment/create/",
              data: {
                "text": comment,
                "news_id": 4,
              },
              options: options);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
