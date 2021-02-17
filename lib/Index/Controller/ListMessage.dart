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
  {'title' : '第三章（1）' , 'message' : """
    类和继承


3.1 继承的概念
通过扩展或者修改即有类来定义新类的方法叫  继承
被继承的类称为  父类
通过继承关系新建的类称为  子类

子类还可以：
- [x] 追加新的方法
- [x] 追加新的实例变量
- [x] 重新定义父类中的方法

重写：子类中重新定义父类的方法


3.2 利用继承定义新类

NSObject是objective-c 中所有类的根类
子类有想要继承的类，就要直接指明该类的父类，否则需要指定父类为NSObject

当变量X和方法mehtod1继承与类A，所以不需要重新声明，方法method2的声明也可以省略
@interface B : A
-(void)method2;
@end

需要对变量Z和方法method3进行声明：
@interface C : A{
    id z;
}
-(void)method3;
@end

 继承和头文件的关系
.h文件为接口定义文件，.m只需要继承接口文件
父类子类继承之间，只需要导入.h文件
￼

子类重写init初始化方法的时候，其他以init开头的初始化方法也是同理：
-(id)init{
    self = [super init]
    if(self !=nil){
        ...
    }
    return self
}
//nil 表示对象的指针指向空
//self指的是实例对象自身

生成实例对象的方法alloc会把实例对象的变量初始化为0（实例变量isa除外）

设定初始值的方法：
1:在初始化方法中一次性完成实例变量的初始化
2:可以在初始化方法中设置实例变量为默认值，然后调用别的方法来设置实例变量的值

    """},
  {'title' : '第三章（2）' , 'message' : """
   使用继承的程序实例：

追加定义一个带静音功能的类MuteVolume

MuteVolume.h(版本1)：
//父类是定义好的Volume，所以引入该类
//父类Volume的父类是NSObject，所以MuteVolume也是NSObject的派生类
#import "Volume.h"
@interface MuteVolume : Volume
-(id)mute;
@end

MuteVolume.m(版本1)：
//对于MuteVolume.h接口类的实现
#import "MuteVolume.h"
@implementation MuteVolume
-(id)mute{
    val = min;
    return self;
}
@end

测试类：
#import "MuteVolume.h"
#import <stdio.h>
//用于测试Volume类的函数：
int main(void) {
    id v;
    char buf[8];
    v= [[MuteVolume alloc] initWithMin:0 max:10 step:2];
    while(scanf("%s",buf)){
        switch (buf[0]) {
            case 'u': //升高音量
                [v up];
                break;
            case ‘d’://降低音量
                [v down];
                break;
            case ‘m’://静音
                [v mute];
                break;
            case ‘q’://退出
                return 0;
        }
        printf("Volume = %d\n",[v value]);
    }
    return 0;
}

编译的时候 编译.m文件即可
% clang main.m Volume. m MuteVolume.m -framework Foundation



 das 
方法重写的例子：
该例子实现两个功能，第一个功能，再次收到mute消息时，音量恢复原值
				   第二个功能，在静音状态下收到up或者down消息时，返回音量最小值，并作出更改

MuteVolume.h（版本2）:
//父类是定义好的Volume，所以引入该类
//父类Volume的父类是NSObject，所以MuteVolume也是NSObject的派生类
#import "Volume.h"
@interface MuteVolume : Volume{
    BOOL muting;//判断是否为静音状态
}
-(id)initWithMin:(int)a max:(int)b step:(int)s;
-(int)value;
-(id)mute;
@end

MuteVolume.m(版本2)：
//对于MuteVolume.h接口类的实现
#import "MuteVolume.h"
@implementation MuteVolume
-(id)initWithMin:(int)a max:(int)b step:(int)s{
    self =[super initWithMin:a max:b step:s];
    if(self !=nil)
        muting = NO;
    return 0;
}
-(int)value{
    return muting ? min : val;
}
-(id)mute{
    muting = !muting;
    return self;
}
@end

mian函数同上

    """},
  {'title' : '第三章（3）' , 'message' : """
   3.4继承和方法调用

使用self调用方法：
在一个方法中调用当前类中定义的方法，可以利用self
self指的是收到当前信息的实例变量

使用super调用方法：
super调用的是父类的方法，而至于到底调用了哪个方法则是由编译时类的继承关系决定的

测试程序：

 测试程序中有三个类ABC，类A中定义了方法method1和method2
类B中对method1进行了重新，通过self调用了method1，通过super调用了method2
类C重写了method1

#import <Foundation/Foundation.h>
#import <stdio.h>

@interface A:NSObject
-(void)method1;
-(void)method2;
@end

@implementation A
-(void)method1{
    printf("method1 of ClassA\n");
}
-(void)method2{
    printf("method2 of ClassA\n");
}
@end

@interface B:A
-(void)method2;
@end

@implementation B
-(void)method2{
    printf("method2 of ClassB\n");
    printf("self -->");
    [self method1];
    printf("super -->");
    [super method2];
}
@end

@interface C:B
-(void)method1;
@end

@implementation C
-(void)method1{
    printf("method1 of ClassC\n");
}
@end

int main(void){
    id x = [[B alloc] init];
    id y = [[C alloc] init];
    printf("---instance of B ---\n");
    [x method1];
    [x method2];
    printf("---instance of C ---\n");
    [y method1];
    [y method2];
    return 0;
}

3.5 方法定义时的注意事项
1.局部方法：
实现接口声明中的方法时，可把具备独立功能的部分独立出来定义成子方法

例子：
类ClickVolume是类Volume的一个子类，他的主要功能是当音量发生变化（提高或降低）时发出提示音，提高和降低音量时发出的提示音使用一个共同的方法playClick,该功能不会再其他地方用到，所以我们将它定义成一个局部方法，不在接口中声明


@import "Volume.h"

@interface ClickVolume :Volume
-(id)up;
-(id)down;
@end

@implementation ClickVolume
-(void)playClick{
    /*  发出提示音*/
}
-(id)up{
    [self playClick];
    return [super up];
}
-(id)down{
    [self palyClick];
    return [super down];
}
@end

2.指定初始化方法

指定初始化方法，就是指能确保所有实例变量都被初始化的方法

    """},
  {'title' : '第四章（1）' , 'message' : """
   1.动态绑定

1.1什么是动态绑定：
动态绑定的例子：
#import <Foundation/Foundation.h>
#import <stdio.h>

@interface A:NSObject
-(void)whoAreyou;
@end

@implementation A
-(void)whoAreyou{
    printf("Im A");
}
@end

@interface B:NSObject
-(void)whoAreyou;
@end

@implementation B
-(void)whoAreyou{
    printf("Im B");
}
@end

int main(void){
    id obj;
    int n;
    scanf("%d",&n);
    switch (n) {
        case 0:
            obj = [[A alloc] init];
            break;
        case 1:
            obj =[[B alloc] init];
            break;
        case 2:
            obj = [[NSObject alloc] init];
            break;
        default:
            break;
    }
    [obj whoAreyou];
    return 0;
}

执行该程序，输入0时终端显示Im A。输入1时终端显示Im B，但输入2时，程序就会错误
￼

出错的原因在于类NSObject的实例对象中没有实现whoAreyou方法


动态绑定：指在程序执行时才确定对象的属性和需要相应的消息

1.2 多态

多态：指同一操作作用于不同的类的实例时，将产生不同的执行结果，即不同类的对象收到相同的消息，也能得到不同的结果


2.作为类型的类：

2.1把类作为一种类型

类的类型既可以被用作变量的类型，也可以作为方法或者函数的参数和返回值的类型使用。如：
Volume *V；
MuteVolume *mute；

2.2空指针 nil

Objc中 nil表示一个空的对象，这个对象的指针指向空，nil是指向id类型的指针，指为0，初始化方法失败时通常会返回nil

调用端会采用如下语句来判断方法调用是否成功：
if ([list entryForKey :”NeXT”] !=nil) …
在C语言中 null也为空或者0 nil与其相同，可以进行省略
if ([list entryForKey :”NEXT”] ) …
效果相同

3.静态类型检查

id类型时一种通用的对象类型，类似于C语言的void*，可以用来存储任何类型的对象
在程序变得灵活的同时，可能隐含错误，编译器不会对id类进行检查

类型检查的一个例子
//8.11 4.2.3
#import <Foundation/Foundation.h>
#import <stdio.h>

@interface A:NSObject
-(void)whoAreyou;
@end

@implementation A
-(void)whoAreyou{
    printf("Im A\n");
}
@end

@interface B:A
-(void)whoAreyou;
-(void)sayHello;
@end

@implementation B
-(void)whoAreyou{
    printf("Im B\n");
}
-(void)sayHello{
    printf("Hello\n");
}
@end

@interface C :NSObject
-(void)printName;
@end

@implementation C
-(void)printName{
    printf("Im C\n");
}
@end

int main(void){
    A *a,*b;
    C *c;
    
    a= [[A alloc] init];
    b= [[B alloc] init];
    c= [[C alloc] init];
    [a whoAreyou];
    [b whoAreyou];
    [c printName];
    
    return 0;
}

4.静态类型检查的总结

（1）对于id类型的变量，调用任何方法都能通过编译（当然调用不恰当的方法会出现运行时错误）
	id数据类型可以用来存储任何类型的对象，正式由于这个原因，编译器并不知道id中存储的是哪个类的变量，所以无法通过-》来获取类的实例变量或方法，也就没法完成类型检查/
（2）id类型的变量和被定义为特定类的变量之间是可以互相赋值的
	这里的赋值是一个广义的含义，包括方法或者函数的参数的传递，返回值的接收等。
（3）被定义为特定类对象的变量（静态类型），如果调用了类或父类中未定义的方法，编译器就会提示警告
（4）若是静态类型的变量，子类类型的实例变量可以赋值给父类类型的实例变量
	需要注意的是，如果这个变量中调用了子类特有的方法，如（3）所示，会提示警告信息
（5）若是静态类型的变量，父类类型的实例变量不可以赋值给子类类型的实例变量
	因为父类类型的变量无法对应子类中特有的方法，所以这种赋值会提示警告信息
（6）若要判断到底是哪个类的方法被执行类，不要看变量所声明的类型，而要看实际执行时这个变量的类型
（7）id类型并不是（NSObject*）类型



    """},
  {'title' : '第四章（2）' , 'message' : """
   1.编程中的类型定义
1.1.签名不一致的情况
消息选择器中并不包含参数和返回值的类型的信息
消息选择器和这些类型信息结合起来构成签名
签名被用于在运行时标记一个方法

Cocoa提供了类NSMethodSignature，以面向对象的方式来记录方法的参数个数，参数类型和返回值类型等消息。

OBjectiveC中选择器相同的消息，参数和返回值的类型也应该是相同的

1.2.类的前置声明

当我们定义一个类的时候，有时候会将类实例变量，类方法的参数和返回值的类型指定为另外一个类，这种情况如何定义：

方法1: 在新定义的类的接口文件中引入原有类的头文件
例：
#import <Foundation/Foundation.h>
#import “Volume.h”

@interface AudioPlayer : NSObject{
    Volume *theVolume;
    ...
}
-(Volume *)volume;
...

上述方法肯定可行，但是存在缺点，首先头文件除了类名之外，还有各种各样的其他信息的定义，另外头文件中还有可能引入了其他类的头文件，如此循环和大大增大编译时的负担

方法2:
通过编译指令@class 告知编译器Volume是一个类名，这种写法被叫做类的前置声明
#import <Foundation/Foundation.h>

@class Volume;

@interface AudioPlayer : NSObject
...

class指令的后面可以一次接多个类，不同的类之间用“，”来分割，最后用“；”来标识前置声明的结束。
例如：
@class NSString,NSArray,NSMutableArray;
@class Volume;

通过使用@Class可以提升程序整体的编译速度，但要注意的是，如果新定义的类中要使用原有类的具体成员或方法，就一定要引入原有类的头文件。


1.3.强制类型转换的使用示例


2.实例变量的数据封装

2.1实例变量的访问权限

三原色类程序：

三原色类的接口部分（RGB.h）：
#import <Foundation/NSObject.h>

@interface RGB : NSObject{
    unsigned char red ,green ,blue;
}
-(id) initWithRed:(int)r green:(int)g blue:(int)b;
-(id)blendColor:(RGB *)color;
-(void)print;

@end


三原色类的实现部分（RGB.m）
#import "RGB.h"
#import <stdio.h>

static unsigned char roundUChar(int v){
    if(v < 0)
        return 0;
    if(v > 255)
        return 255;
    return (unsigned char)v;
}

@implementation RGB
-(id)initWithRed:(int)r green:(int)g blue:(int)b{
    if((self = [super init]) !=nil){
        red = roundUChar(r);
        green = roundUChar(g);
        blue = roundUChar(b);
    }
    return self;
}
-(id)blendColor:(RGB *)color{
    red = ((unsigned int)red + color ->red) /2;
    green =((unsigned int)green + color->green)/2;
    blue = ((unsigned int)blue+color->blue)/2;
    return self;
}
-(void)print{
    printf("(%d %d %d)",red ,green,blue);
}

@end

测试三原色类用的main程序：
#import "RGB.h"
int main(void){
    RGB *u,*w;
    
    u=[[RGB alloc] initWithRed:255 green:127 blue:127];
    w=[[RGB alloc]initWithRed:0 green:127 blue:64];
    [u print];
    [w print];
    [[u blendColor:w]print];
    return 0;
}

方法blendColor：中直接通过-》访问了参数color内部的实例变量
之所以可以访问，是因为参数color的类型和blendColor所在类的类型益智

2.2访问器

例如类中有一个float类型，变量名叫weight的属性，从类外部访问这个属性的方法应和属性同名
-（float）weight

定义修改该属性的方法时，可以用set作为前缀，之后接要更改的属性的名称，属性名的第一个字母要求大些
-（void）setWeight：（float）value

对应的getter setter方法：
-（unsigne char）red{return red;}
-(void)setRed:(unsigned char)newvalue{ red = newvalue ;}

2.3实例变量的可见性：
ObjevtiveC中有四种可见性修饰符：

@private
	只能在声明它的类内访问，子类中不能访问，可以在方法中通过-》来访问同一个类的实例对象
@protected
	能够被声明它的类和任何子类访问，类方法中可以通过-》来访问本类实例对象的实例变量，没有显式指定可见性的实例变量都是此属性
@public	
	作用范围最大，本类和其他类都可以直接访问
@package
	类所在的框架内，可以想@public一样访问，而框架外则同@private一样，不允许访问


2.4在实现部分中定义实例变量：

Xcode4.2之后的编译器clang，允许在实现部分中定义类的实例变量

上述三原色类子中，可以采用如下的方法定义：
//接口部分
@interface RGB : NSObject
-(id) initWithRed:(int)r green:(int)g blue:(int)b;
-(id)blendColor:(RGB *)color;
-(void)print;
@end

//实现部分
@implementation RGB{
	unsigned char red,green,blue;//实例变量
}
-(id)initWithRed:(int)r green:(int)g blue:(int) b
…

@end
    """},
  {'title' : '第四章（3）' , 'message' : """
   1.类对象

1.1什么是类对象

objc中只有类方法的概念，没有类变量的概念

1.2类对象的类型

id类型可以表示任何对象，类对象也可以用id类型来表示，Objc中还专门定义了一个Class类型来表示类对象，所有的类对象都是Class类型，Class类型和id一样都是指针类型，只是一个地址，并不需要了解实际指向的内容。

1.3类方法的定义

实例方法在接口声明和实现文件中都以“-”开头，类方法则于此相反，以“+”开头，alloc方法的定义如下：
+（id）alloc；

类方法的语法比较简单，但实际使用时要注意一下几点：
	首先，类方法中不能访问类中定义的实例变量和实例方法。类对象只有一个，类的实例对象可以有任意个。所以如果类对象可以访问实例变量，就会不清楚访问的到底是哪个实例对象的变量。类方法中也不能访问实例方法。
	其次，类方法在执行时用self代表类类对象自身，因此可以通过给self发送消息的方式来调用类中的其他类方法。
	调用父类的类方法时，可以使用super

1.4类变量

Objc通过在实现文件中定义静态变量的方法来代替类变量
Objc在实现文件中定义了静态变量后，该变量的作用域就变成只在该文件内有效
Objc中类变量原则上只在类的内部实现中使用，在进行设计时要充分考虑到这一点

1.5类对象的初始化

Objc中实例对象的生成一般分为2步，第一步是通过alloc为对象分配内存，第二部是对内存进行初始化，也就是对对象的各个成员赋予初值。可以通过给实例对象发送init消息来完成第二步的初始化。

Objc的跟类NSObject中存在一个initialize类方法，可以通过使用这个方法来为各类对象进行初始化。在每个类接受到消息之前，为之个类调用一次initialize，调用之前要先调用父类initialize方法，每个类的initialize方法只被调用一次

因为在初始化的过程中会自动调用父类的initialize方法，所以子类的initialize方法不用显式调用父类的initialize方法

例：

//8.13 4.5.5
#import <Foundation/Foundation.h>
#import <stdio.h>

@interface A:NSObject
+(void)initialize;
@end

@implementation A
+(void)initialize{
    printf("Im A\n");
}
@end

@interface B :A
+(void)initialize;
+(void)setMessage:(const char *)msg;
-(void)sayHello;
@end

static const char *myMessage ="Hello";

@implementation B
+(void)initialize{
    printf("Im B\n");
}
+(void)setMessage:(const char *)msg{
    myMessage =msg;
}
-(void)sayHello{
    printf("%s \n",myMessage);
}
@end

int main(void){
    id obj = [[B alloc]init];
    [obj sayHello];
    [B setMessage:"Have a good day"];
    [obj sayHello];
    return 0;
}
结果：
￼


1.6初始化方法的返回值

初始化方法的返回值都应该设为id类型


    """},
];