import 'package:flutter/material.dart';

var meals = <String>['食來運轉', '阿卿熟食', '大俠請留步','越南祥記美食','荷麵亭','豚馬日本料理','新山韓國烤肉'];
var price =<int>[10,10,10,10,10,10,10];
var quantity = <int>[0,0,0,0,0,0,0];
var total_amount=0;
enum EatType { in_eat, out_eat }

int q =0,now_index=0;
String order_name ="",seatOrOrder="";
var order_meals =<String>[],order_p=<int>[],order_q=<int>[];

void main() => runApp(CheckSeat());
class CheckSeat extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EatType? _EatType = EatType.out_eat;
    if(_EatType == EatType.out_eat){
      seatOrOrder="訂單已送出";
      return MaterialApp(
        title: '外帶成功',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OutHomePage()
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
      body: Center(
        child: OutlinedButton(
          child: Text('確認'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SeatSuccess()));
          },
        ),
      ),
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
                ],
              )
          )
      ),
    );


    //return appHomePage;
  }
}