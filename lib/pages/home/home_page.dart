import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_food/models/food.dart';
import 'package:flutter_food/models/foodapi.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Food> foods = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLUTTER FOOD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: _handleClickButton,
                  child: Text('LOAD FOODS DATA'),
                ),
              ),
            ),
            foods.isEmpty?
            SizedBox.shrink():
            Expanded(
              child: ListView.builder(
                itemCount: foods.length,
                itemBuilder: (context, index){
                  var fooditem = foods[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Image.network(
                            fooditem.image,
                            width: 85.0,
                            height: 85.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fooditem.name,
                                  style: TextStyle(
                                      fontSize: 20.0
                                  ),
                                ),
                                Text(
                                  '${fooditem.price} บาท',
                                  style: TextStyle(
                                      fontSize: 16.0
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleClickButton() {
    _foodinfo();
  }


  _foodinfo() async {
    var result = await http.get(Uri.parse(
        "https://cpsu-test-api.herokuapp.com/foods")); //แปลงStringเป็นURL
    //result.body;
    //เมื่อใช้ http.get(URL) คือเอาข้อมูลจาก url ส่งมาให้โปรแกรมของเรา
    //เมื่อใช้ http.push(ข้อมูล) คือการใส่ข้อมูลเข้าไปServer(ตรงapi)
    var food = jsonDecode(result.body);
    var apiResult = APIResult.fromJson(food);
    List data = apiResult.data;
    setState(() {
      foods = data.map((e) => Food.fromJson(e)).toList();
    });
  }
}

