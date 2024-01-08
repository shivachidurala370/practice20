// To parse this JSON data, do
//
//     final productmodel = productmodelFromJson(jsonString);

import 'dart:convert';

Productmodel productmodelFromJson(String str) =>
    Productmodel.fromJson(json.decode(str));

String productmodelToJson(Productmodel data) => json.encode(data.toJson());

class Productmodel {
  List<Datum>? data;

  Productmodel({
    this.data,
  });

  factory Productmodel.fromJson(Map<String, dynamic> json) => Productmodel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? productId;
  String? productName;
  String? productDescription;
  double? productPrice;
  int? productStock;
  int? categoryId;
  List<ProductImage>? productImages;

  Datum({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productStock,
    this.categoryId,
    this.productImages,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productPrice: json["product_price"],
        productStock: json["product_stock"],
        categoryId: json["category_id"],
        productImages: json["product_images"] == null
            ? []
            : List<ProductImage>.from(
                json["product_images"]!.map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_price": productPrice,
        "product_stock": productStock,
        "category_id": categoryId,
        "product_images": productImages == null
            ? []
            : List<dynamic>.from(productImages!.map((x) => x.toJson())),
      };
}

class ProductImage {
  int? productImageId;
  String? productImage;

  ProductImage({
    this.productImageId,
    this.productImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        productImageId: json["product_image_id"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "product_image_id": productImageId,
        "product_image": productImage,
      };
}
