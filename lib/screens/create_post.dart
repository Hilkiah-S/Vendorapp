import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:vendorapp/http/imageupload.dart';
import 'package:vendorapp/http/signup.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final dio = Dio();
  // @override
  // void initState() {
  //   var token = "19|gr9lCSK37ShkApKVDvbf0QhjKsZmPGBkcQXAk4Kp15d0ca0f";
  //   final Options options = Options(
  //     headers: {
  //       "Authorization": "Bearer ${token}",
  //     },
  //   );

  //   void send() async {
  //     try {
  //       var response = await dio.get("https://api.semer.dev/api/product/create",
  //           options: options);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }

  //   send();

  //   // TODO: implement init
  //   //
  //   // State
  //   super.initState();
  // }

  // File? _image;
  // PickedFile? _pickedFile;
  // final _picker = ImagePicker();
  // Future<void> _pickImage() async {
  //   // _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  // }
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> adresses = [];
  final List<String> items = [
    'Clothing',
    'Electronics',
    'Shoes',
    'Appliances',
  ];
  String selecteddropdownValue = "Clothing";
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;

        setState(() {});
        adresses.clear();
        adresses = imagefiles!.map((imageone) => imageone.path).toList();
        print(adresses);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(222, 229, 225, 225),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              controller: title,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            248, 114, 57, 0.698)),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              248, 114, 57, 0.698)),
                                      borderRadius: BorderRadius.circular(5.5)),
                                  labelText: "Title for your Product",
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(248, 114, 57, 0.698),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            child: TextFormField(
                              controller: description,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            248, 114, 57, 0.698)),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              248, 114, 57, 0.698)),
                                      borderRadius: BorderRadius.circular(5.5)),
                                  labelText: "Description for your Product",
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(248, 114, 57, 0.698),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Category: ",
                              style: TextStyle(
                                  color: Color.fromRGBO(248, 114, 57, 0.698),
                                  fontSize: 15),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                  color: Colors.white,
                                )),
                                isExpanded: true,
                                hint: Text(
                                  'Select Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: items.map((String item) {
                                  print('debug item $item');
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(
                                              248, 114, 57, 0.698)),
                                    ),
                                  );
                                }).toList(),
                                value: selecteddropdownValue,
                                onChanged: (String? value) {
                                  print('debug onchage called $value');

                                  setState(() {
                                    selecteddropdownValue = value!;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    )),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              controller: price,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            248, 114, 57, 0.698)),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              248, 114, 57, 0.698)),
                                      borderRadius: BorderRadius.circular(5.5)),
                                  labelText: "Price for your Product ",
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(248, 114, 57, 0.698),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              controller: quantity,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            248, 114, 57, 0.698)),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              248, 114, 57, 0.698)),
                                      borderRadius: BorderRadius.circular(5.5)),
                                  labelText: "Qunantity of this product ",
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(248, 114, 57, 0.698),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                openImages();
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(300, 45),
                                backgroundColor:
                                    Color.fromRGBO(123, 120, 119, 0.694),
                              ),
                              child: Text(
                                "Browse Image",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Arial'),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                imagefiles != null
                                    ? Wrap(
                                        alignment: WrapAlignment.start,
                                        children: imagefiles!.map((imageone) {
                                          return Container(
                                              child: Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              height: 100,
                                              width: 100,
                                              child: Image.file(
                                                  File(imageone.path)),
                                            ),
                                          ));
                                        }).toList(),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          child: Image.asset(
                                              "assets/icons/box.png"),
                                        ),
                                      ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                uploadImages(
                                  adresses,
                                  selecteddropdownValue,
                                  title.text,
                                  description.text,
                                  int.parse(price.text),
                                  int.parse(quantity.text),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(300, 65),
                                backgroundColor:
                                    const Color.fromARGB(255, 49, 207, 54),
                              ),
                              child: Text(
                                "Post",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Arial'),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
