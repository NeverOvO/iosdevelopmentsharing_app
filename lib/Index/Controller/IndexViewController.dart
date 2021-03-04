import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iosdevelopmentsharing_app/Index/Controller/ListMessage.dart';
class IndexViewController extends StatefulWidget {
  final arguments;
  const IndexViewController({Key? key, this.arguments}) : super(key: key);

  @override
  _IndexViewControllerState createState() =>
      _IndexViewControllerState();
}

class _IndexViewControllerState extends State<IndexViewController>  with AutomaticKeepAliveClientMixin {



  List<bool> _isShowList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print(messageList.length );
    for(int i = 0;i<messageList.length ;i++){
      _isShowList.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      right: true,
      bottom: false,
      left: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('IOS学习手记', style: TextStyle(fontSize: 17)),
          backgroundColor: Colors.blue,
        ),
        body:ListView.builder(
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  _isShowList[index] = !_isShowList[index];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(messageList[index]['title'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),),
                          Icon( !_isShowList[index] ? Icons.arrow_drop_down : Icons.arrow_drop_up,color: Colors.white,)
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                    ),
                    Offstage(
                      child: Container(
                        child: Text(messageList[index]['message'],style: TextStyle(fontSize: 13,color: Colors.black),),
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                      ),
                      offstage: !_isShowList[index],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: messageList.length ,),

      ),
    );
  }

}
