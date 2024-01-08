import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practice20/product_model.dart';
import 'package:practice20/products_screen.dart';

import 'category_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var categoryid = 1;
  var selectedindex;
  Categorymodel? category;
  void getcategorydata() async {
    try {
      Response response =
          await Dio().get("http://147.135.223.71:9990/api/public/categories");
      print(response.data);

      category = categorymodelFromJson(jsonEncode(response.data));
    } catch (e) {
      print("===============================> Error");
    }
  }

  Productmodel? products;
  void getproductsdata() async {
    try {
      Response response = await Dio().get(
          "http://147.135.223.71:9990/api/public/products?category_id=$categoryid");
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
    getcategorydata();
    getproductsdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            category == null
                ? CircularProgressIndicator()
                : Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              //Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Productsscreen()));
                              setState(() {
                                categoryid = category!.data![index].categoryId!;
                                selectedindex = index;
                                getproductsdata();
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 160,
                              decoration: BoxDecoration(
                                color: selectedindex == index
                                    ? Colors.orange
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${category!.data![index].categoryName}",
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: category!.data!.length),
                  ),
            SizedBox(
              height: 20,
            ),
            products == null
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      height: 400,
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
            // Text("${categoryid}"),
          ],
        ),
      )),
    );
  }
}
