import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practice20/product_model.dart';

class Productsscreen extends StatefulWidget {
  const Productsscreen({super.key});

  @override
  State<Productsscreen> createState() => _ProductsscreenState();
}

class _ProductsscreenState extends State<Productsscreen> {
  Productmodel? products;
  void getproductsdata() async {
    try {
      Response response = await Dio()
          .get("http://147.135.223.71:9990/api/public/products?category_id=2");
      print(response.data);

      products = productmodelFromJson(jsonEncode(response.data));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproductsdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          products == null
              ? CircularProgressIndicator()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    height: 600,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${products!.data![index].productName}",
                                  style: TextStyle(fontSize: 28),
                                ),
                                Text(
                                  "${products!.data![index].productPrice}",
                                  style: TextStyle(fontSize: 28),
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 10,
                        );
                      },
                      itemCount: products!.data!.length,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
