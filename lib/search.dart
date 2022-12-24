import 'package:flutter/material.dart';
import 'dart:math';

var stores= <String>['食來運轉', '阿卿熟食', '大俠請留步','越南祥記美食','荷麵亭','豚馬日本料理','新山韓國烤肉'];
var meals = <String>['排骨飯', '糖醋排骨飯', '滷雞腿飯','鰻魚飯','炸雞腿飯','炸雞塊飯','魚排飯'];
var price =<int>[10,10,10,10,10,10,10];
var quantity = <int>[0,0,0,0,0,0,0];
var total_amount=0;
bool out_eat = false;
bool in_eat = false;
enum EatType { in_eat, out_eat }
var max_text_len =6;

int q =0,now_index=0;
String order_name ="",seatOrOrder="";
var order_meals =<String>[],order_p=<int>[],order_q=<int>[];
EatType? _EatType = EatType.out_eat;


void main() => runApp(search());

//搜尋餐廳主頁
class search extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('餐廳搜尋'),
          ),
          body: _search()
      ),
    );
  }
}
var search_str = "";

class _search extends StatelessWidget{
  final TextEditingController name_controller = new TextEditingController();
  final TextEditingController address_controller = new TextEditingController();
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('餐廳名稱搜尋',style: TextStyle(fontSize: 25),),
          Container(
            margin: EdgeInsets.all(20),
            height: 60,
            child: TextField(
              controller: name_controller,
              decoration: InputDecoration(
                labelText: '請輸入餐廳名稱',
                border: OutlineInputBorder(),
                //isDense: true,
              ),
            ),
          ),
          SizedBox(height: 30,),
          Text('地圖搜尋',style: TextStyle(fontSize: 25),),
          Container(
            margin: EdgeInsets.all(20),
            height: 60,
            child: TextField(
              controller: address_controller,
              decoration: InputDecoration(
                labelText: '請輸入地址',
                border: OutlineInputBorder(),
                //isDense: true,
                //contentPadding: EdgeInsets.all(8),
              ),
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(
            child: Text('確認'),
            onPressed: () {
              if(name_controller.text!="" || address_controller.text!=""){
                Navigator.push(context, MaterialPageRoute(builder:(context) => search_result()));
              }
              },
          ),
        ],
      ),
    );
  }
}

// 搜尋餐廳結果
class search_result extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: order_name+'',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _search_result(),

    );
  }
}

class _search_result extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text('餐聽搜尋結果'),
    );
    // 建立App的操作畫面
    final textWrapper = _TextWrapper(GlobalKey<_TextWrapperState>());
    const items = <String>['食來運轉', '阿卿熟食', '大俠請留步','越南祥記美食','荷麵亭','豚馬日本料理','新山韓國烤肉'];
    const icons = <String>['assets/2.png', 'assets/2.png', 'assets/3.png','assets/4.png', 'assets/5.png', 'assets/6.png','assets/7.png'];
    var listView = ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) =>Card(
        child:ListTile(title: Text(items[index], style: TextStyle(fontSize: 20),),
          onTap: () => {
            textWrapper.setText('點選' + items[index]),
          Navigator.push(context, MaterialPageRoute(builder:(context) => OrderApp())),
          },
          //onLongPress: ()=>,
          leading: Container(
            child: CircleAvatar(backgroundImage: AssetImage(icons[index],),),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          ),
          subtitle: Text('好吃的食物', style: TextStyle(fontSize: 16),),),
      ),
      separatorBuilder: (context, index) => Divider(),
    );
    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children: <Widget>[
          textWrapper,
          Expanded(child: listView,),
           Row(
            children : [
              SizedBox(width: 20,),
              OutlinedButton(
                onPressed: ()=>{
                  Navigator.push(context, MaterialPageRoute(builder:(context) => search())),
                },
                child: Text('<',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
              ),
            ],
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
  }

class _TextWrapper extends StatefulWidget {
  final GlobalKey<_TextWrapperState> _key;
  _TextWrapper(this._key): super (key: _key);
  @override
  State<StatefulWidget> createState() => _TextWrapperState();
  setText(String string) {
    _key.currentState?.setText(string);
  }
}

class _TextWrapperState extends State<_TextWrapper> {
  String _str = '';
  @override
  Widget build(BuildContext context) {
    var widget = Text(
      _str,
      style: TextStyle(fontSize: 20),
    );
    return widget;
  }

  setText(String string) {
    setState(() {
      _str = string;
    });
  }
}

//order menu 菜單
class OrderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '餐點',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('餐點'),
          ),
          body: _OrderList(),
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
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
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,),
        child: Column(
          children: <Widget>[
            Expanded(child: listView,),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: ()=>{
                        total_amount=0,
                        for(var i = 0 ;i < quantity.length ; i++){
                          quantity[i]=0,
                        },
                       Navigator.push(context, MaterialPageRoute(builder:(context) => search_result())),
                      },
                      child: Text('<')
                  ),
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
      ),
    );
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
                  runApp(OrderApp()),
                  //runApp(_OrderList())
                },
              ),
              Text('$q'),
              OutlinedButton(
                child: Text('+'),
                onPressed: () =>{
                  q++,
                  runApp(OrderApp()),
                  //runApp(OrderList()),
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
                runApp(OrderApp());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

//結帳 、 選擇內用or外帶
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
                  onPressed: () {
                    if(total_amount!=0)Navigator.push(context, MaterialPageRoute(builder:(context) => CheckSeat()));
                  },
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

//訂單、訂位成功畫面
class CheckSeat extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(_EatType == EatType.out_eat){
      seatOrOrder="訂單已送出";
      return MaterialApp(
          title: '外帶成功',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SeatSuccess(),
      );
    }else{
      seatOrOrder="訂位成功";
      return MaterialApp(
        title: '請選擇內用座位',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InHomePage(),
      );
    }

  }
}

class OutHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SeatSuccess()
    );
  }
}

class InHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('內用座位表'),
      ),
      body: SeatTable(),
    );

    //return appHomePage;
  }
}

class SeatTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _w=60.0,_h=60.0,f_size=20.0;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 100,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                    child: Text('1',style: TextStyle(fontSize: f_size),),
                    onPressed: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                    },
                  ),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('2',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('3',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('4',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('5',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('6',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('7',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('8',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('9',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('10',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('11',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('12',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('13',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('14',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('15',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                ),
                SizedBox(
                  width: _w,
                  height: _h,
                  child: OutlinedButton(
                      child: Text('16',style: TextStyle(fontSize: f_size),),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess())),
                      }),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}


class SeatSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Icon(
                    Icons.assignment_turned_in_outlined,
                    color: Colors.green,
                    size: 100,
                  ),
                  Text(seatOrOrder,
                    style: const TextStyle(fontSize: 50,color: Colors.green),
                  ),
                  SizedBox(height: 100,),
                  ElevatedButton(
                    child: Text('回首頁'),
                    onPressed: ()=>{
                      total_amount=0,
                      for(var i = 0 ;i < quantity.length ; i++){
                        quantity[i]=0,
                      },
                      Navigator.push(context, MaterialPageRoute(builder:(context) => search())),
                    },
                  )
                ],
              )
          )
      ),
    );


    //return appHomePage;
  }
}