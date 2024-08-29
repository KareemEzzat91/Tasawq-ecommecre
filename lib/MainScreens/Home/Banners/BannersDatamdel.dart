class Bannersdatamdel {
  bool? status;
  String? message; // Changed from Null to String? assuming 'message' is a string
  List<Bannerdata> data = []; // Initialize as an empty list

  Bannersdatamdel({this.status, this.message, this.data = const []});

  Bannersdatamdel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString(); // Convert to string if it's not null
    if (json['data'] != null) {
      data = [];
      for (var item in json['data']) {
        data.add(Bannerdata.fromJson(item));
      }
    }
  }
}

class Bannerdata {
  int? id;
  String? image;
  dynamic category; // Changed from Null to dynamic
  dynamic product; // Changed from Null to dynamic

  Bannerdata({this.id, this.image, this.category, this.product});

  Bannerdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category']; // Can be cast to specific type if known
    product = json['product']; // Can be cast to specific type if known
  }
}
