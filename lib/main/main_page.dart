import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/components/custom_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vendorapp/components/product_list.dart';
import 'package:vendorapp/components/profile_page.dart';
import 'package:vendorapp/components/tab_view.dart';
import 'package:vendorapp/custom_background.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/models/product_category.dart';
import 'package:vendorapp/models/product_details.dart';
import 'package:vendorapp/models/subCategories.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:vendorapp/screens/create_post.dart';
import 'package:dio/dio.dart';
import 'package:vendorapp/screens/notifications_page.dart';
import 'dart:convert';

import 'package:vendorapp/screens/postcomment.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  bool recievedTabs = false;
  bool recievedProducts = false;
  bool recievedProductsDetails = false;
  late bool tabsAndProucts = recievedProducts && recievedTabs;
  late TabController tabController;
  late TabController bottomTabController;
  int numberOfCategory = 5;
  List<ProductCategory> productCategories = [];
  List<ProductDetails> productDetailList = [];
  @override
  void initState() {
    super.initState();

    void getTabs() async {
      var secStore = SecureStorage();
      var token = await secStore.readSecureData('token');
      print("token on main page ${token}");
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );
      Response<Map> response = await Dio()
          .get("https://api.semer.dev/api/admin/category", options: options);

      print(response);

      List<dynamic> dataList = response.data?['data'];
      for (var item in dataList) {
        for (var eachkey in item.keys) {
          print("${eachkey}:${item.values}");
        }
      }
      dataList[0]['name'];
      print(dataList);
    }
  

    

  

    getTabs();
  
    int getNumberofTabs()async {

      return  a;
       }

    tabController = TabController(length: numberOfCategory, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () => {
                    Get.off(NotificationsPage()),
                  },
              icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () => {},
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );
    Widget tabBar = TabBar(
    
      tabs: [
        ...productCategories.map((e) => Tab(text: '${e.name}')).toList(),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: recievedProducts && recievedTabs && recievedProductsDetails
          ? CustomPaint(
              painter: MainBackground(),
              child: TabBarView(
                controller: bottomTabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SafeArea(
                    child: NestedScrollView(
                     
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        // These are the slivers that show up in the "outer" scroll view.
                        return <Widget>[
                          SliverToBoxAdapter(
                            child: appBar,
                          ),
                          SliverToBoxAdapter(
                            child: topHeader,
                          ),
                          SliverToBoxAdapter(
                            child: ProductList(),
                          ),
                          SliverToBoxAdapter(
                            child: tabBar,
                          )
                        ];
                      },
                      body: TabView(
                        tabController: tabController,
                        myproducts: productDetailList,
                      ),
                    ),
                  ),
                  CreatePost(),
                  ProfilePage(),
                  Comments(),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(child: CircularProgressIndicator())),
    );
  }
}
