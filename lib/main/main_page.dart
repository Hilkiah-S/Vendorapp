import 'package:flutter/material.dart';
import 'package:vendorapp/components/custom_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vendorapp/components/product_list.dart';
import 'package:vendorapp/components/profile_page.dart';
import 'package:vendorapp/components/tab_view.dart';
import 'package:vendorapp/custom_background.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:vendorapp/screens/create_post.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late TabController tabController;
  late TabController bottomTabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
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
              onPressed: () => {},
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
              icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () => {},
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );
    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'Clothing'),
        Tab(text: 'Electronics'),
        Tab(text: 'Shoes'),
        Tab(text: 'Appliances'),
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
      body: CustomPaint(
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
                    // SliverToBoxAdapter(
                    //   child: topHeader,
                    // ),
                    // SliverToBoxAdapter(
                    //   child: ProductList(),
                    // ),
                    SliverToBoxAdapter(
                      child: tabBar,
                    )
                  ];
                },
                body: TabView(
                  tabController: tabController,
                ),
              ),
            ),
            CreatePost(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
