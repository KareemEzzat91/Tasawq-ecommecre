class SearchModel {
  bool? status;
  String? message;
  PageData? data;

  SearchModel({this.status, this.message, this.data});

  // Factory constructor to create an instance from JSON
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? PageData.fromJson(json['data']) : null,
    );
  }
}

class PageData {
  int? currentPage;
  List<Details>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PageData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      currentPage: json['current_page'],
      data: json['data'] != null ? (json['data'] as List).map((i) => Details.fromJson(i)).toList() : null,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Details {
  int? id;
  int? price;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Details({
    this.id,
    this.price,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  // Factory constructor to create an instance from JSON
  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'],
      price: json['price'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
