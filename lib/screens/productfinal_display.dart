import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vendorapp/models/bundle_item.dart';
import 'package:vendorapp/models/imageListModel.dart';
import 'package:vendorapp/models/product_details.dart';

class ProductFinalDisplay extends StatefulWidget {
  ProductDetails myproducts;
  ProductFinalDisplay({required this.myproducts});

  @override
  State<ProductFinalDisplay> createState() => _ProductFinalDisplayState();
}

class _ProductFinalDisplayState extends State<ProductFinalDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    viewportFraction: 1.0,
                  ),
                  items: widget.myproducts.images.map<Widget>((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(),
                          child: Image.network(
                            image.img_url,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.myproducts.name,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.myproducts.description}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.myproducts.unit_price} ETB",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Remove",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: Size(140, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
