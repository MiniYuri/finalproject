import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';

var meals = <String>['食來運轉', '阿卿熟食', '大俠請留步','越南祥記美食','荷麵亭','豚馬日本料理','新山韓國烤肉'];
var price =<int>[10,10,10,10,10,10,10];
var quantity = <int>[];
var total_amount=0;
bool out_eat = false;
bool in_eat = false;
enum EatType { in_eat, out_eat }
var max_text_len =6;

void main() => runApp(in_out());
class in_out extends StatelessWidget {
  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    for(var i =0 ; i < meals.length ; i++){ quantity.add(1); }
    return MaterialApp(
      title: '結帳',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('結帳'),
          ),
          body: _in_out()
      ),
    );
  }
}
class _in_out extends StatelessWidget {

  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(vertical: 20,),
        child: Column(
          children: <Widget>[
           Container(
             child: Container(
               child: Column(
                 children: [
                   Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                             padding: EdgeInsets.symmetric(horizontal: 30),
                             child: Text('餐點名稱',style: TextStyle(fontSize: 20,),)
                         ),
                         SizedBox(width: 85,),
                         Text('價格',textAlign: TextAlign.center,),
                         SizedBox(width: 55,),
                         Text('數量',textAlign: TextAlign.center,),
                       ]
                   ),
                   SizedBox(height: 10,),
                   Padding(
                     padding:EdgeInsets.symmetric(horizontal:10.0),
                     child:Container(
                       height:2.0,
                       width:500.0,
                       color:Colors.black38,
                     ),
                   ),
                 ],
               ),
             ),
           ),
            SizedBox(height: 15,),
            Expanded(
                child: SingleChildScrollView(
                  child:ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                        String s="";
                        for(var i = 0 ; i < max_text_len-meals[index].length;i++)s+="    ";
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(meals[index]+s,style: TextStyle(fontSize:20),)
                                ),
                                SizedBox(width: 50,),
                                Text(price[index].toString(),textAlign: TextAlign.center,),
                                SizedBox(width: 70,),
                                Text(quantity[index].toString(),textAlign: TextAlign.center,),
                              ]
                            ),
                          ],
                        );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
            ),

            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                create_radio(),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: Text('確認'),
                  onPressed: () {  },
                ),
              ],
            )

            ),
          ],
        ),
      );
  }

}
class create_radio extends StatefulWidget {
  const create_radio({super.key});

  @override
  State<create_radio> createState() => _create_radio();
}

class _create_radio extends State<create_radio> {
  EatType? _EatType = EatType.out_eat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Row(

               children: [
                  Radio<EatType>(
                      value: EatType.out_eat,
                      groupValue: _EatType, 
                      onChanged: (EatType? value) {
                        setState(() {
                          _EatType = value;
                        });
                      }
                  ),
                  Text('外帶')
            ],
        ),
        SizedBox(width: 20,),
        Row(
          children: [
            Radio<EatType>(
                value: EatType.in_eat,
                groupValue: _EatType,
                onChanged: (EatType? value) {
                  setState(() {
                    _EatType = value;
                  });
                }
            ),
            Text('內用')
          ],
        ),
    ]),
    ]
    );
  }
}


