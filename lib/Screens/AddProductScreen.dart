import 'dart:convert';

import 'package:crud_app/Screens/AllProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> _form = GlobalKey();

  //all controller
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController imgController = TextEditingController();

//product set in api
  addProductApi(name, code, unitPrice, totalPrice, quantity, inage) async {
    //url
    String url = "https://crud.teamrabbil.com/api/v1/CreateProduct";
    Uri uri = Uri.parse(url);
    http.Response response = await http.post(uri,
        headers: {
          'Content-Type': "application/json",
          'Accept': 'application/json',
        },
        //set product
        body: jsonEncode({
          "Img": inage,
          "ProductCode": code,
          "ProductName": name,
          "Qty": quantity,
          "TotalPrice": totalPrice,
          "UnitPrice": unitPrice
        }));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add Product Succefull")));
      nameController.text="";
      codeController.text="";
      quantityController.text="";
      totalController.text="";
      unitController.text="";
      imgController.text="";
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add product failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter product Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter Product Name",
                    fillColor: Colors.greenAccent,
                    filled: true,
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: codeController,

                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter product Code";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter Product Code",
                    fillColor: Colors.greenAccent,
                    filled: true,
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: unitController,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter product unit Price";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter Product Unit Price",
                    fillColor: Colors.greenAccent,
                    filled: true,
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: imgController,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter product Image";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter Product Image",
                    fillColor: Colors.greenAccent,
                    filled: true,
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: quantityController,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter product Quantity";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter Product Quantity",
                    fillColor: Colors.greenAccent,
                    filled: true,
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: totalController,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter product Total Price";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter Total Price",
                    fillColor: Colors.greenAccent,
                    filled: true,
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      addProductApi(
                          nameController.text,
                          codeController.text,
                          unitController.text,
                          totalController.text,
                          quantityController.text,
                          imgController.text);
                    }
                  },
                  child: Text(
                    "Add Product",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
