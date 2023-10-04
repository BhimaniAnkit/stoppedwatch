import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoppedwatch/second.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
 double seconds = 00,min = 00,hours = 00;
 bool temp=false;
   Stream<String> get()
  async *{
    while(true)
    {
      String time='${seconds.toString().padLeft(2,'0')}:${min.toString().padLeft(2,'0')}:${hours.toString().padLeft(2,'0')}';
      if(temp)
      {
        if(seconds < 60){
          seconds++;
        }
          // seconds++;
        if(seconds >= 60){
          if(seconds == 60){
            min++;
            seconds = 0;
            // min++;
          }
          else{
            seconds = 0;
          }
        }
        if(min >= 60){
          if(min == 60){
            hours++;
            min = 0;
            // hours++;
          }
          else{
            min = 0;
          }
        }
      }
      await Future.delayed(Duration(seconds: 0));
      yield time;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("STOPWATCH",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: StreamBuilder(stream: get(),builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    height: 50,
                    width: 200,
                    color: Colors.blue.shade200,
                    child: Text("${snapshot.data}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16,),
                ElevatedButton(onPressed: () {
                  temp = true;
                  },
                  child: Text("Start",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 16,),
                ElevatedButton(onPressed: () {
                  temp = false;
                  },
                  child: Text("Stop",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                ),
                ],
              ),
            ],
          );
        }
      },
      ),
    );
  }
}
