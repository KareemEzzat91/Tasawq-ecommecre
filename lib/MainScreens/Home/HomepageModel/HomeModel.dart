class HomeModel {
  bool? status;
  String? message; // Assuming message is a String or null
  Homedata? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString(); // Convert to String if it's not null
    data = json['data'] != null ? Homedata.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data?.toJson();
    return data;
  }
}

class Homedata {
  List<Banners> banners = []; // Initialize as an empty list
  List<HomeProducts> products = []; // Initialize as an empty list
  String? ad;

  Homedata({this.banners = const [], this.products = const [], this.ad});

  Homedata.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = List<Banners>.from(json['banners'].map((v) => Banners.fromJson(v)));
    }
    if (json['products'] != null) {
      products = List<HomeProducts>.from(json['products'].map((v) => HomeProducts.fromJson(v)));
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banners'] = banners.map((v) => v.toJson()).toList();
    data['products'] = products.map((v) => v.toJson()).toList();
    data['ad'] = ad;
    return data;
  }
}

class Banners {
  int? id;
  String? image;
  dynamic category; // Changed from Null to dynamic
  dynamic product; // Changed from Null to dynamic

  Banners({this.id, this.image, this.category, this.product});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['category'] = category;
    data['product'] = product;
    return data;
  }
}

class HomeProducts {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  HomeProducts({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  HomeProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = (json['price'] is int) ? (json['price'] as int).toDouble() : json['price']?.toDouble();
    oldPrice = (json['old_price'] is int) ? (json['old_price'] as int).toDouble() : json['old_price']?.toDouble();
    discount = json['discount']?.toInt();
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['images'] = images;
    data['in_favorites'] = inFavorites;
    data['in_cart'] = inCart;
    return data;
  }
}
