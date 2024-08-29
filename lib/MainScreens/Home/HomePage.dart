import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import the carousel_slider package

import '../DetailPage.dart';
import 'Banners/BannersDatamdel.dart';
import 'HomepageModel/HomeModel.dart';
import 'home_cubit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Carousel
            SizedBox(
              height: height / 4,
              child: FutureBuilder<List<Bannerdata>?>(
                future: HomeCubit().getbanners(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  final data = snapshot.data ?? [];

                  return CarouselSlider(
                    items: data.map((item) {
                      return Container(
                        width: width,
                        height: height / 5,
                        child: item.image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Rounded corners for the image
                          child: Image.network(
                            item.image!,
                            fit: BoxFit.cover, // Ensures the image covers the area
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress.expectedTotalBytes != null
                                      ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50), // Fallback in case of error
                          ),
                        )
                            : SizedBox(width: 20), // Placeholder if image is null
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: height / 5,
                      aspectRatio: 16 / 9,
                      viewportFraction: .9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
            ),
            FutureBuilder<List<HomeProducts>?>(
              future: HomeCubit().getproducts(), // Fetch the products
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                final data = snapshot.data ?? [];
                print("data length: ${data.length}");

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    final double price = item.price ?? 0.0;
                    final double oldPrice = item.oldPrice ?? 0.0;
                    final int discount = item.discount ?? 0;

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(item: item),
                          ),
                        );

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white, // Changed to white for better readability
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              child: Image.network(
                                item.image ?? '',
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: progress.expectedTotalBytes != null
                                          ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.name ?? 'No Name',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                item.description ?? 'No Description',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${price.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                                  ),
                                  if (discount > 0)
                                    Text(
                                      '${discount}% OFF',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                    ),
                                  if (oldPrice > 0)
                                    Text(
                                      '\$${oldPrice.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough, color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )

        // Products List
          ],
        ),
      ),
    );
  }
}
