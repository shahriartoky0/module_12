import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Style/style.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  // final TextEditingController _idTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  addNewProduct() async {
    Map<String, dynamic> addProducts = {
      // "_id": _idTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "Img": _imageTEController.text.trim(),
      "UnitPrice": _unitPriceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
    };
    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(addProducts));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product Has been Added')));
      _nameTEController.clear();
      _codeTEController.clear();
      _imageTEController.clear();
      _unitPriceTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TextFormField(
              //   decoration: AppInputDecoration('Product Id '),
              //   controller: _idTEController,
              //   validator: isValidate,
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              TextFormField(
                decoration: AppInputDecoration('Product Code'),
                controller: _codeTEController,
                validator: isValidate,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: AppInputDecoration('Product Name'),
                controller: _nameTEController,
                validator: isValidate,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: AppInputDecoration('Image'),
                controller: _imageTEController,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: AppInputDecoration('Unit Price'),
                controller: _unitPriceTEController,
                validator: isValidate,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: AppInputDecoration('Quantity'),
                controller: _quantityTEController,
                validator: isValidate,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: AppInputDecoration('Total Price'),
                controller: _totalPriceTEController,
                validator: isValidate,
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Create'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addNewProduct();
                    }
                  },
                  style: AppInputButtonStyle(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? isValidate(String? value) {
    if (value?.trim().isNotEmpty ?? false) {
      return null;
    }
    return "Please Enter a Valid Input";
  }

  @override
  void dispose() {
    // _idTEController.dispose();
    _codeTEController.dispose();
    _nameTEController.dispose();
    _imageTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
  }
}
