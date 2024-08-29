import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:ecommerce/MainScreens/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

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
      appBar: AppBar(
        leading: PopupMenuButton<int>(
          icon: const Icon(Icons.menu, color: Colors.white),
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Account"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Settings"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Logout"),
              ),
            ];
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png",
              scale: 2.2,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Screens[Selectedindex], // Display the selected screen
      bottomNavigationBar: CurvedNavigationBar(
        index: Selectedindex,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.shopping_bag, size: 30),
          Icon(Icons.person, size: 30),
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
    return [
      IconButton(
        icon: Icon(CupertinoIcons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(CupertinoIcons.back),
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
        print("name :${snapshot.data?.first.name}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching data
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Show error message if there's an error
        }
        final data = snapshot.data ?? [];
        final results = data.where((item) => item.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
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
        future: bloc.getsearch(query),// ال list تتخزن
        builder:(context,snapshot){
          print("name :${snapshot.data?.first.name}");
          if (snapshot.connectionState== ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError)
            {
              return Center(child: Text("Erorr",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 60),),);
            }
          final data = snapshot.data??[];
          return  ListView.separated(
              itemCount: data.length,
              itemBuilder: (context,index){
                 final Suggestion=data[index];
                 return GestureDetector(
                   onTap: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => DetailPage(item: Suggestion),
                       ),
                     );
                   },
                   child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff58AD53)
                    ),
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),

                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           // Image with fit and styling
                           ClipRRect(
                             borderRadius: BorderRadius.circular(20), // Rounded corners for the image
                             child: Image.network(
                               Suggestion.image ?? "",
                               fit: BoxFit.cover, // Ensures the image covers the area
                               width: double.infinity,
                               height: 250,
                               errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50), // Fallback in case of error
                             ),
                           ),
                           SizedBox(height: 7),
                           // Title with styling and alignment
                           Text(
                             Suggestion.name ?? "",
                             style: const TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                             ),
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                           ),
                           SizedBox(height: 7),
                           // Description with styling and alignment
                           Text(
                             Suggestion.description ?? "",
                             style: TextStyle(
                               color: Colors.grey[700],
                               fontSize: 14,
                             ),
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                           ),
                           SizedBox(height: 7),
                           // Price with styling and alignment
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Text(
                               "${Suggestion.price?.toString()} \$ "?? "N/A",
                               style: const TextStyle(
                                 color: Color(0xff294C25),
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold,
                               ),
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                             ),
                           ),
                         ],
                       ),
                     ) ,
                   ),
                 );



              },
            separatorBuilder: (context, index) => SizedBox(height: 10), // Adds 10 pixels of space between items
              );

    } );














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
