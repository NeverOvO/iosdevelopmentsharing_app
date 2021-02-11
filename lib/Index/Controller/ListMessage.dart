List messageList = [
  {'title' : '第二章（1）' , 'message' : """
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
  {'title' : '第二章（2）' , 'message' : """
    接口文件：
文件名为 “类名.h”，内容为类的接口部分
起到了头文件的作用

实现文件：
文件名为 “类名.m”，内容为类的实现部分

主函数：
只要用到了类或者消息表达式，都需要把文件的扩展名保存为 .m

故（1）中程序可以改写为：
￼
Volume.h下：
#import <Foundation/NSObject.h>
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

Volume.m下：
#import "Volume.h"

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

mian.m下：
#import "Volume.h"
#import <stdio.h>
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

函数可以定义在@implementation的前面，@implementation和@end之间。或者@end的后面的任何位置
如果函数的作用域仅限于这个文件，那么给函数加上static修饰符比较好
#import "MyExample.h"

static void funcA(int a,char *p){
    /*函数定义*/
}
@implementation MyExample
static void funcV(int a,char *p){
    /*函数定义*/
}
-(id)myMethod{
    /*方法定义*/
}
@end

static void funcC(int a,char *p){
    /*函数定义*/
}


使用import可以避免二重导入头文件的问题
    """},

];