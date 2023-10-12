// import 'package:ecommerce_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/components/category_card.dart';
import 'package:vendorapp/models/category.dart';
import 'package:vendorapp/models/bundle_item.dart';
import 'package:vendorapp/models/product_details.dart';
import 'package:vendorapp/screens/productfinal_display.dart';
// import 'category_card.dart';
// import 'recommended_list.dart';

class TabView extends StatefulWidget {
  final TabController tabController;
  final List<ProductDetails> myproducts;
  TabView({
    required this.tabController,
    required this.myproducts,
  });

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int productnumber = 0;
  List<String> items = ["bag_1.png", "bag_2.png", "bag_3.png"];

  List<BundleT> entryitems = [];
  int total = 5;
  List<Category> categories = [
    Category(
      Color(0xffFCE183),
      'Gadgets',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF749A2),
      'Clothes',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff5189EA),
      'Fashion',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff632376),
      'Home',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff36E892),
      'Beauty',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF123C4),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];

  @override
  void initState() {
    setState(() {
      total = widget.myproducts.length;
    });
    entryitems.add(BundleT.fromMap({
      'pics': items,
      'title': "Bag",
      'description': "High end leather Bag",
      'price': 2000
    }));
    print(" this is from Listview Page${widget.myproducts[0].description}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: widget.tabController,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Container(
                //     margin: EdgeInsets.all(8.0),
                //     height: MediaQuery.of(context).size.height / 9,
                //     width: MediaQuery.of(context).size.width,
                //     child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: categories.length,
                //         itemBuilder: (_, index) => CategoryCard(
                //               category: categories[index],
                //             ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(
                    child: GridView.builder(
                        itemCount: widget.myproducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (_, index) {
                          return Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("One Box");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductFinalDisplay(
                                                    myproducts: widget
                                                        .myproducts[index])));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(6, 6),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Image.network(
                                          "${widget.myproducts[index].images[0].img_url}",
                                          fit: BoxFit.cover,
                                        )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      " ${widget.myproducts[index].name}",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      " ${widget.myproducts[index].description}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      " ${widget.myproducts[index].unit_price} ETB",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("1"))
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("2"))
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("3"))
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("4"))
          ]),
        ]);
  }
}
