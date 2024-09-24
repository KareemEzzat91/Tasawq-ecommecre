import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import 'cubit/SearchModel/SearchModel.dart';

class DetailPage extends StatelessWidget {
  final  item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x ;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name?? "Details",style: TextStyle(fontSize: Responsive.isMobile(context) ?20:50), ),
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
              _buildImage(item.image,context),
              const SizedBox(height: 16),
              _buildTitle(item.name,context),
              const SizedBox(height: 8),
              _buildDescription(item.description,context),
              const SizedBox(height: 8),
              _buildHorizontalImageList(item.images,context),
              const SizedBox(height: 10),
              _buildPrice(item.price,context ),
            Center(
                child: Padding(
                  padding:   EdgeInsets.all(28.0),
                  child: Container(
                    height: Responsive.isMobile(context) ?30:80,
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
                          Text("Add to your cart",style: TextStyle(color: Colors.white,fontSize: Responsive.isMobile(context) ?28:50,fontWeight: FontWeight.bold),),
                          Spacer(),
                          IconButton(

                            color: Colors.white, // Icon color
                            onPressed: () {},
                            icon: Icon(Icons.shopping_bag,size: Responsive.isMobile(context) ?28:50,),
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

  Widget _buildImage(String? imageUrl, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl ?? "",
        fit: BoxFit.cover,
        width: double.infinity,
        height:  Responsive.isMobile(context) ? 250:1000,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
      ),
    );
  }

  Widget _buildTitle(String? title, BuildContext context) {
    return Text(
      title ?? "",
      style:  TextStyle(
        color: Colors.black,
      fontSize: Responsive.isMobile(context) ?25:70 ,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription(String? description, BuildContext context) {
    return Text(
      description ?? "",
      style: TextStyle(
        color: Colors.grey[700],
          fontSize: Responsive.isMobile(context) ?16:45
      ),
    );
  }

  Widget _buildHorizontalImageList(List<String>? images, BuildContext context) {
    return SizedBox(
      height: Responsive.isMobile(context) ?300:600,
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

  Widget _buildPrice(num? price, BuildContext context) {
    return Text(
      "${price?.toStringAsFixed(2) ?? "N/A"} \$",
      style:   TextStyle(
        color: Color(0xff294C25),
        fontSize: Responsive.isMobile(context) ?20:90,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}
