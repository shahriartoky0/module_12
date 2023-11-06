import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module_12/Screen/Product.dart';

import 'AddNewProduct.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List productList = [];

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  void getProductList() async {
    Response response =
    await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
    if (response.statusCode == 200) {
      // print(response.body);
      Map <String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        // print(responseData['data']);
        for (Map <String, dynamic> productJson in responseData['data']) {
          productList.add(Product(
              productJson['_id'], productJson['ProductName'], productJson['ProductCode'], productJson['Img'], productJson['UnitPrice'],
              productJson['Qty'],productJson['TotalPrice']));

        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: ListView.separated(
          itemCount: productList.length,
          // itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(
                  '${productList[index].image}'),
              title:  Text('${productList[index].name}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Code :${productList[index].code}  '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('Price : \$${productList[index].unitPrice} ')],
                  )
                ],
              ),
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Product_Functionality();
                    });
              },
            );
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewProduct()));
        },
      ),
    );
  }
}

class Product_Functionality extends StatelessWidget {
  const Product_Functionality({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("What do you want to do ?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewProduct()));
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              //Here delete Functions
            },
          ),
        ],
      ),
    );
  }
}
