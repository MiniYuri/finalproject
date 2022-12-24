import 'dart:math';
import 'package:flutter/material.dart';

var meals = <String>['食來運轉', '阿卿熟食', '大俠請留步','越南祥記美食','荷麵亭','豚馬日本料理','新山韓國烤肉'];
var price =<int>[10,10,10,10,10,10,10];
var quantity = <int>[0,0,0,0,0,0,0];
var total_amount=0;
enum EatType { in_eat, out_eat }

int q =0,now_index=0;
String order_name ="";
var order_meals =<String>[],order_p=<int>[],order_q=<int>[];

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text('餐點'),
    );
    // 建立App的操作畫面
    var listView = ListView.separated(
      itemCount: meals.length,
      itemBuilder: (context, index) =>Card(
        child:ListTile(title: Text(meals[index], style: TextStyle(fontSize: 20),),
          onTap: () => {
            q=quantity[index],
            order_name=meals[index],
            now_index=index,
            _dialogBuilder(context),
          },
          onLongPress: ((){
            Navigator.push(context, MaterialPageRoute(builder:(context) => in_out()));
          }),
          leading: Container(
            child: CircleAvatar(backgroundColor: Colors.blueGrey,),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          ),

          subtitle: Text('數量:  ${quantity[index]}', style: TextStyle(fontSize: 16),),),
      ),
      separatorBuilder: (context, index) => Divider(),
    );
    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children: <Widget>[
          Expanded(child: listView,),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Total : \$$total_amount",
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  child: Text('結帳'),
                  onPressed: ()=> {
                    order_meals=<String>[],
                    order_p=<int>[],
                    order_q=<int>[],
                    for(var i = 0; i < quantity.length ; i++){
                      if(quantity[i]>0){
                        order_meals.add(meals[i]),
                        order_p.add(price[i]),
                        order_q.add(quantity[i]),
                      },
                    },
                    Navigator.push(context, MaterialPageRoute(builder:(context) => in_out())),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );
    return appHomePage;
  }
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('餐點數量'),
          content:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  child: Text('-'),
                  onPressed: () => {
                    if(q>0)q--,
                    runApp(MyApp())
                  },
                ),
                Text('$q'),
                OutlinedButton(
                  child: Text('+'),
                  onPressed: () =>{
                    q++,
                    runApp(MyApp())
                  },
                ),
              ],
            ),

          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('確認'),
                onPressed: () {
                  quantity[now_index]=q;
                  total_amount =0;
                  for(var i = 0 ; i<meals.length ; i++){
                    total_amount+=quantity[i]*price[i];
                  }
                  runApp(MyApp());
                  Navigator.of(context).pop();
                },
            ),
          ],
        );
      },
    );
  }
}


//in_or_out_eat

var max_text_len =6;
class in_out extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
          appBar: AppBar(
            title: Text('結帳'),
          ),
          body: _in_out()
    );
  }
}
class _in_out extends StatelessWidget {

  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(vertical: 50,),
        child: Column(
          children: <Widget>[
            Container(
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
            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child:ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: order_q.length,
                  itemBuilder: (context, index) {
                    if(order_meals.length==0)return Text('請選擇任一餐點');
                    String s="";
                    for(var i = 0 ; i < max_text_len-order_meals[index].length;i++)s+="    ";
                    return Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(order_meals[index]+s,style: TextStyle(fontSize:20),)
                              ),
                              SizedBox(width: 50,),
                              Text(order_p[index].toString(),textAlign: TextAlign.center,),
                              SizedBox(width: 70,),
                              Text(order_q[index].toString(),textAlign: TextAlign.center,),
                            ]
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('總金額:  \$ ${total_amount}',style: TextStyle(fontSize: 17),),
                create_radio(),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: Text('確認'),
                  onPressed: () {  },
                ),
              ],
            )


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
