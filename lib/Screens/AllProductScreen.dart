import 'dart:convert';

import 'package:crud_app/Screens/AddProductScreen.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  ProductListPojo? allProduct;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductListFormApi();
  }
  //delete product form api
  deleteProductFormApi(id) async {
    String url="https://crud.teamrabbil.com/api/v1/DeleteProduct/$id";
    Uri uri=Uri.parse(url);
    http.Response response=await http.get(uri);
    if(response.statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Delete Successfull")));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductScreen()));
      setState(() {

      });

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Delete Failled")));


    }
  }
//get product form api
  Future<void> getProductListFormApi() async {
    String url = "https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if(response.statusCode==200){
      var value=jsonDecode(response.body);
      allProduct=ProductListPojo.fromJson(value);
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductScreen()));},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("All Product"),
      ),
      body: ListView.builder(
          itemCount: allProduct?.data?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        allProduct?.data?[index].img ?? "",
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        children: [
                          Text(allProduct?.data?[index].productName ?? "",),
                          // SizedBox(height: 5,),
                          Text(allProduct?.data?[index].productCode ?? "",),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(allProduct?.data?[index].unitPrice ?? "",),
                      Text(allProduct?.data?[index].qty ?? "",),
                      Text(allProduct?.data?[index].totalPrice ?? "",),
                      InkWell(
                        onTap: (){
                          deleteProductFormApi(allProduct?.data?[index].sId??"");
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.green,
                          size: 15,
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.green,
                        size: 15,
                      ),
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
