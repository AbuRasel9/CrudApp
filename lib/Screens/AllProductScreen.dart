import 'package:flutter/material.dart';
import 'http';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  ProductListPojo? allProduct;
  getProductListFormApi(){
    String url="https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri =Uri.parse(url);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Product"),
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(

            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 10,),
                  Image.network("https://avatars.githubusercontent.com/u/136594114?v=4",height: 30,width: 30,),
                  Column(
                    children: [
                      Text("Product Name"),
                      // SizedBox(height: 5,),
                      Text("Product Code"),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("Unit Price"),
                  Text("Quantity"),
                  Text("Total Price"),
                  Icon(Icons.delete,color: Colors.green,size: 15,),
                  Icon(Icons.edit,color: Colors.green,size: 15,),


                ],
              )

            ],
          ),
        );
      }),
    );
  }
}

//pojo class

class ProductListPojo {
  String? status;
  List<Data>? data;

  ProductListPojo({this.status, this.data});

  ProductListPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? productName;
  String? productCode;
  String? img;
  String? unitPrice;
  String? qty;
  String? totalPrice;
  String? createdDate;

  Data(
      {this.sId,
        this.productName,
        this.productCode,
        this.img,
        this.unitPrice,
        this.qty,
        this.totalPrice,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    unitPrice = json['UnitPrice'];
    qty = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ProductName'] = this.productName;
    data['ProductCode'] = this.productCode;
    data['Img'] = this.img;
    data['UnitPrice'] = this.unitPrice;
    data['Qty'] = this.qty;
    data['TotalPrice'] = this.totalPrice;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}
