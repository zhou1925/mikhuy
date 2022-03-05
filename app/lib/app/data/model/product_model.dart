class Product {
  int id;
  String image;
  String title;
  String slug;
  bool featured;
  String description;
  String originalPrice;
  String price;
  List<TagList> tagList;

  Product(
      {this.id,
      this.image,
      this.title,
      this.slug,
      this.featured,
      this.description,
      this.originalPrice,
      this.price,
      this.tagList});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    slug = json['slug'];
    featured = json['featured'];
    description = json['description'];
    originalPrice = json['original_price'];
    price = json['price'];
    if (json['tag_list'] != null) {
      tagList = [];
      json['tag_list'].forEach((v) {
        tagList.add(new TagList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['featured'] = this.featured;
    data['description'] = this.description;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    if (this.tagList != null) {
      data['tag_list'] = this.tagList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TagList {
  String title;
  String slug;
  List<int> product;

  TagList({this.title, this.slug, this.product});

  TagList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    product = json['product'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['product'] = this.product;
    return data;
  }
}