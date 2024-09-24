import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:ecommerce/MainScreens/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../responsive/responsive.dart';
import 'Cart/Cart.dart';
import 'Favorites/Favorites.dart';
import 'Home/HomePage.dart';
import 'Profile/ProfileScreen.dart';
import 'cubit/SearchModel/SearchModel.dart';
import 'cubit/main_cubit.dart';

class Mainscreen extends StatefulWidget {
  static final String routename = "Mainscreen";

  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  var Selectedindex = 0;
  List<Widget> Screens = [
    // Populate this with your screen widgets
   /* Center(child: Text('Home Screen'))*/
    Homepage(),
    Favorites(),
    Cart(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.isMobile(context) ? height / 12 : height / 10),
        child: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white,size: Responsive.isMobile(context) ?30:80,),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // يفتح Drawer عند الضغط
                },
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          title: LayoutBuilder(
            builder: (context, constraints) {
              double scaleFactor = constraints.maxWidth < 600 ? 2.2 : 0.5;
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Image.asset(
                  "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png",
                  scale: scaleFactor,
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: Responsive.isMobile(context) ? 30 : 70, // ضبط حجم الأيقونة
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
          flexibleSpace: Container(
            height: Responsive.isMobile(context) ? height / 12 : height / 10, // ضبط الارتفاع
            alignment: Alignment.center, // توسيط المحتوى
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png",
                fit: BoxFit.contain, // ضبط حجم الصورة لتتناسب مع المساحة المتاحة
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        width: width/1.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                children: [
                    Text(
                    'Tasawq',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ?25:35,
                    ),
                  ),
                 Image.asset(
                    "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png",
                    scale:Responsive.isMobile(context) ? 2.5:3,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle,size: Responsive.isMobile(context) ?20:50),
              title: Text('Profile',style: TextStyle(fontSize: Responsive.isMobile(context) ?20:80),),
              onTap: () {
                // تنفيذ إجراء معين
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,size: Responsive.isMobile(context) ?20:50),
              title: Text('Settings',style: TextStyle(fontSize: Responsive.isMobile(context) ?20:80),),
              onTap: () {
                // تنفيذ إجراء معين
              },
            ),
            ListTile(
              leading: Icon(Icons.logout,size: Responsive.isMobile(context) ?20:50),
              title: Text('Logout',style: TextStyle(fontSize: Responsive.isMobile(context) ?20:80),),
              onTap: () {
                // تنفيذ إجراء معين
              },
            ),
          ],
        ),
      ),

      body: Screens[Selectedindex], // Display the selected screen
      bottomNavigationBar: CurvedNavigationBar(
        index: Selectedindex,
        items:  <Widget>[
          Icon(Icons.home, size:Responsive.isMobile(context) ?  30:60),
          Icon(Icons.favorite, size:Responsive.isMobile(context) ?  30:60),
          Icon(Icons.shopping_bag, size: Responsive.isMobile(context) ?  30:60),
          Icon(Icons.person, size:Responsive.isMobile(context) ?  30:60),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.green,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            Selectedindex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    double iconSize = _getIconSize(context);
    return [
      IconButton(
        icon: Icon(CupertinoIcons.clear, size: iconSize),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    double iconSize = _getIconSize(context);
    return IconButton(
      icon: Icon(CupertinoIcons.back, size: iconSize),
      onPressed: () {
        close(context, "Back");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final bloc = context.read<MainCubit>();
    return FutureBuilder<List<Details>?>(
      future: bloc.getsearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data ?? [];
        final results = data
            .where((item) => item.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return ListTile(
              title: Text(item.description ?? ""),
              onTap: () {
                close(context, item.name ?? "");
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final bloc = context.read<MainCubit>();
    return FutureBuilder<List<Details>?>(
      future: bloc.getsearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: _getFontSize(context, 20, 60),
              ),
            ),
          );
        }

        final data = snapshot.data ?? [];
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final Suggestion = data[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(item: Suggestion),
                  ),
                );
              },
              child: Container(
                height: _getContainerHeight(context),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff58AD53),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          Suggestion.image ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: _getImageHeight(context),
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50),
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        Suggestion.name ?? "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: _getFontSize(context, 14, 18),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 7),
                      Text(
                        Suggestion.description ?? "",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: _getFontSize(context, 12, 14),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 7),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${Suggestion.price?.toString()} \$" ?? "N/A",
                          style: TextStyle(
                            color: const Color(0xff294C25),
                            fontSize: _getFontSize(context, 14, 16),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 10),
        );
      },
    );
  }

  // Helper method to calculate icon size based on screen size
  double _getIconSize(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 20;
    } else if (Responsive.isTablet(context)) {
      return 50; // Adjust for tablets
    } else {
      return 80; // For larger screens
    }
  }

  // Helper method to calculate font size based on screen size
  double _getFontSize(BuildContext context, double mobileSize, double largeSize) {
    if (Responsive.isMobile(context)) {
      return mobileSize;
    } else if (Responsive.isTablet(context)) {
      return (mobileSize + largeSize) / 2; // Adjust size for tablets
    } else {
      return largeSize;
    }
  }

  // Helper method to calculate container height based on screen size
  double _getContainerHeight(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 200;
    } else if (Responsive.isTablet(context)) {
      return 300; // Adjust for tablets
    } else {
      return 400; // For larger screens
    }
  }

  // Helper method to calculate image height based on screen size
  double _getImageHeight(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 100;
    } else if (Responsive.isTablet(context)) {
      return 200; // Adjust for tablets
    } else {
      return 250; // For larger screens
    }
  }
}


/*

    final bloc = context.read<MainCubit>();
    return FutureBuilder<List<Details>?>(
      future: bloc.getsearch(query), // Fetch suggestions based on the current query
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching data
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Show error message if there's an error
        }

        final data = snapshot.data ?? [];

        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Container(
              color: Colors.red,
              height: 100,
              child: ListTile(
                title: Text(item.name ?? ""),
                onTap: () {
                  query = item.name ?? "";
                  showResults(context);
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
        );
      },
    );*/


//    final results = _data.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
