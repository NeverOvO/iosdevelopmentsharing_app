import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class IndexViewController extends StatefulWidget {
  final arguments;
  const IndexViewController({Key key, this.arguments}) : super(key: key);

  @override
  _IndexViewControllerState createState() =>
      _IndexViewControllerState();
}

class _IndexViewControllerState extends State<IndexViewController>  with AutomaticKeepAliveClientMixin {


  List _messageList = [
    {'title' : '第二章（1）' ,
      'message' : """
    消息表达式
[obj msg]

实例的生成
[类名 alloc]

Cocoa 中某个类的对象的生成
[[类名 alloc] init]


接口的定义
@interface 类名 ：父类名
{
	实例变量的定义；
	…
 }
方法声明;
…
@end

例如：
@interface Prawn : NSObject
{
    id order;
    int currentValue;
}
-(id)initWithObject : (id) obj;
-(void)dealloc ;
-(int)currentValue;
-(void)setCurrentValue : (int) val;
-(double)evaluation:(int) val;
@end


类的实现
@implementation 类名
方法的定义；
….
@end

简单的方法实现，例如：

-(double)evaluation :(int) val
{
    double tmp = [order proposedBalance : vall];
    if(currentValue > (int) tmp)
        tmp = [order proposedBalance : val *1.25];
    return tmp;
}


一个遥控器的例子：
遥控器有一个音量类，分别为音量的最大值，最小值，音量的变化幅度，与音量当前值
音量类包含四个方法，分别用于初始化最大值，最小值，变化幅度值的初始化方法（initWithMin）
以及返回当前音量值的大小的方法（value），增大音量的方法（up）和减小音量的方法（down）

//头文件：
#import <Foundation/NSObject.h>
#import <stdio.h>
//音量类的借口部分：
@interface Volume :NSObject
{
    int val;
    int min,max,step;
}
-(id)initWithMin:(int)a max:(int)b step:(int)s;
-(int)value;
-(id)up;
-(id)down;
@end
//Volume类的实现部分：
@implementation Volume
-(id)initWithMin:(int)a max:(int)b step:(int)s
{
    self = [super init];
    if(self !=nil){
        val = min =a;
        max =b;
        step =s;
    }
    return self;
}
-(int)value
{
    return val;
}
-(id)up
{
    if((val +=step)>max)
        val =max;
    return self;
}
-(id)down
{
    if((val -= step)< min)
        val = min;
    return self;
}
@end
//用于测试Volume类的函数：
int main(void) {
    id v,w;
    
    v= [[Volume alloc] initWithMin:0 max:10 step:2];
    w= [[Volume alloc] initWithMin:0 max:9 step:3];
    [v up];
    printf("%d %d\n", [v value], [w value]);
    [v up];
    [w up];
    printf("%d %d\n", [v value], [w value]);
    [v down];
    [w down];
    printf("%d% d\n", [v value], [w  value]);
    return 0;
}
结果：
2 0
4 3
2 0
    """},


  ];
  List<bool> _isShowList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    for(int i = 0;i<_messageList.length ;i++){
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
                          Expanded(child: Text(_messageList[index]['title'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),),
                          Icon( !_isShowList[index] ? Icons.arrow_drop_down : Icons.arrow_drop_up,color: Colors.white,)
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                    ),
                    Offstage(
                      child: Container(
                        child: Text(_messageList[index]['message'],style: TextStyle(fontSize: 13,color: Colors.black),),
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
          itemCount: 1,),

      ),
    );
  }

}
