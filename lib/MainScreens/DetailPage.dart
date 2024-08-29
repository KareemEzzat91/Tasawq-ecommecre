import 'package:flutter/material.dart';
import 'cubit/SearchModel/SearchModel.dart';

class DetailPage extends StatelessWidget {
  final  item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x ;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name ?? "Details"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(item.image),
              const SizedBox(height: 16),
              _buildTitle(item.name),
              const SizedBox(height: 8),
              _buildDescription(item.description),
              const SizedBox(height: 8),
              _buildHorizontalImageList(item.images),
              const SizedBox(height: 10),
              _buildPrice(item.price ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                       borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(

                      onTap: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Add to your cart",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
                          Spacer(),
                          IconButton(

                            color: Colors.white, // Icon color
                            onPressed: () {},
                            icon: Icon(Icons.shopping_bag,size: 28,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl ?? "",
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
      ),
    );
  }

  Widget _buildTitle(String? title) {
    return Text(
      title ?? "",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription(String? description) {
    return Text(
      description ?? "",
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
      ),
    );
  }

  Widget _buildHorizontalImageList(List<String>? images) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images?.length ?? 0,
        itemBuilder: (context, index) {
          final image = images?[index];
          return image != null
              ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPrice(num? price) {
    return Text(
      "${price?.toStringAsFixed(2) ?? "N/A"} \$",
      style: const TextStyle(
        color: Color(0xff294C25),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}
