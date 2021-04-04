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
  {'title' : '第五章（1）' , 'message' : """
  1.动态内存管理

1.1内存管理的必要性

程序未能释放已经不再使用的内存叫做 内存泄漏
有效地管理内存，会提高程序的执行效率
如果访问了已经被释放的内存，则会造成数据错误，严重时甚至会导致程序异常终止
指针所指向的对象已被释放或收回的情况下，该指针就称为 悬垂指针或野指针

1.2引用计数、自动引用计数和自动垃圾回收

Cocoa环境的ObjectiveC提供了一种动态的内存管理方式，称为 引用计数
这种方法会跟踪每个对象被引用的次数，当对象的引用次数为0时，系统就会释放这个对象所占用的内存。这本书吧这种内存管理方式称为 基于引用计数的内存管理。

比引用计数内存管理更高级一点的就是自动引用计数 ARC 的内存管理
￼


2.手动引用计数内存管理

2.1引用计数

retain定义：
-(id)retain;
release定义：
-(oneway void)release;
dealloc定义：
-(void)dealloc

retain是 保持的意思，给一个对象发送retain消息，就意味着保持这个对象，生成对象或通过给对象发送retain消息来保持对象这种状态，都可以说是拥有这个对象的所有权。拥有实例所有权的对象为 所有者

2.2测试引用计数的例子：

retain和release是类NSObject的实例方法，方法retainCount可以获得对象引用计数的当前值。retainCount方法没有太大的实用价值，一般在调试程序的时候使用。

允许此程序前，先关闭ARC：
￼

//8.15 5.2.2 内存管理测试
#import <Foundation/NSObject.h>
#import <stdio.h>

int main()
{
    id obj = [[NSObject alloc] init];
    printf("init : %d \n",(int)[obj retainCount]);
    [obj retain];
    printf("init : %d \n",(int)[obj retainCount]);
    [obj retain];
    printf("init : %d \n",(int)[obj retainCount]);
    [obj release];
    printf("init : %d \n",(int)[obj retainCount]);
    [obj release];
    printf("init : %d \n",(int)[obj retainCount]);
    [obj release];
    
    return 0;
}

结果：
￼

2.3释放对象的方法：

在自定义类的时候，如果类的实例变量是一个对象类型，那么在销毁类的对象的时候。也要给类的实例变量发送release消息
释放一个类的实例对象是，为类彻底释放该实例对象所保持的所有对象的所有权，需要为该类重写dealloc方法，在其中释放已经分配的资源，放弃实例变量的所有权。一位最终释放内存的是dealloc方法所以不能重写release方法
-(void)dealloc //重写的是dealloc方法而不是release方法
{	
	/*
		这里通过release方法放弃子类中所有实例变量的所有权。
		其他用于释放前的善后操作也都写在这里
	*/
	[super dealloc];
}

2.4访问方法和对象所有权

在通过访问方法等改变拥有实例变量所有权的对象时，必须注意实例变量引用计数的变化，合理安排release和retain的先后顺序

例：setMyValue方法：
-(void)setMvalue:(id) obj{
	[myValue release];
	myValue = [obj retain];
}

绝大多数情况下这个方法没有问题，只有在参数obj和myValue是同一个对象的时候会出错

安全的setter写法：
￼

如果不考虑对象的所有权，而只是单纯的赋值的话，则不需要保持和释放。
不考虑所有权的setter方法：
-(void)setMyValue:(id)obj
{
	myValue =obj;
}


2.5自动释放

Cocoa环境的Objec提供了一种对象自动释放的机制，这种机制的基本思想是把虽有需要发送release消息的对象记录下来，等到需要释放这些对象时，会给这些对象一起发送release消息。
其中，类NSAutoreleasePool（自动释放池）就起到了记录的作用

首先让我们生成一个NSAutoreleasePool的实例对象。当向一个对象发送autorelease消息时，实际上就会将该对象添加到NSAutoreleasePool中，将它标记为以后释放。
这个时候，因为这个对象没有被释放，所以还可以继续使用，对象引用计数的值也没有变化，但发送autorelease消息和发送release消息一样，相当于宣布放弃了对象的所有权。这样一来，当自动释放池被销毁时，池中记录的所有对象就都会被发送release消息

autorelease放大的定义如下：

-(id)autorelease

其返回值时接受对象的消息。
本书中把自动释放池中登陆的实际上相当于放弃了所有权的对象称为临时对象。

自动释放池的典型用法如下：

id pool =[[NSAutoreleasePool alloc] init];
/*
	在此进行一系列操作
	给临时对象发送autorelease消息。
*/
[pool release]; //销毁自动释放池，自动释放池中所有的对象也被销毁


2.6使用自动释放池时需要注意的地方

autorelease虽然时NSObject类的方法，但必须和类NSAutoreleasePool一起使用

某些需要长时间允许的代码段或大量使用临时对象的代码段可以通过定义临时的自动释放池来提高内存的利用率，例如：一个大量使用临时变量的循环中，经常会在循环开始时创建自己的自动释放池，在循环结束时释放这个自动释放池：

while (…){
	id pool = [[NSAutoreleasePoll alloc] init];
	/*
	再次进行一系列操作
	*/
	[pool release];
}

但是要注意的是，如果在循环过程中通过continue或break跳出循环的话，将可能导致自动释放池本身没有释放掉。
另外，循环外也可以使用循环内生成的临时对象，但需要事先在循环给对象发送retain消息，同时在循环外给对象发送autorelease消息。


2.7临时对象的生产

当你使用alloc init方法创建一个对象时，该对象的初始引用计数位1，当不再使用该对象时，你要负责销毁它。
例如Cocoa里用于处理字符串的类NSString，由UTF-8 编码的C风格字符串生产NSString对象的方法有2个

-(id)initWithUTF8String:(const char *)bytes;
alloc生成的实例对象的初始化方法，生成的实例对象的初始引用计数为1.
+(id)stringWithUTF8String:(const char *)bytes;
生成临时变量的类方法，生成的实例对象会被自动加入到自动释放池中

这种生成临睡对象的类方法没在OnjectiveC中称为便利构造函数 或 便利构造器，一些面向对象的语言会把生成对象的函数叫做构造函数，以和普通的函数进行区分。把在内部调用别的构造函数而生成的构造函数叫做便利构造函数。

在objectivC语言中，便利构造函数指的就是这种利用alloc、init和autorelease生成临时对象的类方法。

2.8运行回路和自动释放池

典型的图形界面应用程序（GUI）往往会在休眠中等待用户操作，例如 操作时表或者键盘点击菜单按钮等，在用户发出动作之前，程序将一直处于空闲状态。当点击事件发生后，程序会被唤醒并开始工作，执行某些必要的操作以响应这一事件。处理完这一事件后，程序又回返回到休眠状态并等待下一个事件的到来。这个过程被叫做运行回路

2.9常量对象

内存中常量对象的空间分配和其他对象不同，他们没有引用计数机制，永远不能释放这些对象，给这些对象发送消息retainCount后，返回的是NSUIntegerMax（值为0Xffffffff，被定义为最大的无符号整数）。

有的时候，我们可能会需要某个类仅能生成一个实例，程序访问到这个类的对象时使用的都是同一个实例对象，在设计模式中这种情况被称为单例模式，Cocoa框架中有很多单例模式的应用

单例模式的实现如下所示，建议定义一个无论何时都能只返回同一个实例对象的类方法。但要注意的是，在继承和多线程的情况下，这个实现还需要完善。

+(MyComponent *)sharedMyComponent{
	static MyComponent *shared;
	if(shared ==nil)
		shared = [[MyComponent alloc] init];
	return shared;
}


    """},
  {'title' : '第五章（2）' , 'message' : """
  1.分数计算器的例子

1.1分数类Fraction
 
下面让我们在手动引用计数的内存管理方式下，定义一个简单的分数类。并基于这个类做一个支持分数计算的计算器。

分数类的接口部分 Fraction.h

#import <Foundation/NSObject.h>

@class NSString

@interface Fraction :NSObject{
    int sgn;//sign （符号为）
    int num;//numerator(分子)
    int den;//denominator(分母)
}

//用于生成分数类的临时对象，有两个参数分别用于指定分子和分母
+(id)fractionWithNumerator:(int)n denominatior:(int)d;
//指定初始化函数，两个参数分别用于初始化分子和分母，分子或分母是负数时，整个分数的符号位就为负。
-(id)initWithNumerator:(int)n denominator:(int)d;
//四个方法用于分数的四则运算，计算结果返回Fraction类的一个新对象
-(Fraction *)add:(Fraction *)obj;
-(Fraction *)sub:(Fraction *)obj;
-(Fraction *)mul:(Fraction *)obj;
-(Fraction *)div:(Fraction *)obj;
-(NSString *)description;

@end

分数类的实现部分 Fraction.m

#import "Fraction.h"
#import <Foundation/NSString.h>
#import <stdlib.h>

@implementation Fraction

static int gcd(int a,int b) //Greatest Common Divisor 最大公约数
{
    if(a<b){
        return gcd(b, a);
    }
    if(b == 0)
        return a;
    return gcd(b,a%b);
}

//Local Method
-(void)reduce{
    int d;
    if(num == 0){
        sgn = 1;
        den =1;
        return ;
    }
    if(den ==0){
        //infinity
        num =1;
        return ;
    }
    if((d =gcd(num, den))==1){
        return;
    }
    num /= d;
    den /=d;
}

//生成临时对象

+(id)fractionWithNumerator:(int)n denominatior:(int)d   {
    id f= [[self alloc]initWithNumerator:n denominator:d];
    return [f autorelease];
}

#define SIGN(a) (((a)>=0)?1:(-1))

//指定初始化函数

-(id)initWithNumerator:(int)n denominator:(int)d{
    if((self =[super init]) != nil){
        sgn =SIGN(n) *SIGN(d);
        num =abs(n);
        den = abs(d);
        [self reduce];
    }
    return self;
}
-(Fraction *)add:(Fraction *)obj{
    int n,d;
    if(den ==obj ->den){
        n =sgn *num +obj ->sgn *obj ->num;
        d=den;
    }
    else{
        n =sgn *num *obj ->den+obj ->sgn *obj->num*den;
        d =den*obj->den;
    }
    return [Fraction fractionWithNumerator:n denominatior:d];
}
-(Fraction *)sub:(Fraction *)obj{
    Fraction *tmp;
    int n =-1*obj ->sgn *obj->num;
    tmp=[Fraction fractionWithNumerator:n denominatior:obj->den];
    return [self add:tmp];
}
-(Fraction *)mul:(Fraction *)obj{
    int n=sgn *obj->sgn * num *obj ->num;
    int d = den*obj->den;
    return [Fraction fractionWithNumerator:n denominatior:d];
}
-(Fraction *)div:(Fraction *)obj{
    int n=sgn*obj->sgn*num*obj->den;
    int d = den*obj->num;
    return [Fraction fractionWithNumerator:n denominatior:d];
}
-(NSString *)description{
    int n=(sgn >=0)?num:-num;
    return (den == 1)?[NSString stringWithFormat:@"%d",n]:[NSString stringWithFormat:@"%d/%d",n,den];
}

@end

类方法fractionWithNumerator:denominator:先调用初始化方法生成一个分数对象后向其发送autorelease消息把这个对象加入自动释放池中。这就是上节中介绍到的便利构造函数的一个实际用例
初始化函数initWithNumberator:denominator:被用于初始化实例对象。分子分母都是非负整数面，整个分数的符号为由sgn来表示。同时也会对分子分母进行月份，生成的对象的所有者就是调用这个函数的对象
add方法：参数是一个Fraction类型的对象，所以可以通过->来直接访问它的实例变量。变量n代表加法运算后得到的新分数的分子，d代表新分数的分母。如果双方的分母一致，就直接对分子进行带符号的加法运算。而如果双方的分母不一样，则如同在小学学到的一样明显对双方的分母进行通分，然后再进行加法运算。最后通过方法fractionWithNumberator:denomator：返回分数对象，分数对象的分子和分母分别是n和d。在上述方法中，会自动进行约分操作
sub：方法会反转输入分数的符号位 然后再利用上面的add方法进行减运算。
mul和div方法则是完成分数的乘法和除法运算

description方法的功能是生成一个NSString类型的结果，来表示分数类的分数，类方法stringWithFormat:能够像printf（）格式化输出一样，按照规定的格式生成字符串。


1.2保存计算结果的FracRegister类

计算器一般都有一个液晶显示屏，来显示计算的结果，这里我们也来实现一个具有相同功能的类FracRegister，并尝试为其增加输入错误时可以显示上次的计算结果这一功能（也就是undo功能）

分数寄存器的接口部分（FracRegister.h）

#ifndef FracRegister_h
#define FracRegister_h
#import <Foundation/NSObject.h>
#import "Fraction.h"

@interface FracRegister : NSObject{
    Fraction *current;
    Fraction *prev;
}

-(id)init;
-(void)dealloc;
-(Fraction *)currentValue;
-(void)setCurrentValue:(Fraction *)val;
-(BOOL)undoCalc;
-(void)calculate:(char)op with:(Fraction *)arg;

@end

#endif /* FracRegister_h */


变量current和prev分别表示当前的计算结果和上次的计算结果，并未current变量定义get和set访问方法，方法clculate用于计算，计算的类型用char字符来表示

分数寄存器的实现部分（FracRegister.m）

#import "FracRegister.h"
#import <stdio.h>

@implementation FracRegister
-(id)init{
    if((self =[super init]) !=nil)
        current = prev =nil;
    return self;
}
-(void)dealloc{
    [current release];
    [prev release];
    [super dealloc];
}
-(Fraction *)currentValue{
    return current;
}
-(void)setCurrentValue:(Fraction *)val{
    [val retain];
    [current release];
    current = val;
    [prev release];
    prev =nil;
}
-(BOOL)undoCalc{
    if (prev == nil)
        return NO;
    [current release];
    current =prev;
    prev =nil;
    return YES;
}

-(void)calculate:(char)op with:(Fraction *)arg{
    Fraction *result =nil;
    if(current != nil && arg !=nil){
        switch (op) {
            case '+':
                result = [ current add :arg];
                break;
            case '-':
                result =[current sub :arg];
                break;
            case '*':
                result=[current mul:arg];
                break;
            case '/':
                result=[current div :arg];
                break;
            default: //Error
                break;
        }
        if(result !=nil){
            [result retain];//保存运算结果
            [prev release];
            prev = current;
            current = result;
        }
        else{
            printf("Illegal Opration\n");
        }
    }
}
@end

初始化函数init中把current和prev的值都设为了nil。因为即使不通过init函数初始化current和prev的初始值也会时0.所以这个init函数不是必须的。
方法dealloc 中释放了current和prev
方法undocalc执行undo操作，如果prev不为nil，则释放当前值current，并把prev赋值给current，如果prev为nil，则无法完成undo操作，返回NO；
setCurrentValue：是变量current的setter方法，用于设置current的值，同时将prev设为nil，这里也可以把prev设为current的原值。

main函数的执行流程是：首先输入一个分数（或整数），接着输入一个运算符和一个分数，这时程序就会输出运算结果，然后在输入一个运算符和分数，程序再次输出运算结果

输入q代表程序结束，输入C表示clear，即清楚当前的计算结果并重新开始，输入u代表undo操作，即使用上次的计算结果代替当前的计算结果

函数getFraction（）用于从命令行读入分数值，支持的输入格式有分数、整数和带分数。

分数计算器的main函数

#import "FracRegister.h"
#import "Fraction.h"
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <stdio.h>

#define BUFSIZE 80

static Fraction *getFraction(const char *buf){
    int a,b,c;
    if(sscanf(buf, "%d'%d/%d",&a,&b,&c) ==3)
        b=(a<0)?(a*c-b):(a*c+b) ;
    else if(sscanf(buf, "%d/%d",&b,&c) !=2){
        if(sscanf(buf, "%d",&b) ==1)
            c= 1;
        else
            return nil;
    }
    return [Fraction fractionWithNumerator:b denominatior:c];
}

static Fraction *readFraction(FILE *fp){
    char buf[BUFSIZE];
    Fraction *frac =nil;
    for(;;){
        if(fgets(buf,BUFSIZE,fp) ==NULL) //EOF is input
            return nil;
        if((frac =getFraction(buf) )!=nil)
            break;
    }
    return frac;
}

int main(void){
    char com[BUFSIZE],cc;
    BOOL contflag =YES;
    NSAutoreleasePool *pool ,*tmppool;
    FracRegister *reg;
    Fraction *val;
    
    pool =[[NSAutoreleasePool alloc] init];
    reg = [[[FracRegister alloc]init]autorelease];
    while(contflag){ // 1
        tmppool =[[NSAutoreleasePool alloc]init];
        printf("?");
        if((val =readFraction(stdin)) !=nil)
            [reg setCurrentValue:val];
        else
            contflag =NO;
        while (contflag) { //2
            if(fgets(com, BUFSIZE, stdin) == NULL
               || (cc =com[0]) == 'q' || cc == 'Q'){ //3
                contflag =NO;
                break;
            }
            if( cc=='c' || cc=='C' )//clear
                break;
            if( cc == '+' || cc == '-' || cc=='*' || cc=='/'){
                if((val =getFraction(com+1)) == nil) //4
                    val =readFraction(stdin);
                if(val ==nil){//EOF
                    contflag =NO;
                    break;
                }
                [reg calculate:cc with:val];
            }
            else if( cc =='u' || cc=='U'){ //Undo
                if(![reg undoCalc])
                    printf("Cant UNDO\n");
            }else{
                printf("Illegal operator\n");
                continue;
            }
            printf("= %s\n",[[[reg currentValue]description]UTF8String]);
        }
        [tmppool release];//5
    }
    [pool release];
    return 0;
}

结果：
￼

main函数中先创建了一个FracRegister类的对象reg。
代码中的 1 和 2 处 是一个循环，当contflag变量为真的情况下处理继续，否则程序终止
2处的循环在程序进行运算或执行undo操作期间会继续，并在循环的最后在类FracRegister的实例reg中显示当前的计算结果。方法description返回的是NSString类型的字符串，这里使用了UTFString方法以将其转换为C风格的字符串。
3处首先读入一行输入，然后判断首字符是控制命令还是运算符。如果是运算符的话就继续判断运算符之后是否是分数，如果是分数就调用fetFraction进行计算，如果不是则调用readFraction继续读入。
在2处 如果输入了控制命令c。q 或用contronl-D 结束了程序，就会跳出循环。
5处会释放自动释放池。 


    """},
  {'title' : '第五章（3）' , 'message' : """
 1.ARC概要

1.1什么是ARC

采用引用计数方式管理内存时需要程序员管理所有生成对象的所有权。程序员需要清楚地了解获得/放弃对象所有权的时机，并在适当的位置插入retain，release或autorelease函数

ARC（自动引用计数）是一个编译期计数，利用此技术可以简化ObjectiveC在内存管理方面的工作量。ARC通过在编译期间添加适合的retain/release/autorelease等函数，来确保对象被正确地释放。编译器会根据传入的变量是局部变量还是引用变量，返回对象的方法是不是初始化方法等信息来推断应当在何处加入retaion/release/autorelease等函数

1.2禁止调用引用计数的相关函数

ARC有效程序，不能调用以下这些跟引用计数相关的方法
retain
release
autorelease
retainCount
当然也不能使用这些函数的selector等

1.3管理自动释放池的新语法

ARC中禁止使用NSAutoReleasePool。而是使用新语法@autoreleasepool来管理自动释放池
手动管理内存的情况下，自动释放池的使用方法如下所示：
id pool =[[NSAutoreleasePool alloc] init];
	/*进行一系列操作*/
	/*此处不可以使用break、return、goto之类的语句*/
[pool release]; /*释放对象*/

新的语法如下所示：
@autoreleasepool{
	/*进行一系列操作*/
	/*可以使用break、return、goto语句*/
}

另外@autoreleasepool在非ARC模式下也能使用，并且使用@autoreleasepool比使用NSAutoReleasePool性能更好 效率更高

1.4变量的初始值：

在ARC中，未指定初始值的变量（包括局部变量）都会被初始化为nil
但是对于用 _autoreleasing和_unsafe_unretained修饰的变量来说，初始值是未定的
而对象以外的变量的初值则和以前是一样的

1.5方法族

采用引用计数方式管理内存时，创建对象时就会拥有这个对象的所有权。例如，使用以alloc开头的类方法生成对象，并使用以init开头的类方法来初始化对象的时候，就会获得这个对象的所有权，另外，使用名称中包含new、copy、mutableCopy的方法复制对象时 也会获得这个对象的所有权
采用引用计数方式管理内存时，如果不使用alloc/init/new/copy/mutableCopy这些方法、或者不使用retain来保留一个对象，就不能成为对象的所有者。另外，只有使用release或者autorelease，才能够放弃这个对象的所有权

这些规定被叫做 所有权策略。

可被保持的对象：ObjectiveC的对象或14章中说明的block对象
alloc方法族：以alloc开头的方法表示调用者对被创建的对象拥有所有权，返回的对象必须是可以被retain的
copy方法族：以copy开头的方法表示调用者对被创建的对象拥有所有权，返回的对象必须是可以被retain的
mutableCopy方法族：以mutableCopy开头的方法表示调用者对被创建的对象拥有所有权，返回的对象必须是可以被retain的
new方法族：以new开头的方法表示调用者对被创建的对象拥有所有权，返回的对象必须是可以被retain的
init方法族：以init开头的方法必须被定义为实例方法，它一定要返回id类型或父类子类的指针。

给方法命名时必须遵循命名规则。严守内存管理相关的函数命名规则

1.6方法dealloc的定义

￼


1.7使用ARC的程序编译

启用ARC编译代码时，不能使用gcc而要使用clang。同时编译选项要加上 -fobjc-arc 

￼

1.8ARC的基本注意事项

- [ ] 不能在程序中定义和使用下面这些函数：retain、release、autorelease、retainCount
- [ ] 使用@autoreleasepool代替NSAutoreleasePool
- [ ] 方法命名必须遵守命名规则，不能随意定义以alloc/init/new/copy/mutableCopy开头且和所有权操作无关的方法
- [ ] 不用在dealloc中释放实例变量（但可以在dealloc中释放资源）也不需要调用[super dealloc]
- [ ] 编译代码时使用编译器clang，并加上-fobjc-arc

1.9使用ARC重构分数计算器

首先来看一下类Fraction的类方法fractionWithNumerator：
ARC有效的情况下，需要删除方法中使用autorelease因为方法fractionWithNumberator：并不以alloc/new/copu/mutableCopy/init开头，所以这个方法生成的对象时一个临时对象，编译器会讲生成的对象自动放入autoReleasePool中

+(id)fractionWithNumerator:(int)n denominatior:(int)d   {
    return [[slef alloc] initWithNumerator:n denominator:d];
}

下面让我们来看看实现文件FracRegister.m中要修改的地方。首先是dealloc方法，因为当前的dealloc方法只release了类FracRegister的实例变量，所以可以将真个dealloc方法删除掉
其次是方法setCurrentValue：，按照ARC中的要求吗需要删除其中的retain和release方法
最后是方法undoCalc和calculate：with：统一需要删除其中的retain和release方法

main函数中需要用@autoreleasepool替换NSAutoreleasePool，因为@autoreleasepool中允许使用break或goto语句，所以可以删掉原来的二重循环

int main(void){
    char com[BUFSIZE],cc;
    BOOL contflag =YES;
    FracRegister *reg;
    Fraction *val;
    
    @autoreleasepool{
        reg = [[FracRegister alloc]init];
        while(contflag){ // 1
             @autoreleasepool{
                printf("?");
                if((val =readFraction(stdin)) !=nil)
                    [reg setCurrentValue:val];
                else
                    contflag =NO;
                while (contflag) { //2
                    if(fgets(com, BUFSIZE, stdin) == NULL
                       || (cc =com[0]) == 'q' || cc == 'Q'){ //3
                        contflag =NO;
                        break;
                    }
                    if( cc=='c' || cc=='C' )//clear
                        break;
                    if( cc == '+' || cc == '-' || cc=='*' || cc=='/'){
                        if((val =getFraction(com+1)) == nil) //4
                            val =readFraction(stdin);
                        if(val ==nil){//EOF
                            contflag =NO;
                            break;
                        }
                        [reg calculate:cc with:val];
                    }
                    else if( cc =='u' || cc=='U'){ //Undo
                        if(![reg undoCalc])
                            printf("Cant UNDO\n");
                    }else{
                        printf("Illegal operator\n");
                        continue;
                    }
                    printf("= %s\n",[[[reg currentValue]description]UTF8String]);
                }
             }
        }
    }
    return 0;
}
    """},
  {'title' : '第五章（4）' , 'message' : """
1.循环引用和弱引用

1.1循环引用

例子：

@interface People : NSObject{
    id friden;
}
-(void)setFriend:(id)obj;
@end

@implementation People
-(void)setFriend:(id)obj{
    d tmp = friden;
    [obj retain];
    friden = obj;
    [tmp release];
}
-(void)dealloc{
    [friden release];
    [super dealloc];
}
@end

People 的两个实例对象（A和B）互相引用的情况
[A setFriend : B];
[B setFriend : A];

这种情况下，就算想将A和B都释放掉，但按照规则，也只有等到释放B之后才有可能释放A（否则A的引用计数为1，无法释放），同样，只有释放A后才能释放B（原因同前），而当双方都在等待对方释放的时候，就形成了循环引用，结果2个对象都不会释放，这样几句造成内存泄漏。虽然通过设定A的friend为nil 手动打破A和B的循环引用关系可以完成内存释放，但这样做法比较麻烦，容易出错。

像这种2个对象互相引用，或者像A持有B、B持有C、C持有A这样对个对象的引用关系形成了环的现象，叫做循环引用或者循环保持。循环引用会造成内存泄漏，只有打破循环引用关系才能释放内存

1.2所有权和对象间的关系
￼
上图展示了两种比较常见的对象间的关系
（1）中对象间的关系类似于树形结构，父节点是子节点的所有者。用实际的例子来比喻的话，就像窗口上有几个控件对象，而其中每个控件本身又是由另外一些小控件组成的。（1）中，对象A是BCD的所有者，D是EF的所有者，释放A的时候要先释放BCD，释放D的时候要先释放EF。

（1）中吗，对象C指向A。对象F指向D的虚线，就是指向自己父节点的指针，也被叫做反响指针，为了避免循环引用的发生，可以使用无关所有权的指针来实现这种关系，

（2）中各个对象之间的引用关系更像一种网状关系，这种情况下比较容易发生循环引用的问题，使用和所有权无关的指针时要注意的是，当你需要使用对象时，对方可能已经在不知不觉中释放了。

总而言之拥有所有权的实例变量和只通过指针指向、不拥有所有权的变量在内存方面的处理截然不同，如果处理不当就会造成内存泄漏

1.3弱引用

到目前为止，我们介绍ARC时提到的实例变量都是拥有所有权的实例变量（强引用类型，默认属性）但为了避免循环引用的出现，我们还需要另外一种类型的变量，这种变量能够引用对象，但不会成为对象的所有者，不影响对象本身的回收。
未来实现这个目的，ARC中引入了弱引用的概念，弱引用时通过存储一个指向对象的指针创建的，且不保留对象，ObjectiveC中__weak修饰符来定义弱引用

__weak id temp;
__weak NSObject *cacheObj;

通常声明未加__weak修饰符的变量都是强引用类型的变量，声明时也可以通过加上__strong修饰符来明示变量时强引用类型，函数和方法的参数也是强引用类型。

声明变量的时候，__weak可以出现在声明中的任意位置，但要注意的是，最后一个声明的变量f前不可省略__weak

__weak NSObject *a,*b;
NSObject __weak *c,*d;
NSObject *__weak e,*__weak f;

强引用和弱引用都会被隐式地初始化为nil。
这种用于修饰指针类型变量的修饰符被叫做生命周期修饰符或所有权修饰符。声明周期修饰符一共有四种，除了我们已经介绍的strong __weak 之外还有 __autoreleaseing \ __unsafe_unretainded

1.4自动nil化的弱引用

弱引用会在其指向的实例被释放后自动变成nil，这就是弱引用的自动nil化功能。也就是说，即使弱引用指向的实例对象在不知不觉中就释放了，弱引用也不会变成野指针。
通过例子来看弱引用 自动nil化如何工作：
例子中的People类有一个弱引用类型的实例变量friend。方法nameOfFriend用于返回friend指向的对象name实例变量，如果friend为nil，则返回none，
main函数中会声明People类的两个实例对象a和b，变量b会在从自动释放池中退出的时候释放掉。

使用弱引用的一个例子

friend.m
#import <Foundation/Foundation.h>
#import <stdio.h>

@interface People :NSObject{
    const char *name;
    __weak People *friend;
}
-(id)initWithName:(const char *)p;
-(void)setFriend:(id)obj;
-(const char *)nameOfFriend;

@end

@implementation People
-(id)initWithName:(const char *)p{
    if((self =[super init])!=nil ){
        name =p;
        friend =nil;
    }
    return self;
}
-(void)setFriend:(id)obj{
    friend =obj;
}
-(const char *)nameOfFriend{
    if(friend ==nil)
        return "none";
    return friend->name;
}
@end

int main(void){
    People *a = [[People alloc] initWithName:"Alice"];
    printf("friend : %s \n",[a nameOfFriend]);
    @autoreleasepool{
        People *b =[[People alloc ]initWithName:"Bob"];
        [a setFriend:b];
        printf("Friend :%s\n",[a nameOfFriend]);
        b =nil;
    }
    printf("Friend :%s \n",[a nameOfFriend]);
    return 0;
}

结果：
￼

最后一行的输出表示对象a的实例变量friend已经变成了nil，也就是说，弱引用friend指向的实例变量被释放后，friend自动变成了nil

在ARC条件下编程时最需要注意的就是不要形成循环引用，通过使用弱引用既可以防止生成循环引用，又可以防止对象被释放后形成野指针。虽然弱引用有很多好处，但也不能滥用。
由于ARc中只有强引用才能改变对象的引用计数，保持住对象，因此，如果像保持住对象，至少要为其赋值一个强引用类型的变量，下面这行代码是一个极端的例子，因为赋值了一个弱引用，所以生成的对象会被立刻释放掉：

__weak People *w =[[People alloc ] initWithName:”Lucy”];

1.5对象之间引用关系的基本原则

面对对象的编程中，一个对象的实例变量引用着另外的对象，对象之间是通过引用链接在一起的额，如果把这些关系画出来，就可能得到一张图（关于图的具体概念参考计算机图论），因此，我们就把这些对象（和他们之间的联系）称为对象图。
对象图中的环路就是循环引用产生的原因，使用ARC的时候应该尽量保持对象之间的关系呈树形结构。


2.ARC编程时其他一些注意事项

2.1可以像通常的指针一样使用的对象

使用ARC的时候，如果既不想保持赋值的对象，也不想赋值的对象在释放后自动设为nil。可以使用生命周期修饰符__unsafe_unretained 其所修饰的变量称为非nil化的弱指针，也就是说如果指向的内存区域被释放了，这个指针就是一个野指针了

一个__unsafe_unretained的例子：

People *s,*a;
__unsafe_unretained People *u;
s =[[People alloc]initWithName :”Shelly”];
u =s;//s被赋值给u，但所有权不会加1
a =u;//变量a是强引用类型，所以赋值操作之后所有权会加1
u nil;//所有权不会发生变更

这里首先声明了强引用类型的变量s和a，及一个__unsafe_unretained类型的变量u，然后生成一个实例对象并赋值为s，因为u是弱引用类型的变量，所以当u=s时s的所有权不变；接着u赋值给a，因为a是强引用类型的变量，所以赋值后a的所有权加1，最后把nil赋值给u，因为u是弱引用类型的变量，所以u的所有权不会发生改变，另外，因为u是弱引用类型，不会保持对象所以不能把生成的对象直接赋值给u，否则生成的对象就会被立刻释放掉

2.2setter方法的注意事项

ARC有效的情况下，使用setter方法时也有些要注意的地方
当前所述，ARC有效的情况下，变量默认为__strong类型，用__weak修饰的变量不会进行保持操作，其指向的对象被释放后，变量会自动变成nil
有一种减少野指针出现的方法是，当不再使用传入的对象时，将其赋值为nil，典型的做法就是在dealloc方法中进行如下处理：

[someone setFriend :nil];
[controller setDelegate : nil];

2.3通过函数的参数返回结果对象

当一个函数或方法有多个返回值时，我们可以通过函数或方法的参数传入一个指针，将返回值写入指针所指向的空间，C语言中把这种方法叫做 按引用传递 ObjectiveC的ARC中也有类似的方法，但采用了和C语言不用的实现方式，叫做 写回传

写回传经常被用于当一个方法在处理过程中出现错误，通过指向NSError的二重指针返回错误的种类和原因，下面这个声明时NSString的一个初始化函数，它会从指定的文件读入内容来完成NSString的初始化。如果初始化失败，则通过error返回错误的种类和原因，error的二重指针类型 *error指向的是NSError*类型的变量

-(id)initWithContentOfFile:(NSString *)path
	encoding:(NSStringEncoding)enc;
	error:(NSError **)error;

ARC编译器会自动为函数的二重指针加上__autoreleasing修饰符，在ARC有效的情况下，可以编译成：

-(id)initWithContentOfFile:(NSString *)path
	encoding:(NSStringEncoding)enc;
	error:(__autoreleasing NSError **)error;

__autoreleasing的根本目的是获得一个延迟释放的对象，比如假设你想传递一个未初始化的对象的引用到一个方法中 并在此方法中实例化此对象，而且希望方法返回时这个对象会被加入到自动释放池中，那么你就应该使用__autoreleasing关键字，吊影initWithContentsOfFile时的代码如下所示：

NSError *error = nil;
NSString *string =[[NSString alloc ] initWithContentOfFile : @“/path/to/file.txt” encoding:NSUTF8StringEncoding error :&error];

编译器会把这段代码转为以下代码：

NSError __string *error = nil;
NSError __sutoreleasing * temError =error;
NSString *string =[[NSString alloc ] initWithContentOfFile : @“/path/to/file.txt” encoding:NSUTF8StringEncoding error :&tmpError];
error =tmpError;

编译器生成了一个临时变量tmpError 执行完函数之后又将临时变量赋值给了error，error被加入到了自动释放池中，会一直存在到自动释放池释放为止。


2.4C语言数组保存ObjectiveC对象

ARC有效的程序中可以用C语言数组保存ObjectiveC对象

保存ObjectiveC对象的C数组

array.m

int main(void){
    People *a[4];
    static const char *const names[] ={"Laura","Donna","James","Audrey"};
    @autoreleasepool{
        for(int i=0;i<4;i++)
            a[i] =[[People alloc]initWithName:names[i]];
        [People makeFrineds: &a[0]];//a[0]和a[1]互为好朋友
        [People makeFrineds: &a[2]];//a[2]和a[3]互为好朋友
        a[0] =nil;
    }
    [People printFriends:a number :4];
    return 0;
}

为People类追加的类方法

+(void)makeFriends:(People *__strong [])p;
+(void)printFriends:(People *const [])p number:(int)n;


+(void)makeFriends:(People *__strong [])p{
    [p[0] setFriend:p[1]];
    [p[1] setFriend:p[0]];//因为friend是弱引用类型，所以就算互相引用也不会产生循环引用的问题
}

+(void)printFriends:(People *const [])p number:(int)n{
    for(int i=0;i<n;i++)
        printf("%d:%s\n",i,[p[i] nameOfFriend]);
}

结果：
￼

动态分配内存的例子

int main(void){
    People *__strong *a;/*必须添加__strong修饰符，__strong修饰符的位置也可以在最前面*/
    static const char *const names[] ={"Laura","Donna","James","Audrey"};
    a = (People *__strong *)calloc(sizeof(People *),4);
    /*因为生成的对象的所有成员变量都要被初始化为nil，所以使用了calloc（）。动态分配完内存后，自动将该内存空间初始化为0*/
    //赋值的时候进行类型转化
    @autoreleasepool{
        for(int i=0;i<4;i++)
            a[i] =[[People alloc]initWithName:names[i]];
        [People makeFriends: &a[0]];//a[0]和a[1]互为好朋友
        [People makeFriends: &a[2]];//a[2]和a[3]互为好朋友
        a[0] =nil;
    }
    [People printFriends:a number :4];
    for(int i=0;i<4;i++)
        a[i] =nil;
    free(a);
    return 0;
}

首先必须显式给变量a加上__strong 修饰符，以防止编译器自动给变量加上__autoreleasing修饰符
另外ARC中不可以使用memeset() bzero() mencpy()等擦欧哦中内存的函数，因为ARC会监视这些函数的行为，所以使用了这些函数后就可能造成内存段的错误。

2.5ARC对结构体的一些限制

ARC有效的情况下，不可以在C语言的结构体中定义ObjectiveC的对象，原因是编译器不能自动释放结构体内部的objcetiveC对象
例如下面这种定义将出现编译错误“Error ARC for Objective-C objs in structs or unions”

struct Element{
	id person ; //不能定义id类型的对象
	NSString *address;//也不能定义NSStirng类型的对象
	int age;
}

一种比较常见的解决方法就是使用objectiveC中的类来歹徒结构体。

struct Element{
	__unsafe_unretained id person ;
	__unsafe_unretained NSString *address;
	int age;
}

我们经常会用准备好的结构体数组来初始化程序，NSString类型的常量字符串可以直接放入C语言的静态数组中，下面的例子是ARC有效的情况下结构体数组的声明方法，@开头的字符串表示的是NSString类型的常量字符串
static struct {
	const __unsafe_unretained NSString *name;
	int age;
}initialData[] ={
	{@“Laura”,17},{@“Donna”,17},…
};

2.6提示编译器进行特别处理

未使用ARC的时候 你可能没有按照ARC中的命名规则来为方法起名，而这种情况下如果某些原因没法修改这些方法的名字，那么将这些代码迁移到ARC环境中就会出现问题。这时可以通过给方法加上实现定义好的一些宏来告诉编译器应该如何对这个方法的返回值进行内存管理

宏的声明需要放到方法末尾：
NS_RETURNS_RETAINED
	指明这个方法和init或copy开头的方法一样，由调用端负责释放返回的对象
NS_RETURNS_NOT_RETAINED
指明这个方法不属于内存管理的方法，调用端无需释放返回的对象

例如newMoon这个方法，如从命名规则的角度来考虑，他属于new方法族，但如果希望这个方法不改变返回值的所有权，就可以为方法加上NS_RETURNS_NOT_RETAINED

+(FishingDate *)newMoon NS_RETURNS_NOT_RETAINED;

但要注意的是，大家还是应该尽可能地修改方法名使其符合命名规则
编译时，这些宏会被替换为 注释
    """},
  {'title' : '第六章（1）' , 'message' : """
1.垃圾回收的概要

垃圾回收是MacOS X 10.5之后开始引入的内存管理方法

1.1查找不再使用的对象

垃圾回收：指的是在程序运行过程中，检查是否有不再使用的对象，并自动释放他们所占用的内存，通常被简称为CC。
内存的检查和回收都是由垃圾收集器 完成的
在ObjectiveC 2.0中，垃圾回收首先进行的工作就是识别不允许被回收的对象
	首先，全局变量和静态变量引用的对象不允许被回收。
	另外，栈内临时变量引用的对象也不允许被回收，
这些对象称为根合集，如果一个对象的实例变量引用了不允许被回收的对象或根合集中的对象，那么这个对象也不允许被回收

也就是说，通过全局变量、静态变量或者栈内变量的引用而查找到的对象都不可以被回收
￼
￼


1.2编程时的注意事项

如下例子进行分析：

id sharedobj =nil;
-(void)methodA{
    id objA=[[Alpha alloc]init];
    [objA doSomething];
}
-(void)methodB{
    id objB =[[Beta alloc]init];
    sharedObj = [[Gamma alloc]init];
    [self methodA];
    sharedobj =[[Zeta alloc] init];
    /*执行到这里会发生什么*/
}

假设程序执行到了methodB中注释的位置时垃圾回收器启动了，这时哪些对象会被回收？
	首先，因为objB时一个栈内对象，所以objB所指向的对象不会被回收
	全局变量sharedObj最开始指向了类Gamma的实例，之后又指向类Zeta的实例，因为全局变量指向的对象不会被回收，所以sharedObj指向的Zeta的实例不会被回收，但类Gamma的实例因为没有被任何对象引用，所以会被回收
	另外，因为方法methodA的执行已经完毕，所以方法methodA中类Alpha的实例也会被回收


手动管理内存时，类setter方法的写法如下所示：
-(void)setHelper:(id)obj{
    [obj retain];
    [helper release];
    helper =obj;
}

垃圾回收有效的情况下msetter方法只需要一个赋值语句就可以了，这时就不需要再对obj和helper执行保持和释放操作，垃圾回收机制会自动判断变量是否可以被回收

-(void)setHelper:(id)obj{
    helper =obj;
}

虽然使用垃圾回收的情况下不需要手动释放每个对象，但如果不在使用的对象属于根合集，这个对象就不会被回收，对于不再使用的对象，我们可以通过为其赋值为nil来明确表示其已不再被使用，据此通知垃圾收集器回收该对象，这种做法不仅有助于垃圾回收，也是一种良好的编程风格。


1.3垃圾收集器

垃圾收集器的运行时自适应的，既不以固定的频率运行，也不能通过程序调用运行。当程序运行过程中分配的内存超高一定量时，垃圾收集器就会被自动触发运行。垃圾收集器通常作为一个单独的线程运行，并对已经不再被使用的对象进行回收

一个程序只有一个垃圾收集器，通常在mainthread中运行

1.4finalize方法的定义

对象中定义了finalize方法的情况下，在对象被回收释放之前finalize方法就会被执行。
finalize方法被定义在NSObject中，典型的定义如下：

-(void)finalize{
    ...
    //释放之前的处理
    [super finalize];
} 
除了子类中调用父类的finalize之外，程序不允许直接调用finalize方法

引用计数的内存管理方式下，在对象被释放的时候，dealloc方法会被执行，finalize可能会被看作是dealloc的替代，但是实际上并不一样，原则上时并不推荐轻易定义finalize，finalize方法会作为垃圾回收的一部分被执行

实现fianlize方法的时候要注意下面这些事项：
1、finalize方法内不用担心其他对象的释放
	和dealloc不一样，不要考虑对象所有权的问题，一个对象是否被释放是在处理中决定的，垃圾收集器会释放不再使用的对象
2、要注意finalize方法中对象的赋值
	fianlize方法中，除了自动变量之外，对其他所有变量的赋值操作都要小心。因为如果被垃圾收集器判断为无用的对象在finalize方法中被再次赋值的话，该对象可能不允许被回收，这个过程叫做复活。一部分编译语言允许复活，ObjectiveC2.0中则不允许这种操作，否则会发生执行时错误，因为finalize中无法知道赋值的对象需不需要被回收，所以贸然进行复活操作是不安全的
3、finalize的执行顺序和对象的释放顺序都是无法确定的
	假设有2个对象AB，他们都是垃圾回收的目标，这时，给A和B发送finalize消息的顺序是无法确定的，而且同A引用B与否无关，对象A在finalize中给B发送消息的时候，对象B的fainalize有可能已经执行完了，也有可能还没有执行。
4、finalize不是线程安全的
	线程安全是指某个函数或函数库在多线程环境中被调用时，也能够正确的处理各个线程的局部变量，使程序功能正常完成，特别是在处理多个实例共有的对象或资源时，要特别注意线程安全问题


1.5编译时的设定
￼


1.6引用计数管理方式中方法的处理

启用垃圾回收后，以下这些和引用计数有关的方法都将无效：
retain
release
autorelease
dealloc
retainCount

把使用引用计数管理内存的代码迁移为垃圾回收管理内存时，就算调用了以上这些方法也不会有任何效果，对象被释放时dealloc方法也不会被执行

伴随着垃圾回收功能的引入，类NSAutoreleasePool增加了新的方法：
-(void) drain
	引用计数的内存管理中，drain和release方法具备同样的功能，即释放自动释放池
	垃圾回收的内存管理中，drain方法表示申请进行垃圾回收，

1.7使用垃圾回收编程小结：

- [ ] 编译的时候需要使用编译选项 -fobjc-gc-only
- [ ] 使用局部变量给方法中的局部对象赋值
- [ ] 如果暂时不想垃圾回收某对象，需要保证该对象能够被全局变量引用
- [ ] 原则上垃圾回收只负责回收id类型或类类型的变量
- [ ] 不用考虑所有权的问题，也不用考虑实例变量的问题
- [ ] 释放对象时的一些善后操作可以写在finalize方法中，但除了不写在finalize中就无法实现的功能，要尽量减少通过finalize完成的操作
- [ ] 引用计数相关的方法和dealloc方法不会被执行

    """},
  {'title' : '第六章（2）' , 'message' : """
1.垃圾回收的详细功能

1.1分代垃圾回收

启用垃圾回收后，会在变量赋值，改写变量时建立写屏障，Objc 2.0利用修改变量时的信息采用 分代垃圾回收 的方式来进行内存管理。

分代垃圾回收并不会每次都对整个堆空间进行遍历，而是以新生成的对象为中心，以尽可能快速地收集那些生命周期短的对象，通过采用这种分代的方法，既可以减轻垃圾回收的处理负担，又能有效释放空间。但也要小心这种方法会积攒太对的陈旧对象。

1.2弱引用

垃圾回收的规则应该是： 从根合集只通过强引用连接到的对象都不属于垃圾回收的目标。

1.3 自动nil化

垃圾回收中弱引用的变量也会自动nil化，当其指向的对象被垃圾收集器释放的时候，就会被自动赋值为nil，强引用类型的对象因为不是垃圾回收的目标，所以不会被自动化nil

1.4通过垃圾回收回收动态分配的内存

目前我们直接少了使用垃圾回收回收对象，实际上通过函数NSAllocateCollectable动态分配的内存也可以被垃圾回收回收。NSAllocateCollectable被定义在Foundation/NSZone.h中

void *__strong NSAllocateCollectable(NSUInteger size,NSUInteger options);

NSUInteger是无符号整数类型，size是以byte为单位的内存大小，第二个参数options一定要指定为常量NSScannedOption返回值是分配好的内存空间首地址，如果内存分配失败就返回NULL

通过这个函数分配的内存和实例变量一样，如果无法通过根合集到达，这块内存就可以被回收
函数返回的指针类型用了__strong 来修饰，也就是说不只限于对象类型，指针也可以用__strong __weak

根据指针的声明不同，垃圾回收的规则也不同：
static void *p=NSAllocateCollectable(SZ, NSScannedOption);
static __weak void *w = NSAllocateCollectable(SZ, NSScannedOption);
static __strong void *s=NSAllocateCollectable(SZ, NSScannedOption);

变量p不是对象类型，当p所指向的内存被回收后，p有可能会变成一个野指针。
变量w被声明为弱指针类型，当w指向的内存被回收后，w会被自动赋值为nil
变量s被声明为强指针类型，他所指向的内存不会被回收
￼

通过NSAllocateCollectable分配的内存因为可以通过垃圾回收被自动回收，所以可以不考虑内存释放的问题，比使用malloc和free编程更方便，但指向除对象之外的动态内存的指针变量都需要用__strong来修饰。结构体中的成员为指针变量的情况下也一样。另外，程序的效率有可能会降低，所以并不需要特意把原来使用malloc/free的代码都改为使用NSAllocateCollectable。

1.5__strong修饰符的使用方法

1、修饰对象类型的变量
	声明对象类型的变量时，如果不加上__weak修饰符，都默认__strong类型
2、修饰指针类型的变量
	被__strong修饰的指针所指向的内存可以被垃圾回收回收，但要等到__strong类型的指针不再使用这块内存之后
3、用于修饰函数或方法返回的指针类型
	指针指向的内存属于垃圾回收的范畴，但如果被赋值给一个强引用类型的变量，就暂时不能被回收。

1.6NSGarbageCollector类

类NSGarbageCollector是用于对垃圾收集器进行设定的类，程序编译时可以指定垃圾回收的各种选项，这个类的接口被定义在Foundation/NSGarbageCollector.h中

+(id)defaultCollector
	返回现在有效的垃圾收集器的实例，如果垃圾收集无效，则返回nil
-(void)collectIfNeeded
	申请进行垃圾回收，虽然垃圾回收是根据内存使用量自动运行的，但通过这个方法也可以指定希望启动垃圾回收的地方，这个方法在被调用之后会判断当前的内存使用情况，如果觉得有需要进行垃圾回收就会启动垃圾收集器，典型的调用方式如下：
		[[NSGarbageCollector defultCollector] collectIfNeeded];
-(void)collectExhaustively
	申请进行垃圾回收，希望使用深度遍历以尽可能地释放更多的内存时使用，该方法在被调用之后会判断当前的内存使用情况，在需要时启动垃圾收集器
-(void)disableCollectorForPointer:(void) ptr
	参数ptr时真心一块内存或指向实例变量的指针，调用这个函数后，这个指针所指向的内存不会被回收，也就是说指针指向的对象会变成根合集中的对象，如果想让对象变为可以再次被回收的话，需要调用下面的函数
-(void)enableCollectorForPointer:(void) ptr
	能够让上面函数指定不允许被释放的内存或对象再次允许被释放
-(void)enable
-(void)disable
	diasble方法能够让垃圾收集器暂时停止内存回收，ensable方法则能让垃圾收集器恢复工作
	但enable和disable必须成对调用，即调用多少次disalbe，就必须调用多少次enable，这2个函数一般应用于防止多线程中同时运行垃圾回收
	当垃圾收集器重新开始工作时，垃圾收集器暂停内存回收期间的内存也会被回收掉
-(BOOL)isEnable
	用于判断垃圾回收器是否有效，有效时返回真

1.7实时API

Objc提供实时API来控制垃圾回收器的动作：

void objc_startCollectorThread(void);
	启动一个线程来专门运行垃圾收集器，Cocoa环境下的GUI程序通常不需要调用这个方法，该方法只在使用Foundation框架的程序中使用
void *objc_memmove_collectable(void *dst,const void *src,size_t size);
	赋值垃圾回收对象的内存时使用该函数代替memcpy和memmove。


    """},
  {'title' : '第六章（3）' , 'message' : """
1、内存管理方式的比较

1.1引用计数和垃圾回收

和手动内存管理相比，ARC和垃圾回收有哪些优点：
- [ ] 不需要再在意对象的所有权
- [ ] 可以删除程序中内存管理部分的大部分代码，使程序看起来更清爽
- [ ] 可以避免手动内存管理时的错误（内存泄漏等）
- [ ] 不需要在意引用计数内存管理中的一些特殊用法。例如访问方法的定义和临时对象的使用等
- [ ] 可以使多线程环境下的编程更简单。例如：不用担心不同的线程之间可能出现的所有权冲突

垃圾回收的缺点如下所示：
- [ ] 垃圾收集器运行时会影响程序的速度
- [ ] 需要不停地监视内存的使用，同引用计数的方式相比，程序的速度会变慢
- [ ] 会影响程序的效率。不经常使用的内存也会被垃圾收集器不时地访问，实际上有可能会占用更多的内存
- [ ] 需要使用一些技巧来让对象被回收或不被回收
- [ ] 无法使用引用计数管理方式下的一些设计方针。例如：事先准备好一些管理文件或其他资源类的对象，在对象被释放的同时关闭资源

相较而言，ARC没有垃圾回收这么多缺点，但也有一些地方需要注意：
- [ ] 循环引用一旦形成就不会自己消失
- [ ] 未来防止循环引用的形成，需要之一对象间的关系，GUI的各个类之间也有可能形成循环引用，也要注意防止循环引用的形成
- [ ] 理论上可被赋值的对象都可以被自动释放，但在处理结构体、数组、二重指针等类型的变量时有一些限制
- [ ] 需要注意Core Foundation 的对象和ObjectiveC的对象之间的切换（详情见参考附录B）

1.2更改内存管理方式

采用不同的内存管理方式来编写程序的情况下，因为对象的保持和释放方式不同，程序的整体风格和思考方法也不尽相同。例如，即使是一个简单的赋值语句，它在手动内存管理、ARC、垃圾回收中也各不相同，因此这条语句前前后后的操作也都不会相同。
如果不得不手动迁移的话，就一定要注意以下几个方面：
- [ ] 与对象的所有权和生存期相关的处理
- [ ] 释放对象之后的善后处理
- [ ] 防止野指针的生成
- [ ] 有时还需要从对象之间的互相关系来重新考虑

1.3各种内存管理方式的比较

下面让我们用一个简单的程序来测试一下手动内存管理（MRC）、ARC和垃圾回收时程序的执行速度。
下面代码清单中的测试程序循环进行了对象的随机生成和释放。测试的方法是采用一个具体16个元素的数组，数组中的每个元素都是一个链表的头节点，每次生成两个随机数，第一个随机数被用于指明往数组的哪个元素中添加数据，第二个随机数则起到了标识位的作用。如果生成的第二个随机数是16的倍数，则将释放整个链表
三种不同的内存管理方式的代码一些不同，代码中对这些不同的哪放加上了注释。阴影部分是手动引用计数内存管理方式的代码。


用于测试垃圾回收速度的程序
speed.m

#import <Foundation/Foundation.h>
#import <stdio.h>
#import <stdlib.h>

#define MASS 2000 //MASS的值可调整
#define ARRAYSIZE (1<<6) //数组的大小
#define ARRAYMASK (ARRAYSIZE -1) //用于生成下标的掩码
#define LOOP 1500 //确定重复次数
#define ACCIDENT 0x0F //1/16的释放概率

id buf[ARRAYSIZE]; //全部初始化为nil

@interface Cell :NSObject{
    id next;    //指向下一个链表元素
    char mass[MASS];    //确保实例占有一定的空间
}

+(Cell *)cellWithNext:(id)obj;

@end

@implementation Cell

-(id)initWithNext:(id)obj{
    self =[super init];
    next =[obj retain]; //手动管理内存需要retain
    return self;
}

+(Cell *)cellWithNext:(id)obj{
    return [[[self alloc] initWithNext:obj] autorelease];
    //手动内存管理需要autorelease之后再返回
}

-(void)dealloc{//只在手动内存管理时调用
    [next release];
    [super dealloc];
}

@end

int main(void){
    int i,j;
    
    srandom(12345); //随机数的种子固定
    for(i=0;i<LOOP;i++){
        @autoreleasepool{ //GC不需要自动释放池
            for(j=0;j<LOOP;j++){
                int idx=random() &ARRAYMASK;
                if(buf[idx] !=nil && (random() & ACCIDENT) == 0){
                    //满足条件时释放对象
                    [buf[idx] release];//只在手动内存管理时调用
                    buf[idx] =nil;
                }else{
                    //通常会从数组生成链表
                    id t=buf[idx];
                    buf[idx] =[[Cell cellWithNext:t] retain];//手动内存管理时需要
                    [t release];
                }
            }
        }//GC在这里促进垃圾回收的执行
    }
    return 0;
}

￼

    """},
  {'title' : '第七章（1）' , 'message' : """
1、属性是什么

1.1使用属性编程

一般来说，属性 指的是一个对象的属性或特性
编写一个由多个对象组成的程序时，除了要给对象发送消息使其完成某个操作外，还需要查询或更新对象的状态和属性。对象的实例变量，也就是访问方法的目标一般被称为属性。例如，如果把游戏中的一个人物看作是一个对象的话，他的属性就包括名称、体力、经验、装备等。
本章中要说明的属性声明是一种声明变量为属性的语法，该语法同时还引入了一种更简单的访问属性的方法。
本章要介绍的属性声明指的就是，在接口文件中声明实例对象到底有哪些属性

随着属性声明的引入，ObjectiveC的编程风格也有了很大的变化。
这里将属性声明的一些规则总结如下：

1、自动生成访问方法：
	能够为指定的实例变量自动生成访问方法。既可以同时生成getter和setter方法，也可以只生成getter方法，除了自动生成外，也可以手动定义访问方法
2、自动生成实例变量
	如果不存在同名的实例变量的话，在生成访问方法的同时，也会自动生成同名的实例变量
3、更简单地调用访问方法
	可以通过点操作符（.）来调用访问方法，无论是赋值用的setter方法还是返回值用的getter方法，都可以通过点操作符调用，而且点操作符也不仅限于通过属性声明生成的访问方法，只要定义了访问方法（包括手动定义）就都可以使用点操作符来调用
4、属性的内省：
	通过内省可以动态查询类中声明的属性以及属性的名称和类型。

本章将首先对属性声明进行说明，然后说明使用点操作符调用访问方法的语法。

1.2属性的概念
	属性这个词，在不同的语句中有不同的含义。
ObjectiveC 2.0中引入属性声明和使用点操作符来调用访问方法的手法。使用属性声明可以更简洁地实现访问方法，另一方面，不仅仅是访问方法，KVC中所有定义的实例变量都可以被当作属性处理，相比较而言，KVC的属性是一种更广泛的概念
￼

    """},
  {'title' : '第七章（2）' , 'message' : """
1、属性的声明和功能

1.1显示声明属性

ObjectiveC 2.0新增加了属性声明的功能，这个功能可以让编译器自动生成于数据成员同名的方法，从而就可以省去自己定义读写访问方法的工作

下面的代码是类Creature的定义。NSString是表示字符串的类，这里为实例变量name定义了getter方法，为hitPoint定义了getter和setter方法，但没为magicPoint定义任何访问方法。另外，虽然没用level这个实例变量，但有同一个getter方法定义相同level方法。

带有访问方法的简单类的例子
Creature.h
#import <Foundation/Foundation.h>

@interface Creature :NSObject{
    NSString *name;
    int hitPoint;
    int magicPoint;
}
-(id) initWithName:(NSString *)str; //1
-(NSString *)name; //2
-(int)hitPoint; //3
-(void)setHitPoint; //4
-(int)level; //5

@end

在这个类中，我们首先给int类型的hitPoint定义了读写访问方法。而使用属性声明的话，只需要下面这一行，就可以为hitPoint生成读写方法，这里的@property是编译器指令，后面紧跟属性的类型信息和名称。
@property int hitPoint

属性声明等同于声明了读写两个访问方法，也就是代码中的 2，3两行
属性声明的时候还可以为属性自定义选项。选项位于圆括号中，签名是@property指令。例如，如果想声明一个只读的访问方法，可以在@property后面加上（readonly）下面就是给NSString类型的name声明一个只读的访问方法。
@property（readonly） NSString *name；

@property和是否声明了实例变量无关，4 的level方法也可以用@property的方法来实现。用@property关键字重写代码清单的接口部分。在这个例子中，我们把所有@property的语句都方法了后面，实际上@property也可以和方法声明混在一起

使用@property定义的接口文件

#import <Foundation/Foundation.h>

@interface Creature :NSObject{
    NSString *name;
    int hitPoint;
    int magicPoint;
}
-(id) initWithName:(NSString *)str; //1
@property(readonly) NSString *name;
@property int hitPoint;
@property(readonly) int level;

@end

magicpoint 和 hitPoint 的类型一样，都是int类型。为magicPoint声明读写方法，既可以单独写一行，也可以和hitPoint写在一起

@property int hitPoint ， magicPoint；

1.2属性的实现

下面的代码是对上面代码的接口部分所对应的实现。可以看到这里为每个属性分别实现了访问方法，本例中的实现都是以ARC管理内存为前提的

带有访问例子的类的实现例子
Creature.m

#import "Creature.h"

@implementation Creature  //使用ARC
-(id)initWithName:(NSString *)str{
    if((self =[super init]) !=nil){
        name =str;
        hitPoint =magicPoint =10;  //固定值
    }
    return self;
}
-(NSString *)name{
    return name;
}
-(int)hitPoint{
    return hitPoint;
}
-(void)setHitPoint:(int)val{
    hitPoint =val;
}
-(int)level{
    return (hitPoint +magicPoint) /10;
}

@end

代码Creature.m中是Creature.h的接口文件对应实现

除了上述这种写法外，还有一种更简单的写法，通过使用@synthesize，就可以在一行之内自动生成
getter和setter方法
@synthesize hitPoint；

上面这行语句会自动生成属性hitPoint的getter方法hitPoint和setter方法setHitPoint @synthesize是一种编译器功能，会让编译器为类的实例变量自动生成访问方法。
同样，通过一行语句也能为只读变量name生成getter方法。
@synthesize name；

修改后如下
#import "Creature.h"

@implementation Creature  //使用ARC
-(id)initWithName:(NSString *)str{
    if((self =[super init]) !=nil){
        name =str;
        hitPoint =magicPoint =10;  //固定值
    }
    return self;
}
@synthesize name;
@synthesize hitPoint;
@dynamic level;
-(int)level{
    return (hitPoint +magicPoint)/10;
}

@end

1.3 @synthesize和实例变量

使用@synthesize的时候，可以在一行中声明多个变量
@sunthesize hitPoint，magicPoint；

通常情况下，@property声明的属性名称和实例变量的名称是相同的，但有时你也可能会需要属性的名称和实例变量的名称不同，这时就可以为实例变量定义其他名称的属性，例如，我们可以通过下面的语句生成名为value的访问方法，并将其绑定到实例变量runningAverage中
@synthesize value =runningAverage；

没声明实例变量的接口部分的例子

@interface Creature :NSObject
-(id) initWithName:(NSString *)str;
@property(readonly) NSString *name;
@property int hitPoint;
@property(readonly) int level;
@end

声明了实例变量的实现部分的例子

@implementation Creature{
    NSString *name;
    int hitPoint;
    int magicePoint;
}
-(id)initWithName:(NSString *)str{
    //省略
}
...

@end

    """},
  {'title' : '第七章（3）' , 'message' : """
1.4通过@synthesize生成实例变量

属性声明的变量在接口文件和实现文件中都没有声明的情况下，通过使用@synthesize，就可以在类的实例文件中自动生成同名同类型的实例变量

接口文件中声明属性的例子 
#import <Foundation/Foundation.h>

@interface Creature :NSObject
-(id) initWithName:(NSString *)str;
@property(readonly) NSString *name;
@property int hitPoint,magicePoint;
@property(readonly) int level;
@property int speed;
@property int skill;

@end

没有显式声明实例变量的例子

@implementation Creature  //使用ARC
{
    NSString *name;
    int hitPoint;
    int magicPoint;
}
@synthesize name;
@synthesize hitPoint,magicPoint;
@synthesize speed;
@synthesize skill=ability;

-(id)initWithName:(NSString *)str{
    if((self =[super init])!=nil){
        name = str;
        hitPoint =magicPoint=10;
        speed =ability =5;
    }
    return self;
}

@dynamic level;
-(int)level{
    return (hitPoint +magicPoint +self.skill)/10;
}
@end

新追加的属性speed和skill在接口文件和实现文件中都没有声明，但对其使用@synthesize之后，就会自动生成这两个实例变量。因为实例变量会被生成在类的实现文件中，所以无论是类的外部还是从子类中都无法访问这2个实例变量

初始化方法中使用了变量speed和ability，并对其进行了赋值操作，这2个变量的有效区间从@synthesize的声明之后开始
level方法中有self.skill这样的写法，这是点操作符的写法

通过属性声明的方法也能够同访问方法一样实现封装的目的

1.5给属性指定选项

在前文中我们提到过用2property声明的时候可以给属性指定readonly选项。而除了readonly之外，还有其他一些选项。

￼
￼


也可以不使用默认的访问方法名，而通过setter option来指定访问属性用的方法名，例如，我们可以通过下面这行语句来指定实例变量hitPoint的setter方法为setValue 注意不要忘写最后的：

@property(stter =setValue:) int hirPoint;

1.6赋值时的选项

我们可以为可读写的@property设置选项，选项共有6种：assign  retain unsafe_unretained strong  weak  copy 选项之间都是排他关系，可以不设置任何选项或只设置6种中的一种，根据所修饰的属性是否是对象类型或者所采用的内存管理方式的不同选项的意义也会发送变化

￼

1、@property的属性不是对象类型
	不是对象类型的属性只可以单纯赋值，因此不需要指定任何选项，或者也可以指定assign选项，通过使用@synthesize，能够生成 7-3 （a、b）getter和setter方法

2、@property的属性是对象类型，且手动管理内存
	不指定任何选项的情况下，编译的时候会提示警告，指定了assign选项的情况下，通过@synthesize生成7-3（a、b） getter和setter方法
	指定了reatin选项的情况下，会生成 7-3（c）中的setter方法，在赋值的时候应该对该对象进行保持操作
	指定了copy选项的情况下，会生成7-3（d）中的setter方法，并使用对象的一个副本来进行赋值，也就是说，不使用输入的对象对属性进行赋值而是生成对象的一个副本，使用这个副本对属性赋值。这种赋值方式只适用于对象类型，并且要求该对象遵循NSCopying协议，且能够使用copy方法

3、属性是对象类型，且使用ARC管理内存
	不指定任何选项的情况下，编译的时候会提示警告
	指定了assign或者unsafe_unretained选项的情况下，只进行单纯的赋值，不进行保持操作。声明属性对象的实例变量时需要加上 __unsafe_unretained修饰符，因为没有被保持，所以实例变量指向的内容有可能会被释放掉而变成野指针，在使用的时候需要小心
	指定了strong或者retain选项的情况下，赋值操作之后还会对传入的变量进行保持操作，这同7-3（c）中的setter方法动作一样，实例变量在声明时需要不加任何修饰符或使用__strong修饰符
	指定了weak选项的情况下，会生成相当于弱引用赋值的代码。实例变量在声明时需要加上__weak修饰符
	指定了copy选项的情况下，会使用copy方法，建立传入值的一份副本，并用这份副本给实例变量进行赋值。

4、属性时对象类型，且使用垃圾回收管理内存
	这种情况下，如果不指定任何选项或指定了assign选项，@synthesize会生成 7-3（a、b）中的setter和getter方法。但是有一点要注意的是，对于符合NSCopying协议也就是说可以利用copy方法的类实例变量，如果不指定任何选项的话，就会提示警告。
	选项retain和weak没有意义，就算指定了也会被忽略，并执行和assign同样的动作。
	对弱引用类型的实例变量进行属性设定的语句如下所示@property需要使用assign选项，实例变量需要使用__weak选项修饰

@property(assign) __weak NSString *nickname；

	weak选项是ARC专用的，在垃圾回收的情况下是无效的
	指定copy选项后，会生成7-3 （d）中的setter方法

￼

1.7原子性

Nonatomic表示访问方法是非原子的。原子性是多线程中的一个概念，如果说访问方法是原子的，那就意味着多线程环境下访问属性是安全的，在执行的过程中不可被打断。而nonatomic则正好是相反，访问方法被nonatomic修饰的情况下，就意味着访问方法在执行的时候可被打断，缺省情况下访问方法都是原子的。

1.8属性声明和继承

子类中可以使用父类中定义的属性，也可以重写父类中定义的访问方法。但是父类中属性声明时指定的各种属性（assign reatin）等，或者为实例变量指定的setter和getter的名称必须完全一样
唯一一个特别的情况是，对于父类中被定义为readonly类型的属性，子类中可以将其变为readwrite，虽然不可以在子类中使用2synthesize对父类中的实例变量生成访问方法，但可以手动实现对呀的访问方法，这时未来防止子类可以轻易的访问父类中隐藏的实例变量

1.9方法族和属性的关系

使用ARC的时候，必须注意方法的命名，不要和方法族发生冲突
属性声明的时候会默认生成和属性同名的getter访问方法。需要注意属性名是否和方法族名冲突，特别要注意new开头的属性名的情况

3、通过点操作符访问属性

3.1点操作符的使用方法

上一节代码中 定义了类Creature
下面代码中以@开头的@Nike时字符串常量的表示方式。类NSString的UTF8String方法可把NSString转为C语言的字符串类型

使用点操作符的例子：

int main(void){
    Creature *a =[[Creature alloc] initWithName:@"Nike"];
    a.hitPoint =50;
    printf("%s : HP =%d (LV = %d)\n",[a.name UTF8String],a.hitPoint,a.level);
    return 0;
}

请注意一下这里的变量a，他像访问结构体中的元素那样使用了点操作符来获取修改类的属性。

Objecitve 2.0 会在编译时把使用点操作符访问属性的过程理解为访问方法的调用。因为调用的是访问方法，所以无论对应的实例变量是否存在，只要访问方法存在，就都可以通过点操作符访问属性

点操作符只能用于类类型的实例变量，不能对id类型的变量应用点操作符。

3.2复杂的点操作符的使用方法

1、连用点操作符
	点操作符可以连用：
	n=obj.productList.length;
	obj.contents.enable =YES;
	因为点操作符按照从左向右的顺序进行解释，所以上面的表达式可以被解释为
	n=[[obj productList] length];
	[[obj contents] setEnabled : YES];
	当一个对象的实例变量是另外一个对象时，可以通过连用点操作符来访问对象的实例变量中的成员。

2、连续赋值
	下面的连续赋值的表达式会被如何解释：
	n=0;
	k=obj.count=obj.depth =++n;
	赋值时是从右往左解释：
	k=(obj.count =(obj.depth =++n));
	 内侧括号中相当于执行了[obj setDepth : ++n] 表达式的值就是++n的值 1.外侧括弧中相当于执行了[obj setCount:1	]表达式的值也是1.最后变量n和k还有obj的两个属性的值都为1.
	点操作符和c语言中的宏定义不同，不会对n的值重复+1，如果obj是一个结构体的话，上面这段代码的执行结构和现在的结果则相同。

3、对递增、递减和复合赋值运算符的解释

	e=obj.depth++;

	赋值表达式的右侧连续调用了getter和setter方法，相当于执行了[obj setDepth:[obj depth]+1] 最后为e赋值的是递增操作之前的depth的值
	复合表达式也是一样，需要联系调用getter和setter方法，这种情况下obj.depth *=n; 就相当于 [obj setDepth:[obj depth]*n]； 而把obj换成结构体变量时，上面的这些表达式也会得出相同的结构。

4、self使用点操作符
	类的方法中可以通过对self应用点操作符来调用自己的访问方法，但要注意的是，不要再访问方法中使用self，否则会造成无限循环的递归，无法终止

	self.count=12;
	obj.depth=self.depth+1;

5、super使用点操作符
	可以通过给super加点操作符来调用父类中定于的setter和getter方法
	-(void)setDepth:(int)val{
	super.depth =(val <=maxDepth) ? val:maxDepth;
}
	
6、和结构体的成员混用
	获取类属性的点操作符和访问结构体元素的点操作符可以混用，但有一些需要注意的事项。
	例如，重设窗口大小的时候会用属性minSize来表示窗口的最小大小，这个属性就是一个结构体类型的变量（NSSize类型）其中存储了窗口的长和宽。当需要获取窗口的最小宽度时，可以按照如下方式书写代码：
	w =win.minSize.width;
	上面这行代码等价于下面这种写法，但需要注意的是，width前面的点操作符是访问结构体中的元素时使用的
	w=[win minSize].width;
	但不能使用这种专管的写法来为width赋值，例如下面这种赋值写法就是不允许的 setMinSize：只允许使用NSSie类型的结构体变量sz来对minSize进行赋值
	win.minSize.width=320.0 ; //不允许这种写法

	如果要为minSize的width赋值：
	NSSize sz=win.minSize;
	sz.width =320.0;
	win.minSize=sz;
    """},
  {'title' : '第八章（1）' , 'message' : """
1、类NSObject

1.1根类的作用

ObjectiveC 不仅需要编译环境，同时还需要一个运行时系统 来执行编译好的代码。
运行时系统扮演的角色类似于ObectiveC的操作系统，他负责完成对象生成、释放时的内存管理、为发来的消息查找对应的处理方法等

1.2类和实例

NSObject只有一个实例变量，就是Class类型的变量isa，isa用于标识实例对象属于哪个类对象。因为isa决定着实例变量和类的关系，非常重要。所以子类不可修改isa的值。另外也不能通过直接访问isa来查询实例变量到底属于哪个类，而要通过实例方法class来完成查询

下面对类和实例变量的相关方法进行说明：

-(Class) class
	返回消息接收者所属类的类对象
+(Class)class
	返回类对象
	虽然可以用类名作为消息的接收者来调用类方法，但当类对象是其他消息的参数，或者将类对象赋值给变量的时候，需要通过这个类方法来获取类对象
-(id)self
	返回接收者自身。是一个无任何实际动作但很有用的方法
-(BOOL)isMemberOfClass:(Class)aClass
	判断消息接收者是不是aClass类的对象
-(BOOL)isKindOfClass:(Class)aClass
	判断消息接收者是否是参数aClass类或者aClass类的子类的实例。这个函数和isMemberOfClass：的区别在于当消息的接收者是aClass的子类的实例时也会返回YES
+(BOOL)isSubclassOfClass:(Class)aClass
	判断消息接收者是不是参数aClass的子类或自身，如果是则返回YES
-(Class)superclass
	返回消息接收者所在类的父类的类对象
+(Class)superclass
	返回消息接受类的父类的类对象


1.3实例对象的生成和释放

+(id)alloc
	生成消息接收类的实例对象。通常和init或init开头的方法连用，生成实例对象的同时需要对其进行初始化，子类中不允许重写alloc方法
-(void)dealloc
	释放实例对象，dealloc被作为release的结果调用，除了在子类中重写dealloc的情况之外，程序中不允许直接调用dealloc
-(oneway void)release
	将消息接收者的引用计数减1.引用计数变为0时，dealloc方法被调用，消息接收者被释放，关于oneway关键字，请参考19章
-(id)retain
	为消息的接收者的引用计数加1，同时返回消息接收者
-(id)autorelease
	把消息的接收者加入到自动释放池中，同时返回消息接收者
-(NSUInteger)retainCount
	返回消息接收者的引用计数，可在调用时使用这个方法，NSUInteger是无符号整数类型
-(void)finalize
	垃圾收集器在释放接收者对象之前会执行该finalize方法

上面从dealloc到retainCount都是手动引用计数管理内存时使用的方法，使用ARC时不可用，fianlize仅供垃圾回收有效时使用

1.4初始化
-(id)init
	init可对alloc生成的实例对象进行初始化，子类中可以重写init或者动员新的以init开头的初始化函数
+(void)initialize
	被用于类的初始化，也就是对类中共同使用的变量进行初始化设定，这个方法会在类收到第一个消息之前被自动执行，不允许手动调用
+(id)new
	new是alloc和init的组合。new方法返回的实例对象的所有者就是调用new方法的对象，但是把alloc和init组合定义为new并没有什么优点
	根据类的实现不要，new方法并不会每次都返回一个全新的实例对象，有时new方法会返回对象池中预先生成的对象，也有可能每次都返回同一个对象

1.5对象的比较

-(BOOL)isEqual:(id)anObject
	消息的接收者如果和参数anObject相等就返回YES
-(NSUInteger)hash	
	在把对象放入容器等的时候，返回系统内部用的散列值

原则上来讲，具有相同id值也就是同一个指针指向的对象会被认为是相等的，而子类在这个基础上就进行了扩展，吧拥有相同值认为是相等。我们可以根据需求对相同值进行定义，但一般都会让具备相同值的对象返回相同的散列值，为此就需要对散列方法进行重新定义，而繁殖则不成立，也就是说，散列值相等的两个对象不一定相等
另外，有的类中还自定义了compare： 或者isEqualTo执行的方法，至于到底利用哪个方法，或自定义类的时候是否需要定义比较用的方法，都根据目的和类的内容做具体分析。

1.6对象的内容描述

+(NSString *)description
	返回一个NSString类型的字符串，表示消息接收者所属类的内容，通常是这个类的类名
-(NSString *)description
	返回一个NSString类型的字符串，表述消息接收者的实例对象的内容，通常是类名加id值，子类中也可以重新定义descripiton的返回值

    """},
  {'title' : '第八章（2）' , 'message' : """
1、消息发送机制

1.1选择器和SEL类型

程序中的方法名（选择器）在编译后会被一个内部标识符所代替，这个内部标识符所对应的数据类型就是SEL类型

ObjectiveC 为了能够在程序中操作编译后的选择器，定义了@selector（）指令。通过使用@selector（）指令，就能够直接引用编译后的选择器，使用方法如下：

@selector(mutableCopy)
@selector(compare:)
@selector(replaceObjectAtIndex:withObject:)

也可以声明SEL类型的变量
选择器不同的情况下，编译转换后生成的SEL类型的值也一定不同，相同选择器所对应的SEL类型的值一定相同。ObjectiveC的程序员不需要知道选择器对应的SEL类型的值到底是多少，具体的值和处理器相关。但是，如果SEL类型的变量无效的话，可设其为NULL，或者也可以使用（SEL）0这种常见的表达方法。
可以使用SEL类型的变量来发送消息，为此，NSObject中准备了如下方法：

-(id)performSelector:(SEL)aSelector
	向消息的接收者发送aSelector代表的消息，返回这个消息执行的结果
-(id)performSelector:(SEL)aSelector withObject:(id)anObject
	向消息的接收者发送aSelector代表的消息，消息的参数为anObject，返回这个消息执行的结果

例如，下面两个消息表达式进行的处理是相同的：

[target description];
[target performSelector:@selector(description)];

下面这个例子展示了如何根据条件动态决定执行哪个方法：

SEL method = (cond1) ? @selector(activate:) : @selector(hide:);
id obj =(cond2) ? myDocument : defaultDocument;
[target performSelector:method withObject : obj];

这种调用方法的方式很像C语言中函数指针的用法，使用函数指针也可以实现和上面的程序相同的功能。
函数指针是函数在内存中的地址。指针对应的函数是在编译的时候决定的，不能够执行指定之外的函数。SEL类型就相当于方法名，根据消息接收者的不同，来动态执行不同的方法。
通过SEL类型来指定要执行的方法，这就是ObjectiveC消息发送的方式，也正是通过这种方法才实现Objective的动态性。

1.2消息搜索

NSObject中定义了可以动态查询一个对象是否能够响应某个选择器的方法

-(BOOL)respondsToSelector:(SEL)aSelect
	查询消息的接收者中是否有能够响应aSelector的方法，包括从父类继承来的方法。如果存在的话返回YES
+(BOOL)instancesRespondToSelector:(SEL) aSelector
	查询消息的接收者所属的类中是否有能够响应aSelector的实例方法，包括从父类继承来的方法，如果存在的话，返回YES

1.3以函数形式来调用方法

类中定义的方法通常是以函数的形式实现的，但通常在编程的时候并不会直接操作方法所对应的函数。
通过使用下面的方法，可以获得某个对象持有的方法和函数指针，这些方法都被定义在NSobject中。
-(IMP) methodForSelector:(SEL) aSelector
	搜索和指定选择器相对应的方法，并返回指向该方法实现的函数指针。实例对象和类对象都可以使用这个方法。对实例对象使用时，会返回实例方法对应的函数，对类对象使用时，会返回类对象对应的函数
+(IMP)instanceMethodForSelector:(SEL)aSelector
	搜索和指定选择器对应的实例方法，并返回指向该实例方法实现的函数指针

IMP是“implementation”的缩写，他是一个函数指针，指向了方法实现代码的入口

typedef id (*IMP)(id,SEL,…);
	 这个被指向的函数包括id、调用的SEL，以及其他一些函数
-(id)setBox:(id)obj1 title:(id)obj2；
	foo是这个方法所属类的一个实例变量，获取指向setBox的函数指针，并通过该指针进行函数调用的过程如下所示。

IMP funcp;
funcp =[foo methodForSelector:@selecotr(setBox:title)];
xyz=(*funcp)(foo,@selector(setBox:title:),param1,param2);

通过这个例子可以看出，调用方法对应的函数时，除了方法声明时的参数外们还需要把消息接受对象的消息的选择器作为参数。虽然没有明确声明，但方法内部也可以访问这2个参数，因此这2个参数也被叫做隐含参数，第一个参数消息的接收者实际上就是self，第二个参数选择器可以通过_cmd	这个变量来访问。

因为没有明确知道IMP的方法参数的类型，所以编译的时候可以把1个实际的函数指针赋值给IMp类型的变量（需要通过cast进行类型转换）。

1.4对self进行赋值

上文中我们提到了self时方法的一个隐含参数，它代表的是收到消息的对象自身，因此，通过self可以给自己再次发送消息，self也可以作为消息的参数或方法的返回值来使用

此外还可以对self进行赋值操作，初始化方法的定义中，用父类初始化的返回值对self进行赋值，如下所示：

-(id)initWithMax:(int)a{//推荐使用这种写法
	if((self =[super init]) == nil){
		max=a;  //从这里开始对子类进行初始化操作
	}
	return self;
}

在OPENSTEP时代，ObjectiveC的初始化方法一般都采用下面这种写法，这种写法的前提是父类的初始化方法不会出错，但这里需要注意的是没有用父类初始化方法的返回值对self进行赋值。子类的初始化方法和父类的初始化方法都是对同一个对象进行操作的，所以不需要显式的对self进行赋值操作
-(id)initWithMax:(int)a {//旧的写法
	[super init];
	max=a;
	return self;
}

需要注意的是这种写法也可能出错，除了初始化失败之外，父类的初始化方法也有可能并没有返回self而是返回了其他对象，一个典型的例子就是，由 类族构成的类在初始化方法中就没有放回self。
 所以在定义初始化方法时，用父类初始化方法的返回值对self进行赋值并判断其不为nil是一种更安全的做法，另外在使用ARC的时候，如果初始化方法的返回值没被用到，编译时就会发生错误。

而如果用一个对象给self赋值的话 会发生什么呢：self代表消息的接收者，如果用一个对象给self赋值那么这个对象就会变成消息的接收者继续运行下去。除了在初始化方法之外，对self赋值都是一种非常有技巧性的操作，会让程序变得不好理解，因此不推荐使用，而使用ARC的时候，如果在初始化方法以外对self赋值，就会出现编译错误。

1.5发送消息的速度

首先来看看下面这个简单的程序，在这个程序中，我们会不断给一个对象发送相同的消息。程序中的LOOP时宏定义

测试程序（1）：消息送信

#import <Foundation/NSObject.h>
#import <stdio.h>

unsigned long rnd = 201109;

@interface testObj : NSObject
-(int) testMethod;

@end

@implementation testObj
-(int)testMethod{
    rnd =rnd * 110351524UL +12345;//计算随机数
    return (rnd &1) ? 1:-1;
}
@end

int main(void){
    id obj =[[testObj alloc]init];
    int v=[obj testMethod];
    for(int i =0;i<LOOP;i++){  //LOOP是宏定义
        for (int j=0;j<20000;j++){
            v+=[obj testMethod];
        }
    }
    return (v ==0);
}

这里我们修改了mian()函数，并生成了程序（2）-（4），程序（2）中使用了performSelector：来进行消息送信，程序（3）中没有使用消息调用的方法，而是在程序最开始获取了方法对应的函数指针，用函数调用的形式来调用方法，程序（4）中没有调用方法或函数，而是把方法中的操作直接在程序中展开了

程序（2）：使用performSelector:

int main(void){
    id obj =[[testObj alloc]init];
    int v=[obj testMethod];
    for(int i =0;i<20000;i++){
        for (int j=0;j<20000;j++){
            v+=(int)[obj performSelector:@selector(testMethod)];
        }
    }
    return (v ==0);
}

程序（3）函数调用的形式

int main(void){
    int (*f)(id ,SEL);
    id obj =[[testObj alloc]init];
    int v=[obj testMethod];
    f = (int (*)(id,SEL))[obj methodForSelector:@selector(testMethod)];
    for(int i =0;i<20000;i++){
        for (int j=0;j<20000;j++){
            v+=(*f)(obj,@selector(testMethod));
        }
    }
    return (v ==0);
}

程序（4）不使用方法或函数调用 直接展开

int main(void){
    id obj =[[testObj alloc]init];
    int v=[obj testMethod];
    for(int i =0;i<20000;i++){
        for (int j=0;j<20000;j++){
            rnd =rnd *1103515245UL +12345;
            v+=(rnd &1)?1 :-1;
        }
    }
    return (v ==0);
}

程序（1）-（3）的执行时间减去程序（4）的执行时间（A），就可以得到消息送信或函数调用所花费的时间。

从这个实验可以看出，消息送信所需要的时间是函数调用所需时间的2倍
还有一点需要注意，我们从上面的测试结果中不能得出 ObjectiveC的程序比C语言的程序慢2倍这种结论。

1.6类对象和根类

因为类对象也是一个对象，所以类对象可以作为根类NSObject的某个子类的对象来使用。下面这个语句看上去好像比较奇怪，但实际上他是正确的，会返回YES。

[[NSString class] isKindOfClass:[NSObject class]];

这就说明了相当于类的对象是存在的，而类对象的类就被叫做元类。实例对象所属的类是class，类对象所属的类是metaclass

类对象中保存的是实例方法，元类对象中保存的是类方法，通过这样的定义能够统一实现实例方法和类方法的调用机制。
因为编程时不可以直接操作元类，所以并不需要完全了解元类的概念，大家只需要记住任何一个类对象都是继承了根类的元类对象的一个实例即可，也就是说，类对象可以执行根类对象的实例方法。

例如 类对象可以执行NSObject的实例方法performSelector和respondsToSelector当然前提是没有将这些方法作为类方法再次定义
总结：
1、所有类的实例对象都可以执行根类的实例方法
	如果在派生类中重新定义了实例方法，新定义的方法也会被执行
2、所有类的类对象都可以执行根类的类方法
	如果在派生类中重新定了类方法，新定义的方法也会被执行
3、所有类的类对象都可以执行类的实例方法
	即使在派生类中重新定义了实例方法，根类中的方法也会被执行
	如果在派生类中将实例方法作为类方法重新定义了的话，新定义的方法会被执行


1.7Target-action paradigm

通过使用SEL类型的变量，能够在运行时动态决定执行哪个方法，实际上，APPlication框架就利用这种机制实现了GUI控件对象间的通信，例子：

@interface myCell :NSObject{
    SEL action;
    id target;
    ...
}
-(void)setAction:(SEL) aSelector;
-(void)setTarget:(id)anObject;
-(void)performClick:(id)sender;
...

@end

@implementation myCell
-(void)setAction:(SEL)aSelector{
    action =aSelector;
}
-(void)setTarget:(id)anObject{
    target =anObject;
}
-(void)performClick:(id)sender{
    (void)[target performSelector:action withObject:sender ];
}
...

@end

这个类有SEL类型的实例变量action和id类型的实例变量target，如果对这个类的实例变量发送消息performClick：，action表示的消息就会被发送给target对象，这时，消息的参数使用performClick：的参数
Application框架利用这种原理实现了GUI空间对象间的通信，叫做目标-动作模式

Appliction框架的目标-动作模式在发送消息时采用了下面这种形式定义的方法，即只有一个id类型的参数，没有返回值。这种形式的方法叫做动作方法

-(void)XXXX:(id)sender;

使用ARC进行开发的情况下，要注意避免形成对象间的引用循环，所以除了主要的对象之间的连接使用强引用之外，其余对象之间进行连接时都推荐使用弱引用，属性声明时，建议加上assign和weak选项

    """},
  {'title' : '第八章（3）' , 'message' : """
第八章（3）

1、ObjectiveC和Cocoa环境

1.1 cocoa环境和MacOSX

下图中展示了MacOSX应用环境的概念
我们经常提到的Cocoa环境通常是指AppKit和Foundation这2个核心框架，但有时候也包含Core Foundation或Core Data等框架
该文档中强调，对于下层来说，Cocoa并不是一个简单的面向对象的接口。Cocoa的前身OPENSTEP是跨平台的，能对应多种框架。而Cocoa是为了提供构建应用程序所必需的功能而实际的，所以才会利用下层的功能。
￼

1.2Cocoa Touch 和IOS

iPhone和iPad的操作系统ios使用Cocoa Touch作为GUI环境
由Foundation和UIkit框架组合而成的GUI环境称为Cocoa Touch

1.3框架

在MacOSX中，将开发和执行软件所必需的图形库、头文件和设定用的各种信息全部汇总在一起就构成了框架。值的一提的是，其中包括了应用程序执行时必须的动态连接库。
框架是应用程序的骨架的意思，框架提供了程序运行的基本功能和GUI基础，这些功能之上，通过添加独有的处理，就可以实现要实现的功能。

MacOSX 中最重要的框架是Foundation框架，Application框架（也称为AppKit框架或ApplicationKit框架）、Core Foundation框架和System框架。

Foundation框架提供了包括NSObject在内的ObjectiveC的基本类库。
Core Foundation框架是一组C语言接口，他们为ios应用程序提供了基本的数据管理和服务功能。
Application框架包含了与Cocoa的GUI的基础-窗口环境相关类
System框架包含了与Cocoa最底层的Mach核心和Unix相关的类库。
因为系统框架通常都和程序执行相关，所以编译程序的时候不需要指定-framework选项。

Cocoa框架，实际上他是由Foundation框架，Application框架和CoreData框架组成的。
像这样把多个框架嵌套打包的技术称为umbrella framework，不过该技术仅仅是苹果公司提供功能的一种方法，不建议普通开发者提供自己的unbrella Framework

1.4框架的构成和头文件

例如，Foundation框架和Application框架的存放路径分别为：

/System/Library/Framework/Foundation.framework
/System/Library/Framework/AppKit.framework

安装了iOS开发环境的MAC中，iOS框架在开发环境相关文件内部很深的地方。
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/IphoneOS5.1.sdk/System/Library/Framework

框架的每个目录中通常包含了以下元素：
1、类库 —框架同名文件
2、CodeResources—记载了文件散列值的XML文件
3、Headers—包含了头文件的目录
4、resources—包含了不同国家语言用的文件等各类资源的目录
5、Versions—包含了框架的各种版本的目录

2、全新的运行时系统

2.1对64位的对应和现在运行时系统

苹果公司的官方文档中把64位的MacOSX的运行时系统和IOS的运行时系统称为现代运行时系统，把32位MacOSX的运行时系统被叫做早期运行时系统

2.2数据模型

和很多UNIX系统一样，Mac os X使用ILP32和LP64作为编程的数据模型。
ILP32的含义是int类型、long类型和指针类型都是32位
LP64的含义是long类型和指针类型都是64位
16位电脑的数据模型是LP32
当前的win系统是LLP64

￼


2.3 64位模型和整数模型

数据类型发生了变化的话，主要受影响的是调用API时的参数和返回值的类型。
ILP32和LP64中的int类型都是32位，这种情况下，就算数据类型变更到了64位，也不能利用64位的优点
为了解决这个问题，Cocoa环境引入了NSInteger类型，NISInteger在32位的数据模型下被定义为int，在64位数据模型下被定义为long，除此之外Cocoa还定义了无符号的NSUInteger类型，Cocoa API中参数为int类型的函数或方法绝大多数都使用了NSinteger代替int
NSInteger和NSUInteger都在头文件NSObjURuntime.h中定义。宏__LP64__在64位编译时为真。宏TARGET_OS_IPHONE面向iOS真机编译时为真。宏TARGET_IPHONE_SIMULATOR表示面向模拟器编译

2.4 Core Graphics的浮点数类型

2.5 健壮实例变量

现代运行时系统的一个最显著的特征就是实例变量是健壮的
下图，编译源代码生成Volume.o MuteVolume.o main.o 链接这些.o 文件生成可执行文件A。可执行文件A可以正常执行。接着编译Volume.h改变其中的实例变量的顺序并增加新的实例变量。这里重新编译生成Volume.o并链接原有的MuteVolume.o和main.o生成可执行文件B

￼

类MuteVolume继承自类Volume MuteVolume.o 中理应保持着变更之前的实例变量。实际上，在32位数据模型下编译链接生成的可执行文件B，在早期的运行时系统中时无法正常执行的。而现在可以正常执行

如果框架中的类发生了变化，应用程序就一定要重新编译才能够早期的运行时系统中执行，这种问题称为脆弱的二进制接口。
现代运行时系统针对这个问题进行了改进，使实例变量发生变化的情况下，应用程序不重新编译也能够继续执行，这称为健壮的实例变量，但实例变量仅限于上图中所示的变量顺序的变化或增加了新的实例变量这种程度，删除了实例变量或改变了实例变量的类型时还是需要重新编译才能够正常运行的



    """},
  {'title' : '第九章（1）' , 'message' : """
1、对象的可变性

1.1 可变对象和不可变对象

ObjectiveC中的类分为可变类和不可变类。
可变类的实例对象称为可变对象，指的是创建后能够改变其内容的对象。
不可变类的实例对象称为不可变对象，指的是创建后不可更改其内容的对象。
对象是否可变的属性称为可变性
例如，字符串类就分不可变字符串类NSString和可变字符串类NSMutableString

￼

下面使用不可变类NSString编程的一个例子。假设tempDirectory方法会返回一个NSString的对象，是目标文件的目录。这里，我们将这个目录的filename文件的扩展名更改为bak

NSString *str=[self tempDirectory];
NSString *work = [filename lastPathComponent];//从完全路径中获取文件名
work = [work stringByDeletingPathExtension];//删除文件的扩展名
work=[work stringByAppendingPathExtension:@"bak"];//给文件加上扩展名bak
str=[str stringByAppendingPathComponent:work];//重新生成新的路径

上面这段程序中，有很多个地方用到了NSString对象，就好比数值计算的中间结果一样
下面让我们看一个可变对象NSMutableArray的例子。方法nextEntry从文件逐行读入，每读一行信息就生成一个类MyInfo的实例对象，到达文件末尾的时候返回nil，到底生成了多少个MyInfo对象同具体文件相关，这里把生成的所有实例对象都放入数组对象anArray中

MyInfo *entry;
NSMutableArray *anArray =[NSMutableArray array];//生成空的数组
while((entry =[self nextEntry]) != nil){
    [anArray addObject : entry];//数组对象的末尾追加entey
}

使用方法addObject后，并不能生成新的对象，而是原来的数组对象anArray中会被添加新的元素，NSMutableArray的实例对象anArray在初始时一个对象都没有，会随着对象的加入被自动扩展。

上面的例子也可以使用不可变数组NSArray来实现，但这种情况下，每当数组中的元素发生变化时，都需要新建一个数组对象并把元素重新复制进去，非常麻烦，通过这个例子可以看出，根据实际情况的不同来区分使用可变和不可变对象是十分重要的。

1.2可变对象的生成

上表中列举了常用的可变类和与其对于的不可变类，其中可变类时不可变类的子类，例如类NSMutableArray就是类NSArray的子类，所以可变类的实例对象可直接作为不可变类的实例对象来使用

与此相反，如果想把不可变类的实例对象作为可变类的实例对象来使用的话，该如何操作：
可以使用mutableCopy方法味不可变对象创建一个可变的副本。这个方法定义在NSobject中，只要是成对出现的可变类和不可变类的对象，就都可以使用这个方法。
-(id)mutableCopy

2、字符串类NSString

2.1常量字符串

ObjectiveC和C语言一样也在程序中提供了定义字符串对象的方法，即将想要表示的字符串用“”扩起来，并在开头加上@

NSString *myname=@“T.Ogihara”;
NSString *work =[@“Name :” stringByAppendString : myname];

使用这种方法定义的字符串是常量对象，可被作为NSString的对象使用。常量字符串不仅仅可作为消息的参数，还可作为消息的接收者。
@“” 表示一个长度为0的空字符串，但和nil有区别。另外 和ANSI C的字符串常量一样，编译器编译时会把空格分割的字符串连在一起，如下所示：

#define Manufacturer @“Phantom Cookie , Inc”
#define Year @“2005”
NSString *note =@“Copyright ” Year @ “” Manufacturer;


2.2NSString

本节说明的是Cocoa环境下的字符串类NSString 的概要
NSString代表不可变字符串对象，一旦NSString被创建，我们就不能改变它

（1、操作Unicode编码的字符串
	NSSting中的汉子都是用Unicode来表示的。Unicode的UTF8 编码兼容ASCII的7bit编码，字符串中只含有ASCII的7bit范围的编码的情况下，ASCII的字符串可被当作UTF8 的Unicode字符串来处理。ASCII的字符串不能被当作UTF16的字符串来处理，苹果电脑中的Finder使用UTF8来表示中文文件名
	下面提到的unichar是两字节长的char，代表unicode的一个字符，和char有所不同
	-(id)initWithUTF8String :(const char *)bytes
		从以NULL结束的UTF8编码的C字符串中复制信息，并初始化接收者
	-(__string const char *)UTF8String
		返回编码位UTF、以NULL结尾的C语言字符串的指针，基于引用计数的内存管理模式下，返回的字符串会在消息接收者对象被释放的同时被释放掉，如果想在对象被释放之后也能使用，就需要额外复制一份。垃圾回收的内存管理模式下，因为返回的指针是强指针，所以不会被垃圾回收
	-(NSUInteger) length
		返回字符串中Unicode编码的字符的个数，和C风格的字符串不同，不能用这个函数的返回值来计算需要的字节数和表示时需要的长度
	-(unichar)characterAtIndex:(NSUInteger)index
		返回索引位置位i处的字符。编码位Unicode编码
	-(id)initWithCharacters:(const unichar *)characters
			            length:(NSUInteger)length
			用characters中存储的length长的字符串来初始化并返回一个NSString对象，字符串的编码是Unicode编码。初始化时以length为准，characters中就算包含了“\0	”也不能作为终止标记
		便利构造器stringWithCharacters：length
	-(void)getCharacters:(unichar *)buffer
				 rangs:(NSRange)aRange
		NSRange是一个表示范围的结构体，其中包含数据的首指针和数据长度。这个函数的作为就是将aRange所表示的字符串作为unicode字符串作为Unicode字符串写入缓冲区buffer中，末尾不自动添加NULL，缓冲区需要足够大

（2、编码转换

C风格或字节类型的字符串和NSString之间可以互相转化。字符串编码定义为枚举类型NSStringEncoding保存在NSString的头文件中，其中最常用的几个类型如下：

NSASCIIStringEncoding 		7bit的ASCII编码
NSUTF8StringEncoding			8bit的Unicode编码
NSMacOSRomanStringEncoding	MacOS用的编码
NSJapaneseEUCStringEncoding	8bit的日文EUC编码
NSShiftJISStringEncoding		8bit的日文shift-JIS编码

-(id) initWithCString :(const char *) nullTerminatedCString
		  encoding:(NSStringEncoding)encoding
	用C风格字符串初始化一个NSString对象，字符串nullTerminatedCString要求以NULL结尾，nullTerminatedCString编码位encoding
	便利构造器：stringWithCString：encoding
-(__strong const char *)cStringUsingEncoding:(NSStringEncoding)encoding
	返回消息接收者的C风格字符串，编码由encoding指定。引用计数的内存管理模式下，返回的字符串会在消息接收对象被释放的时候同时被释放掉，如果想在对象被释放之后也能使用的话，就需要额外复制一份。垃圾回收的内存管理模式下，因为返回的指针是强指针，所以不会被回收
	如果字符串无法转换为指导编码，编码时会抛出异常
	使用方法getCString：maxLength：encoding：能够向准备好的内存空间写入C风格的字符串
-(id)initWithData:(NSData *)data
             encoding:(NSStringEncoding)encoding
	用存储在data中的二进制数据来初始化NSString对象，data中二进制数据的编码是encoding返回的NSString对象的编码是Unicode
	同样，通过方法initWithBytes：length：encoding：能够用指定内存中的二进制数据来初始化一个NSString对象。
-(NSData *)dataUsingEncoding:(NSStringEncoding) encoding
	将接收消息的NSString对象的内容用encoding指定的方式编码，并将结果存储到一个NSData对象中并返回，如果编码转换失败则nil
	使用方法lengthOfBytesUsingEncoding：能够返回NSString被编码之后所占的bytes数
-(BOOL) canBeConvertedToEncoding:(NSStringEncoding) encoding
	测试接收消息的NSString对象能否转换为encoding编码
	使用类方法availableStringEncodings能够返回当前环境下可用的编码方式。
-(NSString *)stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding
	能够对一些特殊符号进行替换，主要被用于处理URL字符串，比如将空格替换成%20等
	方法stringByReplacingPercentEscapesUsingEncoding：是上述方法的逆变换，这2个方法都定义在Foundation/NSURL.h中

（3、生成指定格式的字符串

NSString中有和C语言中printf() 一样功能的函数，能够生成指定格式的NSString对象，区别在于指定目标格式的格式化字符串本身也是一个NSString对象，指定格式时可以使用%@，所以要特别注意类型方面的处理

%@对应的参数必须是一个对象，当输出%@时（例如：NSLog（@“%@”，test））实际上就是调用了test的description方法，返回的结果存储到%@中。description方法时NSObject中定义的方法，任何对象都可以调用他，description返回的内容和类实现相关。
-(id)initWithFormat:(NSString *)format,…
	根据format中指定的格式串来生成一个字符串，使用这个字符串来初始化消息接收者。format中的参数用逗号分隔，格式字符串不能为空
	便利构造器：stringWithFormat：

和c语言与阳，ObjectiveC也支持可变参数的方法，在参数的末尾加上逗号，然后加上…即可

（4、NSString的比较

下面对用于比较NSString的方法进行说明
字符串比较时会返回一个NSComparisonResult类型的值。NSComparisonResult是enum型数据，共有三个值，分别为NSOrderedAscending（左侧小于右侧）、NSOrderedSame（两者相同）、NSOrderedDescending（右侧小于左侧）。这些方法还可以用在多个NSString变量排序

-(NSComparisonResult)compare:(NSString *)aString
	比较消息的接收者和参数字符串aString，参数aString不可以为nil。
	如果想比较两个字符串的内容是否相同，除了compare：外还可以使用下面将介绍的方法isEqualToString：。
-(NSComparisonResult)caseInsensitiveCompare
	compare：进行的是区分大小写的比较，caseInsensitiveCompare：进行的是不区分大小写的比较
	除了使用caseInsensitiveCompare：外也可以使用方法compare：options：来实现不区分大小写的比较，需要用或运算来为option参数添加选项标记，不区分大小写比较的选项为NSCaseInsensitiveSearch
-(NSComparisonResult)localizedStandardCompare:(NSString *)aString
	按照Mac系统finder的排序规则进行比较操作，通常对数组中的文件进行排序时，有可能希望文件的排序规则和finder的排序规则一致，这时便可以使用方法localizedStandardCompare：。
-(BOOL)isEqualToString:(NSString *)aString
	比较消息的接收者和参数aString是否相等。
-(BOOL)hasPrefix:(NSString *)aString
	检查字符串是否以astring开头。
	可以使用hasSuffix来判断消息接收者是否以参数字符串结尾
	另外还可以使用方法commonPrefixWithString：options：来取出消息接收者和参数字符串开头部分相同的字符串

（5、为字符串追加内容

-(NSString *)stringByAppendingString:(NSString *)aString
	在接收者字符串后面追加字符串aString，返回一个新的字符串
-(NSString *)stringByAppendingFormat:(NSString *)format,…
	在接收者字符串后面追加格式字符串，字符串的具体格式由format指定，然后返回一个新的字符串

（6、截取字符串
	
截取指定的字符串并返回，使用结构体NSRange来表示要截取的字符串的开始位置和长度
-(NSString *)substringToIndex:(NSUIteger)anIndex
	返回一个新的字符串，新字符串的范围时从接收者字符串的第一个字符开始到anIndex结束anIdex不包含在内
-(NSString *)substringFromIndex:(NSUInteger)anIndex
	返回一个新的字符串，新字符串的范围时从anIdex开始一直到结尾，anIdex位置的字符也包含在内
-(NSString *)substringWithRange:(NSRange)aRange
	返回一个新的字符串，新字符串的开始位置和长度由aRnage来指定

（7、检索和置换
-(NSRange) rangeOfString :(NSString *)aString 
	在接收者字符串中查找aString，如果能找到就将aString的位置和长度以NSrange的形式返回。如果没找到，则返回一个位置为NSNotFound、长度为0的NSrange类型的对象
	还有一个方法rangeOfString：option：，这个方法带有选项参数。例如通过指定选项NSCaseInsensitiveSearch，就可以进行不区分大小写的查找
-(NSRange)lineRangeForRange:(NSRange)aRange
	返回范围aRnage所在行的范围，这里的行用下表中的字符作为结尾标志的

￼

-(NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
	将range范围内的内容替换成字符串replacement
-(NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
	将字符串target替换为字符串replacement

除了以上几种查找方法外，检索时还可以使用正则表达式。

（8、大小写的处理

可以使用lowercaseString方法将字符串中所有的大写字母都转换为小写字母，与此相对，uppercaseString则被用于将所有的小写字母转换为大写字母
除了这2个方法外，方法capitalizedString能够将所有单词的首字母变为大写，其余字母变为小写

（9、数值转换

方法doubleValue可把NSString类型的字符串转为double类型的数据。
方法floatValue、intValue、integerValue、boolValue分别用来把NSString类型的字符串转为float、int、NSInteger和BOOL类型的数值。
以上这些函数都会忽略字符串前面的空格

（10、路径的处理

文件的路径可用NSString来表示，NSString中提供有常用的处理文件路径的方法，这些方法的接口都定义在“Foundation/NSPathUtilities.h”中

-(NSString *)lastPathComponent
	提取文件路径中最后一个组成部分。
-(NSString *)stringByAppendingPathComponent:(NSString *)aStr
	将aStr加到现有字符串的末尾并返回，根据需要会自动追加分隔符
-(NSString *)stringByDeletingLastPathComponent
	删除路径中最后一个组成部分，如果返回的结果根本不是路径，那么最后的路径分隔符也会被删除。文件路径@“/tmp/image/cat.tiff”的情况下，调用stringByDeletingLastPathComponent之后返回的结果是“/tmp/image”。
-(NSString *)pathExtension
	返回文件的扩展名，扩展名不包含“.” 如果没有扩展名则返回空字符串
-(NSString *)stringByAppendingPathExtension:(NSString *)aStr
	将“.”和指定的扩展名添加到现有路径的最后一个组成部分上
-(NSString *)stringByDeletingPathExtension
	删除文件的扩展名包括“.”如果文件没有扩展名，则返回原来的字符串
-(BOOl)isAbsolutePath
	判断路径是不是一个绝对路径，如果时则返回YES
+(NSString *)pathWithComponents:(NSArray *)components
	使用components中的元素来构建路径，结合的时候自动添加路径分隔符“/”想生成一个绝对路径的话，数组的第一个元素使用@“/”，路径的最后想以路径分隔符“/”结尾的话，数组的最后一个元素使用空字符串@“”。
-(NSArray *)pathComponents
	和pathWithComponents正好相反，把接收者作为路径名来解析，并将路径的哥哥组成部分放入数组中。输入的路径是绝对路径，数组的第一个元素是@“/”
-(NSString *)stringByExpandingTildeInPath
	消息的接收者被看作路径名，如果路径的第一个字符是代字符（以～开头的，例如～/或～john/）则返回用户主目录的路径字符串，如果不以代字符开头，则直接返回输入的字符串。stringByAbbreviatingWithTildeInPath和stringByExpandingTildeInPath的功能正好相反，会把标准的格式的字符串转换为使用代字符的字符串
-(__strong const char *)fileSystemRepresentation
	返回路径的C风格字符串，使用当前系统的编码，获得的C风格字符串可被用于系统调用等。基于引用计数的内存管理中，返回C语言的风格的字符串会和消息的接收者对象一起被释放。垃圾回收的内存管理方式下，如果返回值为强引用，则不会被垃圾收集器回收
	使用方法getFileSystemRepresentation：maxLength：可以将返回的C风格字符串写入事先准备好的内存中

（11、文件的输入和输出

可以从文件中读取字符串的内容，也可以将字符串的内容输出到文件中。另外 下面这些同文件相关的方法都带有一个error参数，并把发生错误时的错误信息都写入到error中，error不能为NULL，否则就不会返回任何错误信息

-(id)initWithContentsOfFile:(NSString *)path
                              encoding:(NSStringEncoding)enc
                                     error:(NSError **)error
	通过读取文件path中的内容来初始化一个NSString 文件的编码为enc，读取文件失败的时候会释放调用者，并在返回nil的同时将详细的错误信息设定到error
	便利构造器：stringWithContentsOfFile：encoding：error
-(id)initWithContentsOfFile:(NSString *)path
                      usedEncoding:(NSStringEncoding *)enc
                                     error:(NSError **)error
	和上一个方法一样，通过读取文件path中的内容来初始化一个NSString，不同的地方在于这个函数能够自动判断文件的编码，并通过enc返回，文件的编码时通过文件的内容和文件的扩展属性来判断的
	便利构造器：stringWithContentsOfFile：usedEncoding：error
-(BOOL)writeToFile:(NSString *)path
               atomically:(BOOL)useAuxiliaryFile
                 encoding:(NSStringEncoding)enc
                        error:(NSError **)error
	用于将字符串的内容写入到以path为路径的文件中，写入的时候使用enc指定的编码，写入成功则返回yes
	useAuxiliaryfile为YES的情况下，会首先新建一个临时文件，把字符串的内容写入到临时文件中。然后在写入成功后把临时文件重命名为path指定的文件，通过采用这种方法，就算有同名文件存在，写入发生错误时也不会损坏原来的文件。useAuxiliaryfile为NO的情况下，则直接输入字符串的内容到path指定的文件中，如果写入文件失败，则会返回NO的同时把出错的原因写入到error中，并返回给函数的调用者

（12、其他

-(id)init
	对接收者进行初始化，并返回一个空字符串。这个方法通常被用于NSMutableString 的初始化
	便利构造器：string
-(id)initWithString:(NSString *)aString
	返回一个字符串对象，其内容时aString的副本
	aString也可以是一个NSMutableString的实例对象，用这个方法可以用一个可变的字符串对象生成一个不可变的字符串对象
	便利构造器：stringWithString：
-(NSString *)description
	这个方法是在NSObject中定义的，会返回表示消息接收者内容的字符串
	NSString的description方法会直接返回self
-(id)propertyList
	返回消息接收者的属性列表。属性列表是一种格式，用来存储串行化后的对象，由NSString、NSData、NSArray和NSDictionary构成。属性列表文件的扩展名为.plist	 因此通常称为 plist文件。Plist文件通常被用于存储用户设置，也可以将其用于存储捆绑的信息
-(NSArray *)componentsSeparatedByCharactersInSet:(NSCharacterSet *)sep
	用参数sep指定的字符串集合中的字符作为分隔符，对消息的接收者字符串进行分割，并返回分隔后生成的字符串数组

2.3NSMutableString

本节将对可变字符串NSMutableString进行说明，NSMutableString是NSString的子类，所以NSMutableString可以使用NSString中定义的所有方法，和NSString一样，NSMutableString的接口也定义在文件Foundation/NSString.h中

（1、实例对象的额生成和初始化

-(id)initWithCapacity:(NSUInteger)capacity
	初始化一个NSMutableString类型的对象，capacity指明了要被初始化的NSMutableString对象的大小，NSMutableString的对象会随着字符串的变化而自动扩展内存，所以capacity不需要非常精密。除了这个方法之外，还可以使用NSString的init方法或NSString的类方法string：来生成一个空的NSMutableString对象
	便利构造器：stringWithCapacity

（2、追加字符串

-(void)appendString :(NSString *)aString
	在消息接收者的末尾追加aString
-(void)appendFormat:(NSString *)format,…
	在消息接收者的末尾追加format格式的格式化字符串

（3、插入、删除、置换

-(void)insertString:(NSString *)aString
		  atIndex:(NSUInteger)loc
	在消息接收者的atIndex位置插入字符串aString
-(void)deleteCharactersInRange:(NSRange)range
	结构体NSRange表示一个范围，其中包含了开始位置和长度
	这个方法的作用是从接收者中删除aRange指定范围的字符串
-(void)setString:(NSString *)aString
	复制aString指定的字符串，并将其设置为消息接收者的内容
-(void)replaceCharactersInRange:(NSRange)aRange
				      withString:(NSString *)aString
-(NSUInteger)replaceOccurrencesOfString:(NSString *)target
						     withString:(NSString *)replacement
							 options:(NSStringCompareOptions)opts
							    range:(NSRange)searchRange
	searchRange指定范围内如果存在字符串target，就将其替换为replacement这个函数的返回值就是替换的次数，使用选项opts可以设置忽略大小写，或者使用正则表达式进行替换。


    """},
  {'title' : '第九章（2）' , 'message' : """
3、NSData

3.1、NSData

NSData是Cocoa下对二进制数据的一个封装，能够把二进制数据当作对象来处理。
同C语言的数组相比，NSData的优点是可以进行更抽象化的操作，使内容管理更容易，同时也是CocoaAPI中操作二进制数据的标准。

（1、数据对象的生成和初始化

-(id)initWithBytes:(const void *)bytes
		  length:(NSUInteger) length
	复制以bytes开头，长度为length的数据，进行初始化使其称为数据对象的内容
	便利构造器：dataWithBytes：length：
-(id)initWithBytesNoCopy:(void *)bytes
			        length:(unsigned)length
		  freeWhenDone:(BOOL)flag
	将以bytes开头，长度为length的数据初始化为数据对象的内容，生成的NSData中保存的是指向数据的指针，并没有对数据进行复制操作。flag为YES的时候，生成的NSData对象是bytes的所有者，当NSData对象被释放的时候也会同时释放bytes，所以bytes必须是通过malloc在堆上分配的内存。当flag为NO时，bytes不会被自动释放，释放bytes时要注意时机，不要在nSData对象还被使用的时候释放bytes
	便利构造器：dataWithBytesNoCopy：length：freeWhenDone：
-(id)initWithData:(NSData *)aData
	用指定的NSData对象aData来创建一个新的NSData对象，参数可以是NSMutableData对象，所以用这个方法可以为一个可变NSMutableData对象生成一个不可变的NSData对象。
	便利构造器：dataWithData：
+(id)data
	返回一个长度为0的临时NSData对象，这个方法多被用于NSMutableData中，对其初始化方法为init

（2、访问NSData中的数据
下面的说明中用到的NSRange包括开始指针和数据的长度
-(NSUInteger)length
	返回NSData对象中数据的长度
-(const void *)bytes
	返回NSData对象中数据的首指针
-(void)getBytes:(void *)buffer
	        length:(NSUInteger)length
	复制NSData对象的数据到buffer中，复制时从NSData对象中数据的开头开始，副本长度为length，如果想获取指定范围内的数据的话，可以使用方法getBytes：range：
-(NSData *)subdataWithRange:(NSRange)range
	用range指定范围内的data来生成一个新的NSData对象并返回
-(NSRange)rangeOfData:(NSData *)dataToFind
			     options:(NSDataSearchOption)mask
			        range:(NSRange)searchRange
	在接收者中searchRange指定的范围内，如果能找到和dataToFind一样的数据，则返回数据的位置和长度，mask是搜索时用到的选项，使用mask可以从后向前查找，dataToFind不可以为nil。

（3、比较

-(BOOL)isEqualToData:(id)anObject
	两个NSData的数据长度和内容一致时返回YES

（4、文件输入和输出
可以从文件读入数据来初始化NSData对象，或者把NSData对象中的内容输出到文件
-(NSString *)description
	返回一个ASCII编码格式的字符串，采用的格式是NSData属性列表的格式，数据段输出的时候采用<>括住的16进制
-(id)initWithContentsOfFile:(NSString *)path
			        options:(NSUInteger)mask
				    error:(NSError **)errorPtr
	从参数path指定的文件读入二进制数据，用该数据初始化NSData对象，如果读取文件失败，则释放调用者并返回nil，同时把错误信息写入指针errorPtr中。
	mask便利构造器：dataWithContentsOfFile：options：error：
-(id)initWithContentsOfFile:(NSString *)path
	相当于上面方法中的第二个参数和第三个参数分别指定为来0和NULL
-(BOOL)writeToFile:(NSString *)path
	      atomically:(BOOL)flag
	将接收者的二进制数据写日path指定的文件中，如果写入成功，则返回YES，flag选项为YES时会进行安全写操作

3.2NSMutableData

本节将对可变的数据类NSMutableData进行说明
NSMutableData的实例对象在初始化后可被修改，比如增加或删除数据等
NSMutableData会随着数据的变更自动管理内存，使用者不必关系NSMutableData对象的内存管理
下面将对NSMutableData的几个主要方法进行说明，其中要注意的一点是，NSMutableData是NSData的子类，所以NSMutableData可以使用NSData的全部方法

（1、数据对象的生成和初始化

-(id)initWithCapacity:(NSUInteger)capacity
	生成一个容量为capacity字节的NSData对象，对象的空间会随着数据的增加自动扩展。除了这个方法外，还可以使用NSData的便利构造器data来创建一个长度为空的NSData对象
	便利构造器dataWithCapacity：
-(id)initWithLength:(NSUInteger)capacity
	初始化一个容量为capacity字节的NSData对象，同时将对象的数据都设为0
	便利构造器dataWithLength

（2、访问数据

-(void *)mutableBytes
	返回NSdata对象中数据缓冲区的头指针。和NSData的bytes方法不同，mutableBytes返回的指针是可写的。数据缓冲区的长度为0时，返回NULL

（3、追加数据

-(void)appendData:(NSData *)otherData
	复制otherdata中的数据，并将其追加到接收者的数据缓冲区后
-(void)appendBytes:(const void *)bytes
		      length:(NSUInteger)length
	在对象的末尾追加长度为length的bytes数据

（4、更新数据

-(void)replaceBytesInRange:(NSRange)range
			      withBytes:(const void *)replacementBytes
				   length:(NSUInteger) replacementLength
	把range指定范围内的数据替换为长度为replacementLength的数据replacementBytes
	range长度length和要替换的数据的长度replacementLength不等的话，range后面的数据会相应地被前后移动，长度也会发生变化。
	length为0的话，就相当于向原对象的头部插入replacementBytes
-(void)replaceBytesInRange:(NSRange)range
			      withBytes:(const void*)bytes
	把接收者中range指定范围内的数据替换为bytes相当于上面的方法replaceBytesInRange：withBytes：length：中 指定范围的长度和要替换的数据长度一样的情况
-(void)setData:(NSData *)aData
	设置NSMutableData类中的数据为aData所指向的内容
-(void)resetBytesInRange:(NSRange) range
	将range范围内的数据设为0

（5、增长数据缓冲区的长度

-(void)increaseLengthBy:(NSUInteger)extraLength
	为数据缓冲区增加长度extraLength 新增的区域都会被初始化为0
-(void)setLength:(NSUInteger)length
	重设数据缓冲区的长度为length 根据length的不同，数据缓冲区可增长或缩短，数据缓冲区增长的情况下，用0来填充新增的区域






    """},
  {'title' : '第九章（3）' , 'message' : """
4、数组类

4.1NSArray

数组是对多个对象的有序集，可以通过对象在数组中的位置来访问对象。和C语言一样，数组中元素的索引是从0开始的。数组中既可以存放不同类的对象也可以存放统一类的对象，但不能存放nil，nil被用于标志数组的结束。

NSArray是不可变数组，一旦创建以后，就不能再添加、删除或修改其中的元素。
如果想要更改数组中的元素的话，就需要使用可变数组NSMutableArray。
NSArray和NSMutableArray的实例称为数组对象

下面介绍一下NSArray的一些主要方法：

（1、数组对象的生成和初始化：

+(id)array
	返回一个不包含任何元素的空的数组对象。可变数组NSMutableArray中经常会用到这个方法。这个方法对应的初始化方法为init
+(id)arrayWithObject:(id)anObject
	生成并返回只包含anObject这一个元素的数组
-(id)initWithObjects:(id)firstObj,….
	生成并返回数组，数组中的元素由参数指定，参数之间用逗号分割，并以nil结尾
	便利构造器：arrayWithObjects：
-(id)initWithObjects:(const id *)objects
		       count:(NSUInteger)count
	参数objects是一个C语言风格的对象数组。这个方法会返回一个包含objects中前count个对象的数组
	便利构造器：arrayWithObjects：count：
-(id)initWithArray:(NSArray *)anArray
	用已有数组anArray中的对象来初始化并返回一个新的数组，anArray也可以是可变数组NSMutableArray的对象，所以这个方法也可以被用来从一个可变数组生成一个不可变数组
	便利构造器：arrayWithArray
-(id)initWithArray:(NSArray *)array
	   copyItems:(BOOL)flag
	和上面的方法的功能一样，唯一的区别是flag为真的情况下，会用array中的每一个元素的副本生成新的数组


（2、访问数组中的元素

-(NSUInteger)count
	返回数组中元素的个数
-(NSUInteger)indexOfObject:(id)anObject
	在数组中查询看是否有和anObject相等的元素，如果有就返回这个元素的索引，否则就返回NSNotFound（NSNotFound是一个宏，表示没有找到某个内容）如果只想查询数组中是否包含某个元素的话，可以使用方法containsObject：
-(id)objectAtIndex:(NSUInteger)index
	返回index索引位置的元素，如果index超过数组的最大长度的话，就会触发异常NSRangeException的发生
-(id)lastObject
	返回数组中最后一个元素，如果接收者为空的话，则返回nil
-(void)getObject:(id __unsafe_unretained [])aBuffer
		 range:(NSRange)aRange
	将aRnage指定范围内的对象复制到aBuffer指定的C语言缓冲区。只复制指针，引用计数不发生变化，也就是说不会发生任何所有权的改变，使用ARC的时候，为了保持数组中的对象，会讲起赋值给另一个强引用的变量。aBuffer需要足够强大，以能放下所有数据
-(NSArray *)subarrayWithRange:(NSRange)range
	抽取原数组中的一部分来生成一个新的数组

（3、比较

-(BOOL)isEqualToArray:(id)anObject
	比较两个数组是否一致，如果消息的接收者和anOBject包含的元素个数相同，而且相同索引位置处的元素相等的话，则返回YES
-(id)firstObjectCommonWithArray:(NSArray *)otherArray
	返回消息的接收者和otherArray这两个数组中第一个相同的元素，如果2个数组没有相同的元素，则返回nil

（4、为数组增加新的对象
NSArray是不可变类型的对象，不可以直接为其增加对象。如果想为数组对象增加新的对象的话，可以返回一个新的数组，新数组由原来的数组和新增对象共同构成

-(NSArray *)arrayByAddingObject:(id)anObject
	新生成并返回一个数组对象，新数组中的元素由消息接收者的元素和anObject共同构成，anObject加在新数组的末尾
-(NSArray *)arrayByAddingObjectFromArray:(NSArray *)anArray
	新生成并返回一个数组对象，新数组中的元素由消息接收者的元素和anArray中的元素共同构成，anArray中的元素加在原数组的末尾

（5、排序
NSArray的排序方法会返回一个新的数组，新数组是对旧数组中的元素经过选择器排序后的数组

-(NSArray *)sortedArrayUsingSelector:(SEL)comparator
	对数组中的对象逐个进行比较，并根据比较的结构生成一个新的数组。
	数组对象之间比较的时候使用选择器comparator指定的方法，选择器要求有一个输入参数，返回值
	例如，如果要对一个NSString的NSArray进行排序的话，选择器可以使用NSString的方法compare：
	newArray=[anArray sortedArrayUsingSelector:@selector(compare:)];

-(NSArray *)sortedArrayUsingFunction:(NSInteger (*)(id, id, void *))comparator context:(void *)context
	这个方法和上面的方法一样，也是对NSArray中的元素进行排序，返回一个排好序的新的NSArray
	区别在于对数组中元素进行比较的时候使用的函数是comparator。函数comparator有三个参数，前两个分别是数组中的元素，第三个是比较时自定义的一些选项，例如可以设置为忽略大小写等。函数的返回值是NSCommparisonResult类型。comparator是一个函数指针
	一个排序用的函数的定义如下： 	NSInteger myCmp(id arg1,id arg2,void * context);

（6、给数组中的元素发送消息
可以给数组中的每个对象发送消息，消息通过参数的消息选择器来指定
发送消息的时候会从第一个元素开始直到最后一个元素结束
元素在相应消息的同时有可能会发生波及作用，例如数组自身发生变化等，这种情况下就无法拨阿正最后一个元素也能成功响应消息

-(void)makeObjectsPerformSelector:(SEL)aSelector
	给数组中的每个对象发送消息，通过aSelector来指定消息
-(void)makeObjectsPerformSelector:(SEL)aSelector
					 withObject:(id)anObj
	给数组中的每个对象发送消息，通过aSelecotr来指定消息，消息可带有一个参数，通过anObj来指定

（7、文件输入与输出

-(NSString *)description
	将数组对象中的内容以ASCII编码的属性列表格式的字符串返回，返回由给数组汇中每个元素发送description消息而得到的字符串，字符串之间用“，”，并用（）括起来
-(id)initWithContentsOfFile:(NSString *)aPath
	从属性列表文件读取内容来初始化一个NSArray，如果读入失败，则释放消息接收者并返回nil
	便利构造器：arrayWithContentsOfFile
-(BOOL)writeToFile:(NSString *)Path
	      atomically:(BOOL)flag
	将数组中的内容以属性列表的格式写入aPath指定的文件中，正常写入是返回YES，flag为YES的情况下，执行安全写入。可以参考NSString的方法writeToFile：atomically：encoding：error
-(NSString *)componentsJoinedByString:(NSString *)separator
	返回一个临时字符串，字符串的内容用“，”连接的数组中每一个元素执行description的结果
-(NSArray *)pathsMatchingExtensions:(NSArray *)filterTypes
	这个方法被用于筛选带有特定扩展名的字符串，返回的是一个临时数组，数组汇中的每个元素的扩展名都属于filterTypes 逐个检测消息接收者数组中的每个元素，如果其扩展名在数组filterTypes中，就将其放入临时数组中


4.2NSMutableArray

NSMutableArray是NSArray的子类，所以可以使用NArray中定义的全部方法，NSMutableArray的接口也定义在文件Found/NSArray.h中
NSMutableDictionary是可变的，所以可随意添加或删除其中的元素，NSMutableDictionary中不存在空的位置

（1、可变数组的初始化

-(id)initWithCapacity:(NSUInteger)numItems
	创建并初始化一个长度为numitems的可变数组，虽然NSMutableArray会随着其中元素的增减自动管理内存，但也可以在初始化的时候指定数组的大小，也可以使用NSArray的Array方法创建一个长度为0的可变数组
	便利构造器：arrayWithCapacity

（2、向数组中追加和替换元素
基于引用计数的内存管理模式下，会给加入数组的对象发送retain消息，给从数组删除的对象发送release消息

-(void)addObject:(id)anObject
	添加元素anObject到数组的末尾，anObject不可以为nil
-(void)addObjectsFromArray:(NSArray *)otherArray
	将otherArray数组中的元素添加到数组的末尾
-(void)insertObject:(id)anObject
		   atIndex:(NSUInteger)index
	添加anObject到index指定的位置，后面的元素顺次后移，index必须在0和数组范围之间
-(void)replaceObjectAtIndex:(NSUInteger)index
			    withObject:(id)anObject
	用anObject指定的对象代替index位置上的元素，若index超过数组范围，则返回NSRangeException，anObject不可为nil
-(void)replaceObjectsInRange:(NSRange)aRange
	    withObjectsFromArray:(NSArray *)otherArray
	使用otherArray数组中的元素替换当前数组中的aRange范围内的元素。当前数组中aRange范围内的元素会被删掉
-(void)setArray:(NSArray *)otherArray
	用otherArray数组中的元素替换当前数组中的所有元素，当前数组中的所有元素会被删除
-(void)exchangeObjectAtIndex:(NSUInteger)idx1
		    withObjectAtIndex:(NSUInteger)idx2
	交换idx1和idx2位置上的元素

（3、删除数组中的元素
所有被删除的元素都会发送release消息
-(void)removeAllObjects
	删除数组中的所有元素，将其置空
-(void)removeLastObject
	删除数组中的最后一个元素
-(void)removeObjectAtIndex:(NSUInteger)index
	删除数组中的指定位置处的元素
-(void)removeObjectInRange:(NSRange)aRange
	删除数组中指定范围内的元素
-(void)removeObject:(id)anObject
	删除数组中所有和anObject相等的元素，可以使用方法isEqual：来判断数组中的元素是否和anObject相等，返回为YES的时候代表两个元素相等
-(void)removeObjectsInArray:(NSArray *)otherArray
	从当前数组中删除otherArray数组中包含的所有元素

（4、排序

-(void)sortUsingSelector:(SEL)comparator
	对当前数组中的元素进行升序排序
	排序时使用指定的selector：comparator来进行元素之间的比较
-(void)sortUsingFunction:(NSInteger(*)(id, id, void *))compare context:(void *)cintext
	对当前数组中的元素进行升序排序
	排序时使用传入的compare来进行元素之间的比较


4.3数组对象的所有权

基于引用计数的内存管理模式下，需要注意数组中的对象的所有权
数组会给其中的所有对象发送retain消息。当数组被释放的时候，他会给数组中的所有对象发送release消息，当对象被从数组中删除时，他也会收到一条release消息

数组、集合和词典对象这些可以包括多个对象的容器被总称为集合

4.4快速枚举

ObjectiveC 2.0 新提供了一个用于遍历容器类的语法，叫作快速枚举

下面就是利用快速枚举来遍历group的一个例子，遍历过程中group自身不会发生任何变化

id obj;
for(obj in group){
	printf(“%s\n”,[[obj description] UTF8String]);
}

这本书中吧这种语法称为for in 语法
for(变量 in 集合){
	/*相应的处理*/
}

其中“变量”必须是可以放入到容器中的类型。“集合”是一个容器类的对象。第一次执行循环之前会判断“集合”是否合法和其中是否有元素

4.5枚举器NSEnumerator

枚举器是一个用来遍历集合类（NSArray NSSet、NSDictionary等）中的元素对象的抽象类。ObjectiveC2.0中新增更方便地遍历集合类的for in语法
枚举器没有用来创建实例的公有接口，不能给枚举器发送alloc消息，需要和集合类配合使用，返回一个用于遍历的实例对象，NSEnumerator的接口定义在Foundation/NSEnumerator.h中

NSEnumerator中有2个抽象方法
-(id)nextObject
	nextObject方法可以依次遍历每个集合元素，结束时返回nil。通过和while结合使用可遍历集合中所有的项
-(NSArray *)allObjects
	allObjects方法可以返回集合中未被遍历的所有元素的数组

不同的集合类返回枚举器的方法各不相同 例如数组NSArray类返回枚举器的两个方法如下
-(NSEnumerator *)objectEnumerator
	返回一个按照顺序进行遍历的枚举器
-(NSEnumerator *)reverseObjectEnumerator
	返回一个按照逆序进行遍历的枚举器

下面是一个使用枚举器来按照顺序遍历数组的例子

NSArray *myarray;
id obj;
NSEnumerator *enumerator;
…
enumerator =[myarray objectEnumerator];
while((obj =[enumerator nextObject]) !=nil){
	/*处理*/
}

在使用枚举器遍历一个集合对象的同时，如果向该集合对象增加或删除对象，就可能会导致不可预期的结果，是很危险的

4.6快速枚举和枚举器

下面是一个利用逆序枚举器来遍历数组的例子
enumerator =[myarray reverseObjectEnumerator];//获取一个逆序枚举器
for (obj in enumerator){
	/*处理*/
}

4.7集合类

Foundation框架中提供了NSSet类，他是一组单值对象的集合，同NSArray不同，NSSet是无序的，同一个对象只能保存一次。集合类也有两个，即不可变的NSSet类和可变的NSMutableSet类
NSMutableSet是NSSet的子类，以类簇的形式存在。
除此之外，类NSMutableSet还有一个子类NSCountedSet。NSCuntedSet是一个可变的集合类，能够统计集合中对象的个数，这个类中可以存放对个相同值的对象

集合类的接口定义在Foundation/NSSet.h中
在基于引用计数的内存管理模式下，对元素对象所有权的处理和NSArray一样，即把对象放入集合的时候方法retain消息，把对象从集合中删除的时候发送relase消息

+(id)set
	返回一个临时的空的集合对象，对呀的初始化方法是init
-(id)initWithArray:(NSArray *)array
	使用参数array中的元素来初始化生成一个集合，array中存在重复元素时，集合中只保存一个。处理这个函数之外，集合类还包含由nil结尾的对象列表创建的集合的初始化构造函数、参数是C语言风格的数组的初始化构造函数，以及以上各个函数相应的便利构造器
-(NSUInteger)count
	返回集合对象中包含的元素个数
-(NSArray *)allObjects
	将集合对象中所有的元素以数组的形式返回
-(BOOL)containsObject:(id)anObject
	判断指定的anObject元素是否位于集合中，如果是则返回YES
-(BOOL)isEqualToSet:(NSSet *)otherSet
	判断2个集合是否相等，相等返回YES
-(BOOL)isSubsetOfSet:(NSSet *)otherSet
	判断当前合集的对象是否全部位于集合otherSet中，如果是则返回YES
-(BOOL)intersectsSet:(NSSet *)otherSet
	判断两个合集是否有共通的元素，如果有则返回YES

下面说明NSMutableSet中的方法：
-(id)initWithCapacity:(NSUInteger)numItems
	初始化一个大小为numItems的集合
	便利构造器：setWithCapacity：
-(void)addObject:(id)anObject
	向集合中追加元素anObject，如果集合中已经有这个元素，就什么也不会发生
	同样，方法addObjectsFromArray：的意思是把anObject数组中的所有元素追加到集合中
-(void)removeObject:(id)anObject
	从集合中删除元素anObject
-(void)unionSet:(NSSet *)otherSet
	将集合otherSet中的元素加入到当前集合中，生成2个集合的并集
	同样，方法minusSet：是从当前集合中删除同输入集合共通的元素
	方法intersectSet：是生成2个集合的交集
    """},
  {'title' : '第九章（4）' , 'message' : """
5、词典类 
Cocoa Foundation框架中童工了一种和Java/C++中map相类似的数据结构，叫作词典。
词典也可以分为 不可变词典NSDictionary和可变词典NSMutableDictionary
词典中的数据以键值对的形式保存，一个键值对称为entry，键和值可以是任何对象，一般使用字符串作为键
￼
在面向过程的语言中，一般使用下标或成员名来回去数组或结构体的值。词典对象的key和value都可以是对象类型，所以可扩展性非常高，可以用子啊各种环境下
词典的键必须是唯一的，也就是说，使用方法isEqual：来比较各个键时，必须各不相等。两外，nil不能作为词典的键
词典对象的值可以是除了nil外的任意对象，也可以是数组对象或词典对象，如果向保存数值或坐标对象的话，可以使用后面将介绍到的NSNumber和NSValue对象，另外，也可以使用NSNull来表明一个词典对象为空
一个对象作为词典的key或者value时，词典中存放的是这个对象的一份副本
基于引用计数的内存管理模式下，会给加入词典的key和value都发送一次retain，是他们引用计数器加1，在词典对象被释放的时候，会给词典的所有key和value对象发送一次release消息，使计数器减1

5.1NSDictionary

类NSDictionary是不可变的词典类，一旦创建之后就只能查询，不可再增加删除或者修改其中的内容，如果创建之后还想继续修改的话，请使用后面将要介绍到的类NSMutableDictionary
NSDictionary的接口定义在Foundation/NSDictionary.h中。NSDictionary是以类簇的方式实现的，所以无法用通常的方法为NSDictionary创建子类

（1、词典对象的生成和初始化

+(id)dictionary
	生成并返回一个空的词典对象，可变词典NSMutableDictionary经常使用这个方法返回一个空的词典，然后再通过init来初始化
+(id)dictionaryWithObject:(id)anObject
				forKey:(id)aKey
	返回一个词典对象，其中只包含一个关键字为aKey，值为anObject的键值对
-(id)initWithObjects:(NSArray *)objects
		    forKeys:(NSArray *)keys
	从数组object和keys中各取出一个元素作为value和key的键值对，返回包含该键值对的词典对象。数组objects和keys中必须包含相同数量的对象
	便利构造器：dictionaryWithObjects：forKeys：
-(id)initWithObjects:(const id[])objects
		    forKeys:(const id [])keys
		       count:(NSUInteger)count
	返回一个词典对象，由objects和keys数组中的元素作为键值对来初始化，词典对象中包含的元素个数由count来指定
-(id)initWithObjectsAndKeys:(id)object,(id)key,…
	使用指定的关键字和值来初始化词典对象，键值对以nil结束
-(id)initWithDictionary:(NSDictionary *)otherDictionary
	用一个一存在的词典对象来初始化另一个
	这个方法的参数也可以是一个可变词典对象NSMutableDictionary，这时能够为可变词典创建一个同样内容的比可变词典对象
	便利构造器：dictionaryWithDictionary：

（2、访问词典对象
-(NSUInteger)count
	返回词典对象中键值对的数量
-(id)objectForKey:(id)aKey
	返回指定aKey对应的值，如果aKey不存在就返回nil
-(NSArray *)allKeys
	返回一个数组，其中包含词典对象所有的关键词，如果词典对象为空，则返回一个空数组，方法allVlaue与此类似，返回一个包含词典对象所有值的数组
-(NSEnumerator *)keyEnumerator
	返回一个可访问词典中所有关键字的快速枚举器，与此类似，方法objectEnumerator返回一个可访问词典中所有值对象的快速枚举器
-(NSArray *)allKeysForObject:(id)anObject
	返回一个数组，数组中的元素为词典中值为anObject的所有关键字，如果输入的值在数组中不存在，则返回一个nil，使用方法isEqual：来进行比较

（3、比较

-(BOOL)isEqualToDictionary:(id)anObject
	比较两个字典，如果两个字典的键值对数和两个字典的每个关键字及其对应的值都相等，则返回YES

（4、文件输入输出
可以通过文件来初始化词典对象或吧词典对象中的内容输出到一个文件，文件的输入和输出都是通过属性列表完成的
-(NSString *)description
	将词典对象的内容以ASCII编码的属性列表格式输出
	如果词典的关键字是字符串类型，就按照升序输出，如果不是字符串类型，则随机输出
-(id)initWithContentsOfFile:(NSString *)path
	从属性列表格式保存的文件来初始化词典对象，如果读取文件失败，则释放词典对象，返回nil
-(BOOL)writeToFile:(NSString *)path
	      atomically:(BOOL)flag
	把代表这个词典内容的属性列表输出到指定的文件，写入成功时返回YES，writeToFIle：方法中有一个BOOL类型的参数flag，如果flag为YES，则代表安全写入

5.2NSMutableDictionary

NSMutableDictionary允许随意添加删除或修改键值对，随着词典中元素的变更，NSMutableDictionary会自动管理内存

（1、词典对象的生成和初始化
-(id)initWithCapacity:(NSUInteger)capacity
	创建并初始化一个长度为capacity的可变词典，虽然NSMutableDictionary会随着其中元素的增减自动管理内存，但也可以在初始化的时候指定词典对象的大小
	便利构造器：dictionaryWithCapacity：

（2、增加和删除键值对
向词典中追加元素的时候，词典会保存一份键值的副本
基于引用计数的内存管理模式下，会给追加的消息发送retain消息，当从字典中删除值对象的时候，则会给删除的值和值对象发送release消息
向词典中追加键值对时，如果关键字已存在，则会用新值替换旧值。具体来说就是给原有值发送relase消息，同时给心事发送retain消息
-(void)setObject:(id)anObject
		forKey:(id)aKey
	向可变词典中添加元素，要追加的关键值和值都不能为nil
-(void)addEntriesFromDictionary:(NSDictionary *)otherDic
	将otherDic中的数据追加到当前词典中吗，如果两个词典的关键字相同，则以otherDic的值作为最终值
-(void)setDictionary:(NSDictionary *)otherDic
	用新的词典otherDic覆盖当前词典，当前词典中的所有数据都被删除
-(void)remveObjectForKey:(id)aKey
	删除关键字为aKye的键值对
-(void)removeObjectsForKeys:(NSArray *)keyArray
	删除键值为数组keyArray中元素的所有键值对
-(void)removeAllObjects
	删除词典中的所有键值对

    """},
  {'title' : '第九章（5）' , 'message' : """
6、包裹类

Cocoa Foundation框架的集合类（NSArray、NSDictionary、NSSet）中只可以放入对象，不能存储基本类型的数据，所以Cocoa提供了NSNumber类来包装cha、int、long等基本类型的数据，使其能够被放入类似于NSArray或NSDictionary的集合中。

6.1NSNumber
NSNumber的接口文件是Foundation/NSValue.h

（1、生成和初始化

下面的方法生成并初始化一个整数对象。注意NSInteger不是一个对象，而是基本数据类型的typedef，它被typedef成64位的long或者32位int

-(id)initWithInteger:(NSInteger)value
	对应的类方法如下：
+(NSNumber *)numberWithInteger:(NSInteger)value	

表中列出来为各种数据类型生成NSNumber对象的初始化实例方法和便利构造器
￼
￼

（2、提取包裹类中的值
使用下面的方法可以提取出NSNumber实例中的NSInteger值，如果消息的接收者不是NSInteger的包裹类，会自动进行类型转换
-(NSInteger)integerValue
下表列出来包裹类中提起各种数据类型的方法
￼

（3、其他

-(BOOL)isEqualToNumber:(NSNumber *)aNumber
	比较两个NSNumber对象是否相等，返回值是BOOL类型
-(NSComparisonResult)compare:(NSNumber *)aNumber
	比较两个NSNumber对象的大小，返回值是一个NSComparisonResult
-(NSString *)stringValue
	返回NSNumber的字符串表示形式

6.2NSValue

NSValue的接口定义在Foundation/NSValue.h中，坐标等结构体定义在Foundation/NSGeometry.h中
NSValue的装箱（封装）和拆箱（解封装）方法如下：
￼
-(BOOL)isEqualToValue:(NSValue *)value
	比较两个NSValue对象是否相等，返回值是BOOL类型

6.3类型编码和@encode()

ObjectiveC是动态语言，有很多时候都不会清楚地标明对象的实际类型。但在保存数据和网络通信的时候，有时会需要明示自己的类型。NSValue和NSNumber可以包装很多类型的数据，但其内部需要保存数据的实际类型，另外，在进程或县城间通信的时候，也需要知道要发送的数据的实际类型
ObjectiveC的数据类型甚至自定义类型，都可以使用ASCII编码的类型描述字符串来表示。@encode()可以返回给定数据类型的类型描述字符串（C风格zfc，char *表示）例如，@encode(int)返回i，@encode(NSSize)返回“{_NSSize=ff}”
下表总结了常用的数据类型和其对应的类型描述符
￼
￼
通过使用方法initWithBytes：objCType：，就可以把任意类型的结构体包装成NSValue类型的对象，方法getValue：可以提取出包装好的结构体中的数值
-(id)initWithBytes:(const void *)value
	     objCType:(const char *)type
	参数type是指定的value的类型描述符，为了保证兼容性，不要通过直接输入C风格字符串来获取type，而一定要通过@encode来获取
	便利构造器：valueWithBytes：objCType：
-(void)getValue:(void *)buffer
	从包装好的NSValue对象中复制数据到buffer中
下面是一个为结构体创建NSValue实例的例子：
static grid{
	int x,y;
	double weight;
};
struct grid foo,bar;
id obj;

对结构体foo进行封装返回一个对象obj的代码如下所示：
	
obj=[[NSValue alloc]initWithBytes:&foo objCType:@encode(struct grid)];

把数据从obj中读入到变量bar中的代码如下所示：

[obj getValue:&bar];

NSValue只能包装长度确定的数据，不能包装长度可变的数据或元素可变的数组。例如，NSValue不能包装一个C风格的字符串

另外，因为NSValue和NSNumber数亿类簇的形式实现的，所以无法用通常的方法为其定义子类

6.4NSNull

前面我们介绍过不能在数组和词典对象中放入nil，因为在数组和词典对象中，nil有着特殊的含义，但有时我们确实需要一个特殊的对象来表示空值，这种情况下，我们就可以使用NSNull这一用来表示空值的类，NSNull的接口定义子啊Foundation/NSNull.h中

+(NSNull *)null
	这个方法会返回NSNull的实例对象，是一个常量，因为返回的是一个常量，所以不能用release来释放，另外NSNull的description会返回字符串<null>
判断一个对象是否是NSNull的写法如下：
if(obj == [NSNull null]) ….

7、NSURL

7.1关于URL

本章将说明一下Cocoa环境中用来表示网络或本地文件位置的类NSURL
统一资源定位符（URL）是因特网上标准的资源地址，URL除了用在因特网之外，也可以用于表示本机的资源，另外，除了HTTP协议之外，其他协议也可以使用URL来访问资源
URL Scheme是类似于http:// ftp:// file:// 这样的东西，MAcOSX和iOS中规定了四种可以使用NSURL来访问资源的形式
http：超文本链接协议
https：超文本传输安全协议http的安全版本，是超文本传输协议和SSL/TLS的组合
ftp：文件传输协议
file:访问某台主机上的文件

访问某哥资源的写法如下：
协议名：//主机名/主机内资源的路径

7.2NSURL的概要

URL中有很多特有的表达方法，所以操作URL的时候应该使用专用的NSURL类，而不要把URL当作字符串来手工解析
在介绍NSURL中的方法前，我们先来介绍一下方法名或参数名中包含的string和path的区别，string这里指的是URL的字符串，将string作为返回值的情况下，一定要返回经过url编码的字符串，方法名中如果包含了string，那么实际传入的参数也一定是经过编码的，另一方面，path用于表示URL的路径，无论作为返回值还是作为参数都要返回未编码的字符串

（1、NSURL实例的生成和初始化

-(id)initWithString:(NSString *)URLString
	用表示URL的字符串URLString生成一个NSURL的对象，URLString必须是url编码之后的，如果传入的字符串解析失败，则返回nil
	便利构造器：URLWithString：
-(id)initWithString:(NSString *)URLString
       relativeToURL:(NSURL *)baseURL
	使用baseURL和相对路径URLString来生成一个NSURL对象，如果URLString想使用绝对路径，可以把baseURL设为nil，传入的字符串必须是经过了URL编码的字符串，如果传入字符串解析失败，则会返回nil
	便利构造器：URLWithString：relativeToURL：
-(id)initFileURLWithPath:(NSString *)path
	用字符串格式的文件路径生成一个用于文件的NSURL对象，path不需要URL编码，如果传入的是一个相对路径，则使用调用该函数的程序的根目录作为baseURL
	执行的时候会判断传入的path是不是一个目录，如果是一个目录的话就会自动地在其末尾加上/ 如果确定path是一个目录，可以使用initFileURLWithPath：isDirectory：生成NSURL对象
	便利构造器：initFileURLWithPath：

（2、NSURL的构成要素

-(BOOL)isFileURL
	判断消息接收者对象是否是file开头的URL
-(NSURL *)baseURL
	返回消息接收者对象的baseURL，如果不存在的话，返回nil
-(NSString *)absoluteString
	返回消息接收者对象的URL的字符串表示，返回的字符串是url编码之后的
-(NSURL *)absoluteURL
	如果接受消息的对象是相对路径的URL，就生成并返回这个对象的绝对路径的URL，如果接收消息的对象本身就是绝对路径的URL，则返回自己
-(NSString *)relativePath
	返回接收消息的对象中相对路径的部分，如果接受消息的对象是有绝对路径生成的，则返回整个绝对路径，返回的字符串是没有经过url编码的
-(NSString *)relativeString
	返回URL字符串中相对路径的部分，如果接受消息的对象是有绝对路径生成的，则返回URL的绝对路径，返回的字符串是URL编码之后的

（3、路径操作和相关函数
所有与路径操作相关的方法的参数和返回值都是没有经过url编码的

-(NSString *)path
	返回消息接收者对象的路径字符串，也就是主机名之后的部分
	方法lastPathComponent可以取出URL中的最后部分，方法pathExtension可以取出路径的扩展名
-(NSURL *)URLByAppendingPathComponent:(NSString *)pathComponent
	在消息接收者对象URL的后面追加新的要素，返回一个新的URL对象，追加路径时别忘了追加相应的/	
	如果想主机啊扩展名的话可以使用方法URLByAppendingPathExtension：
-(NSURL*)URLByDeletingLastPathComponent
	删除消息接收者对象URL的最后一个要素
	如果想删除扩展名的话可以使用方法URLByDeletingPathExtension：

（4、文件引用URL
有两种表示文件位置的NSURL对象，一种是从文件路径字符串生成的NSURL对象，称为文件路径URL；还有一种是通过文件系统的文件ID生成的URL，这种URL交=叫作文件引用URL。文件引用UR：就算文件名被更改或者文件移动到别的地方，也能够继续索引文件

-(NSURL *)fileReferenceURL
	消息接收者对象如果是一个路径URL，返回其对应的文件引用URL对象，如果消息接收者对象不是一个本地文件，就返回nil
	与此相对，可以通过方法filePathURL来获取一个文件引用URL对象所对应的文件URL
-(BOOL)isFileReferenceURL
	如果消息接收者对象是一个文件引用URL的话就返回YES
-(BOOL)checkResourceIsReachableAndReturnError:(NSError **)error
	判断消息接收者对象所指向的文件是否存在没如果存在的话就返回YES，参数error返回具体错误信息，如果不想返回信息，可把error设为NULL

（5、获取和变更文件属性

使用NSURL可以获取或变更文件、目录和文件系统的属性，一个有代表性的例子是通过NSURL可以获取文件的消息，修改时间和权限等属性，通过Foundation框架的NSFileManager也能够完成同样的功能，但还是多少有所不同。例如，通过NSURL可以改变Finder的颜色标签的颜色

-(BOOL)getResourceValue:(out id *)value
				forKey:(NSString *)key
				   error:(out NSError **)error
	这个方法的功能是将key指定的属性值写入value中名，获取成功的话就返回YES，失败的话就返回NO，失败的原因会写入error，value前面的out修饰符表示这个指针是用于返回传值的
	同时获取多个属性的值的话可以使用方法resourceValuesForKeys：error：
-(BOOL)setResourceValue:(id)value
				forKey:(NSString *)key
				   error:(NSError **)error
	设定key的属性为value，设定成功的话就返回YES，失败的话就返回NO，失败原因会写入error
	同时设定多个属性值的话可以使用方法setResourceValue：error：

7.3使用NSURL来访问资源

本章对FOundation框架中最常用的类进行了介绍，这些类中和文件输入输出相关的方法都是通过字符串格式的文件路径来指定的，其实这些函数都还有一个用NSURL作为参数的版本，通过使用NSURL，不仅可以指定本地的文件，还可以指定网路上的文件
例如，许多类中都定义了下面这个方法
-(id)initWithContentsOfFile:(NSString *)path…
	基本所有定义了这个方法的类中都还有一个具体类似功能的以NSURL作为参数的函数，如下所示。同时，很多类中也会定义相应的便利构造器
-(id)initWithContentsOfURL:(NSURL *)aURL…
	原本NSURL是为了访问网络上的资源而设计的，随着Cocoa API版本的不断升级，原来很多文件输入输出的地方也开始使用NSURL，这也说明MACOSX特别是IOS也就罢网络作为自己的一部分了
    """},
  {'title' : '第十章（1）' , 'message' : """
1、范畴

1.1范畴

到目前为止 我们都是在@implementation和@end之间实现类的方法，而对于有很多方法的超大的类，我们则可以把方法的实现分散到不同的模块中。

实现某个类的一部分方法的模块叫做范畴或类别。一个类即可用不使用任何范畴，也可以由多个范畴构成。调用范畴中定义的方法和调用普通方式定义的方法一样，下图是 a目前为止使用的在一个文件中实现类的所有方法，与此相对，b是在多个范畴中实现类的方法
￼
范畴和类一样，都是在接口文件中声明，在类文件中实现，但范畴中不能声明实例变量，只能声明方法，声明的方法既可以是类方法也可以是实例方法

范畴的语法如下所示。“类名”部分为范畴所属的类的名字或即将添加该范畴的类的名字，“类名”必须是已经存在的类，不能为一个不存在的类定义范畴

语法：范畴的声明：
@interface 类名（范畴名）
方法的声明；
…
@end

范畴名的命名规则和C语言变量的命名规则一样，在不使用类中已定义的范畴名的前提下，可以为范畴随意命名，当然起一个和范畴内容相关的名字是最好的，范畴的实现部分的语法如下所示：

语法：范畴的实现
@implementation类名（范畴名）
方法的定义；
…
@end

在实现部分中实现接口文件中定义的方法，实现部分除了不可以定义新的实例变量外，都和传统方式实现文件一样，例如，方法的实现中可以自由调用别的方法，访问已定义的实例变量等。除此之外，也可以定义局部方法或C语言函数等

1.2范畴和文件的组织

下面说明一下范畴的接口部分和实现部分的文件组织方式，一个典型的例子就是包含主文件接口的头文件中也包含了其他所有接口，如下所示：
￼

另外一种定义范畴的方法就是将每个范畴部分都单独定义成一个头文件。每个实现文件都可以被单独编译，实现文件一般被命名为“类名+范畴名.m”
范畴的接口部分需要遵循以下几个原则，下面提到的引用既包括引用同一个文件中的内容也包括引用其他文件中的内容

- [ ] 范畴的接口部分必须引用主文件的接口文件
- [ ] 范畴的实现部分必须引用对应的接口文件
- [ ] 使用范畴中的方法时必须引用这个方法所在的头文件

需要注意的是，除了要调用范畴部分中定义的方法之外，主文件接口部分中不会引用各个范畴的接口和实现文件
另外，也可以将多个范畴的实现部分写在同一个文件中，但这样就失去了定义范畴的意义了
￼

1.3作为子模块的范畴

如果是有很多方法的规模很大的类，把所有实现部分都写在一个文件里就比较不方便，这种情况下可以通过范畴将类的实现部分以模块为单位分散到多个不同的文件中，也就是把范畴作为类的子模块来用
范畴本来是Smalltalk中的概念，被用于将多个方法按照互相关系，用途等特征分类，以便最快速地找到自己最想要的方法

ObjectiveC中也应该将关系紧密的方法作为一个范畴来分类
把类按照范畴分类，和C语言编程中把某些函数保存在同一个文件中比较类似。把实现方法互相依赖或共用同一个局部变量的方法定义为一个范畴。通过这种方法，类中依赖性相对比较高的一部分就会被归纳出来，开发也会变得更加容易
上面讲述的内容的前提都是类的规模非常大，这种情况下通过使用范畴可以提高开发效率，但实际上规模大的类并不是一个好的选择。在设计阶段，如果发现一个类的方法很多，最好把这个类的功能分成几个类来实现
与此相反，由过小的对象组成的系统也会有通信不好控制、功能不易划分等问题，所以，虽然并没有什么准则来指明一个类到底应该多大，但类的大小适当很重要

1.4方法的前向声明

第三章中我们曾经提到过这样一个问题，即为在接口部分中声明的局部方法，和未声明的C语言函数一样，其定义之前的代码是没法使用他们的，而通过使用范畴，我们就可以解决这个问题

下面我们来看一个例子，某个文件中定义了下面2个函数：
-(int)methodA{
	if(…)
		[self methodB:0];
	…
}
-(void)methodB:(int)arg{
	double v=[self methodA];
	…
}
	methodA和methodB都是局部方法，这两个方法都未在接口中声明，所以编译器子啊编译方法A的时候，并不知道methodB的参数和返回值的类型，就算交换methodA和methodB：的顺序也会有同样的问题

这种情况下，通过把有问题的方法都加入到一个局部范畴中，并在实现文件的头部加上范畴的声明和定义，就可以解决这个问题
@interface 类名(Local)
-(int)methodA;
-(void)methodB:(int)arg;
@end

@implementation 类名(Local)
-(int)methodA{
	if(…)
		[self methodB:0];
	…
}
-(void)methodB:(int)arg{
	double v=[self methodA];
	…
}
@end

这里使用了Local作为范畴名，这个名字可以随意指定，这个范畴只在这个文件内被使用，是局部的。
C语言中可以通过在文件的最前面加上函数声明来解决类似问题，从效果来讲是一样的

1.5私有方法

将类划分多个范畴后，就必须考虑该如何划分共有方法
如下图，一种划分方法就是创建一个对外不公开的接口文件，其中声明类的共有变量和方法，这样一来，方法就被放入到了某个范畴中，这些方法和变量的实现既可以被单独放入一个文件，也可以和别的范畴实现放在一起，本例子中只有Card.h和Card+Sort.h的内容是对外公开的
Card+Local.h中的内容是类的范畴之间共有的方法和变量
￼
像这样，即使在多个文件中进行了共通的声明，也可以定义仅供类内文件使用而不对类外公开的方法和实例变量。本书中把这种方法叫做私有方法

1.6类扩展

由多个范畴组成的类就好像是给主类加上了各种选项，需要靠程序员来保证主类和各种范畴能够作为一个整体正常工作
把类分为多个范畴来实现的情况下，主类和各个范畴都是独立的，每个范畴都不清楚其他的部分，有的范畴可能是执行前加载的，有个可能是执行时动态加载的
这种实现方法的可扩展性非常好，但编译器在连接时不会检查是否所有的范畴都被链接到了可执行文件中，如上图例子，链接时就算忘记了Card+Local.m也不会报错，但如果可执行程序在执行的时候调用到了Card+Local.m中的定义的函数，程序就会抛出异常，执行失败
上一节中我们介绍了如何定义类内共享的私有方法，但这种方法有时候会忘记链接私有方法。
针对这种情况，类扩展的概念被引入进来
类扩展的声明和范畴比较相似，只是圆括号之间没有文本，例如，只有一个方法的类扩展的定义如下所示
@interface Card()
-(BOOL)hasSameSuit:(Card *)obj;
@end

使用类扩展也可以增加实例变量，如下所示
@interface Card(){
	BOOL flag;
}
-(BOOL)hasSameSuit:(Card *)obj;
@end

类扩展中声明的方法需要在类的实现文件中实现，如下图所示不管是否引入了类扩展的定义，只要在类的实现部分中没实现对应的方法，就会出现编译错误。也就是说，通过将一定要实现的私有方法繁缛类扩展中，就可以防止忘记实现这个方法或漏掉方法的实现等问题
但是，类扩展自身并不会让方法变为私有方法，如果想让方法变成私有方法，必须不能让包含了类扩展的头文件对外公开
类扩展中声明的实例变量只能在引入了类的主接口和扩展声明的范畴中使用，主类的实现部分也可以声明实例变量，但声明的实例变量只在该文件中有效，与此相对，类扩展中定义的实例变量可以在多个范畴中使用
￼
1.7范畴和属性声明

范畴的接口中可以包含属性声明，但要注意的是，范畴的实现部分中不能包含@synthesize 范畴的接口中包含属性声明的情况下，实现部分中就需要手动定义访问方法，这是为了防止随意访问同一个类的不同文件中定义的实例变量
类扩展中也可以包含属性声明，属性是通过在类的实现部分包含@synthesize或者属性方法来实现的，类扩展中也可以声明实例变量的属性
范畴再加上类扩展可能会让你觉得乱，让我们把上面介绍的内容用一张表总结一下，需要注意的是，类扩展只能引用类内的实例或方法，至于范畴的头文件是公开的还是只限类内使用，则是由具体的使用情况决定的
￼


2、给现有类追加范畴

2.1追加新的方法

无论是自己定义的类还是系统的类，利用范畴都可以为已有类追加新方法

我们一般通过继承的方式来为现有类增加新的功能，但有的时候使用子类并不方便，例如无法用通常的方法来为NSString创建子类（NSString是以类簇的形式实现的）等。而范畴的好处就是可以为正在使用的类增加新的功能
我们用给NSString增加方法的例子来说明一下，假设我们不使用范畴，也可以通过给NSString定义子类的方法来增加新功能，但Foundation众多类的参数或返回值写的都是NSString，将所有的NSString都替换为新定义的子类显然不是一个好的方法，这种情况下，使用范畴来追加方法就是一个很好的选择了
另外，通过范畴给现有类追加方法后，这个类的子类不需要做任何修改就能使用新追加的方法，而通过继承定义子类的情况下则无法实现这个功能

虽然使用范畴来追加方法很方便，但也要注意不要滥用，把看似方便的功能都加到已有类上不是一种好的编码方式

2.2追加方法的例子

字符串类NSString有方法stringByAppendingPathComponent：如果接受消息的对象是一个目录的路径，该方法就回吧参数的字符串加到目录路径的后面，并返回一个新的字符串。例如，路径名是@“/tmp/image”的情况下，追加字符串@“thumb”后，返回值就为字符串@”/tmp/image/thumb“这个方法只能接收一个参数，这里我们尝试一下为NSString追加一个可同时追加多个参数的方法
假设要追加的方法名为stringByAppendingPathComponents：，参数是可变参数列表的形式，以nil结尾，可变参数方法的定义请参考下面的Column
NSString是以类簇的形式实现的，下面的程序也可以作为给类簇增加新方法的一个例子

代码清单10-1 NSString+PathComp.h

#import <Foundation/NSString.h>
@interface NSString (PathComp)

-(NSString *)stringByAppendingPathComponents:(NSString *)str,...
    NS_REQUIRES_NIL_TERMINATION;
@end


代码清单10-2  NSString+PathComp.m

#import "NSString+PathComp.h"
#import <Foundation/NSPathUtilities.h>
#import <stdarg.h>

@implementation NSString (PathComp)

-(NSString *)stringByAppendingPathComponents:(NSString *)str, ...
{
    va_list varglist;
    NSString *work,*comp;
    if(str == nil)
        return self;
    work = [self stringByAppendingPathComponent:str];
    va_start(varglist, str);
    while ((comp =va_arg(varglist, NSString *)) !=nil) {
        work = [work stringByAppendingPathComponent:comp];
    }
    va_end(varglist);
    return work;
}

@end

以上代码给NSString增加了新的范畴PathComp 范畴的名字可以随便起，只要不和已有范畴重名即可
把以上2个文件和其他文件一起编译、链接后，就可以像使用NSString原本就有的方法一样使用stringAppendingPathComponents：了，但是，要使用这个方法的模块必须要包含头文件NSString +PathComp.h
下面是为了测试新方法而写的一个简单的main（）函数


代码清单10-3 测试程序

#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSString.h>
#import <stdio.h>
#import <Foundation/NSAutoreleasePool.h>
#import "NSString+PathComp.h"

int main(void){//利用ARC
    NSString *pict = @"Pictures";
    NSString *homedir,*s;
    @autoreleasepool {
        homedir =NSHomeDirectory();
        s=[homedir stringByAppendingPathComponent:pict];
        printf("%s \n",[s UTF8String]);
        s=[homedir stringByAppendingPathComponents:pict,@"tmp",nil];
        printf("%s\n",[s UTF8String]);
        s=[homedir stringByAppendingPathComponents:@"Desktop",pict,@"wallpaper",nil];
        printf("%s\n",[s UTF8String]);
    }
    return 0;
}

ANSI C中有可以定义printf（）这样的可变参数的函数。ObjectiveC中也同样可以定义可变参数的方法

可变参数又如下几个限制
- [ ] 参数列表中不能有可变参数
- [ ] 可变参数必须出现在参数列表的最后
- [ ] 可变参数的类型必须由程序来管理

也就是说，调用可变参数的方法的时候不能没有任何参数，要至少有一个变量，可变参数变量不能出现在参数列表的中间位置，只能出现在参数列表的最后，调用时参数列表中允许存在不同类型的参数，但是程序要保证类型的正确性
定义可变参数的方法或函数时要引入头文件stdarg.h 用,,,来表示可变参数，获取可变参数前，需要定义一个va_list	类型的变量，变量名可随意命名，下面这个例子中使用变量名pvar
从可变参数列表中取出每个参数的代码如下所示

va_start(pvar,可变参数前一个变量的变量名);
	…
f=va_arg(pvar,类型名);//可变参数有多少个，就循环执行这条语句多少次
	…
va_end(pvar);

va_start()为访问可变参数进行准备，va_start()的第二个参数是可变参数前面紧挨这的一个变量，即…之前的那个参数
调用 va_arg()获取可变参数的值， va_arg执行的时候能够得到下一个变量值。va_arg()的第二个参数是获取的参数的类型，这个类型不一定都要一样，此处不能保证实际返回的参数类型和指定的参数类型一致，需要程序中做个中额外的容错处理
获取所有的参数之后调用 va_end()就可以关闭pvar指针，通常va_start和 va_end都是成对出现的
可变参数一般以NILL或nil结尾，但在实际使用的时候经常会出现忘记加NULL的情况，这个问题可以通过在函数或方法声明的末尾加上宏变量NS_REQUIRES_NIL_TERMINATION来解决，这样一来，如果在编译的时候发现网络NULL，就会提示警告，代码清单10-1声明方法是就加了宏变量NS_REQUIRES_NIL_TERMINTION
NS_REQUIRES_NIL_TERMINTION自身定义在Foundation/NSObjCRuntime.h中，可以指定gcc风格的函数属性来替换它

2.3覆盖已有的方法

新定义的范畴中的方法如果和原有的方法重名的话，新定义的方法就会覆盖老方法，通过使用这种方法，我们就可以在不使用继承的情况下实现方法的覆盖。
但如果不小心覆盖率原有的方法，也可能会引发不可预测的问题，例如，为NSobject定义了一个新的范畴，并在其中用自己定义的方法覆盖了原有的方法等，而一旦覆盖了比较重要的方法，很容易就会发生严重的问题，另外如果多个类别中定义了相同名字的方法，实际执行时就无法保证到底执行了那个方法
所以不建议利用范畴覆盖已有方法，但是就算是覆盖了已有方法，编译器或连接器也不会提示任何警告，管理方法名的时候一定要注意不要覆盖已有的方法

    """},
  {'title' : '第十章（2）' , 'message' : """
3、关联引用

3.1关联引用的概念

通过范畴可以为一个类追加新的方法但不能追加实例变量。但是 利用ObjectiveC语言的动态性，并借助运行时（runingtime）的功能，就可以为已存在的实例对象增加实例变量，这个功能叫做关联引用。将这个功能和范畴组合在一起使用，即使不创建子类，也能够对类进行动态扩展

一般情况下，在类定义中，该类的所有实例都能够使用接口中声明的实例变量
与此相对，关联引用指的是在运行时根据需要为某个对象添加关联，就算是同一个类的不同对象也有可能添加（或不添加）关联或添加不同种类和数量的关联。另外，已添加的关联也可以被删除

3.2添加和检索关联

下面我们来看一下添加关联和检索关联用的2个方法，这2个方法的定义在头文件objc/runtime.h中

void objc_setAssociatedObject(id object,void *key,id value,objc_AssociationPolicy policy)
	这个方法是为对象object添加以key指定的地址作为关键字，以value为值的关联引用，第四个参数policy指定关联引用的存储策略
	通过将value指定为nil，就可以删除key的关联

id objc_getAssociatedObject(id object,void *key)
	返回object以key为关键字关联的对象。如果没有关联到任何对象，则返回nil

本章中把药增加关联的对象（想扩展的对象）称为所有者，把追加的对象称为引用对象
例如，假设我们要为obj增加r和s两个关联引用。那么obj就是所有者，r和s就是引用对象。考虑到可以为一个对象增加多个关联引用，所以要用key来区分，另外，必须使用确定的、不再改变的地址作为键值。例如，使用定义在实现文件中的静态局部变量的地址作为key就是一个不错的选择。关于策略policy，我们将会在后面进行详细介绍

static char rKey,sKey; // 静态变量，这里只利用他们的地址作为key
…
objc_setAssociatedObject(obj,&rKey,r,OBJC_ASSOCIATION_RETAIN);
objc_setAssociatedObject(obj,&sKey,s,OBJC_ASSOCIATION_RETAIN);
…
id x= objc_getAssociatedObject(obj,&rKey);
id y= objc_getAssociatedObject(obj,&sKey);

以上的操作就相当于将x和y分别赋值给来r和s，使用地址作为key的原因是为了保证唯一性，上面例子中的变量rKey和sKEy不会被用来存储什么，也不会对其进行赋值操作
在上例中，函数调用时的第一个参数都用来obj，其实这个位置可以使用任意对象，如果关联引用的目的是给一个对象增加实例变量的话，这个地方可以使用self代替obj，使用self的情况下，因为运行时self表示的对象不同，所以就算是使用同一个key作为键值也无所谓。关于这点，后面会通过一个具体例子进行详细说明

3.3对象的存储方法

objc_setAssociationObject()的第四个参数policy是关联策略。关联策略表明了关联的对象是通过何种方式进行关联的，以及这种关联是原子的还是非原子的，policy的值有以下几种可供选择，其中最常用的是OBJC_ASSOCIATION_RETAIN
截止到写作本书的时候，内存管理使用ARC的情况下，相当于弱指针的对象保存方式好像还没有出现没如果指定存储策略为OBJC_ASSOCIATION_RETAIN,就是通过保持的方式进行关联，而ARC的情况下，指定OBJC_ASSOCIATION_ASSIGN则表示赋值的方式进行关联，可能会出线悬垂指针，编程的时候一定要注意

OBJC_ASSOCIATION_ASSIGN
	使用基于引用计数的内存管理时，不给关联对象发送retain消息，仅仅通过赋值进行关联，内存管理使用垃圾回收时，会把引用对象作为弱引用保存
OBJC_ASSOCIATION_RETAIN_NONATOMIC
	使用基于引用计数的内存管理时，会给关联对象发送retain消息并保持，如果同样的key已经关联到了其他对象，则会给其他对象发送release消息，释放关联对象的所有者时，会给所有的关联对象发送release消息，内存管理使用垃圾回收时，会以强引用的形式保存关联对象 OBJC_ASSOCIATION_RETAIN
	在对象的保存方面和OBJC_ASSOCIATION_RETAIN_NONATOMIC的功能一样，唯一有区别的时OBJC_ASSOCIATION_RETAIN是多线程安全的，支持排他性的关联操作 OBJC_ASSOCIATION_COPY_NONATOMIC
	在进行对象关联引用的时候会复制一份原对象，并用新复制的对象进行关联操作
OBJC_ASSOCIATION_COPY
	在对象的保存方面和OBJC_ASSOCIATION_COPY_NONATOMIC的功能是一样的，唯一区别的是OBJC_ASSOCIATION_COPY是多线程安全的，支持排他性的关联操作，objc_getAssociatedObject()的操作和OBJC_ASSOCIATION_RETAIN一样

要复制一个对象需要实现第13章说明的方法

3.4断开关联

ObjectiveC也提供了运行时断开关联的函数

void objc_removeAssociatedObjects(id object)
	断开object的所有关联

这个函数会断开object对象的所有关联，有一定的危险性。例如，已有代码可能已经使用了关联的对象，有的带吗新添加的范畴也可能会使用到已关联的对象，所以不建议使用objc_removeAssociatedObjects一次性断开所有关联，推荐使用objc_setAssociatedObject,传入nil作为其参数，来分别断开关联

3.5利用范畴的例子

下面我们来看一个使用范畴的例子，假设我们要给NSArray增加一个新的随机取元素的方法，这个方法取得的元素可以相同，但不可以恋曲取得相同的元素

我们利用范畴为NSArray定义这样的一个方法，因为需要记忆前一次取得的元素，所以使用了关联引用

代码清单 10-4  NSArray+Random.h

#import <Foundation/NSArray.h>
@interface NSArray (Random)
-(id) anyOne;
@end

代码清单10-5 NSArray+Random.m

#import "NSArray+Random.h"
#import <objc/runtime.h>

@implementation NSArray (Random)

static  char prevKey;//定义键使用的地址变量

static int random_value(void){ //使用线性同余法
                               //生成随机数
    static unsigned long rnd =201008;//随机数种子，可随机设置
    rnd = rnd *1103515245UL +12345;
    return (int)((rnd >>16) & 0x7fff);
}
-(id)anyOne{
    id item;
    NSUInteger count = [self count];
    if(count ==0)
        return nil;
    if(count ==1)
        item =[self lastObject];
    else{
        id prev = objc_getAssociatedObject(self , &prevKey);//初次使用关联引用返回nil
        NSUInteger index =random_value() %count;
        item =[self objectAtIndex:index];
        if(item == prev){//如果和上回取得的值相同
            if(++index >=count)//索引+1
                index =0;
            item =[self objectAtIndex:index];
        }
    }
    objc_setAssociatedObject(self,&prevKey,item,OBJC_ASSOCIATION_RETAIN);//存储h最后返回的对象
    return item;
}

@end

代码清单10-4 是范畴的头文件，其中只增加了一个方法。代码清单10-5中首先定义了用做关联引用的键值的static变量，static变量定义在范畴实现文件中，其他范畴无法使用这个变量的地址，函数random_value中使用线性同余法生成了随机数，NSArray以及它的子类都能够使用函数random_value和anyOne

anyOne方法首先会查看数组中有多是奥哥函数，如果有2个以上的话，就调用random_value方法随机生成索引，并用索引获得要返回的值，如果这次的值和上次返回的值相等，则索引值加1，最后，把要返回的元素登记到关联引用，以便下次比较使用
因为关联到各个实例对象的是不同的元素，所以多个实例对象也可以使用这个方法。item和实例变量一样可以被作为各实例变量自身的值来使用，另外，不使用这个方法的实例变量也不会生成关联引用。

代码清单10-6展示了使用以上范畴的main函数，这里同时声明了2个NSArray对象，其中一个是NSarray的子类NSMutableArray，随着循环的进行元素的个数会增加

代码清单10-6 main.m

#import "NSArray+Random.h"
#import <Foundation/Foundation.h>

int main(void) { //使用ARC
    @autoreleasepool {
        id arr1 =[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",nil];
        id arr2 = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",nil];
        for(int i=5;i<20;i++){
            @autoreleasepool {
                printf("%s %s\n",[[arr1 anyOne] UTF8String],[[arr2 anyOne] UTF8String]);
                [arr2 addObject:[NSString stringWithFormat:@"%02d",i]];
            }
        }
    }
    return 0;
}

通过综合使用关联引用和范畴，可以大大增强ObjecitveC编程的灵活性，但也要注意不能滥用范畴，滥用范畴会导致程序变得不好理解，因此，在使用范畴之前，要考虑是否有其他方法，比如创建子类等，另外，因为通过范畴扩展添加的实例变量并不是真正的实例变量，所以在对象复制和归档时要特别注意



    """},
  {'title' : '第十一章（1）' , 'message' : """
1、抽象类

我们都知道使用绘图工具就可以在窗口中绘制圆形、长方形、三角形等图形。虽然这些图形与窗口中的表示方法、鼠标绘图的方法有些不同，但操作鼠标时的动作（如移动，扩大、缩小）颜色的指定、复制操作都等对应了同一个消息
这种情况下，美中图形移动相关的方法等都要分别定义，同样的工作我们不得不重复好多次
￼
上图中圆为超类，而长方形是它的子类，显然这样的类层次结构让人感到很不自然，而且也会给以后的使用带来很多问题
按照一般思维，可能最容易被人接受的方法就是定义一个图形了，并将圆和长方形都定义为它的子类。移动、复制等图形的公共操作在图形类中描述，而具体的绘图方法则在子类中定义
对于超类图形来说，尽管每个子类只是实现方法上有所不同，但他们都需要分别声明，这样一来，只要是图形类的子类，就能实现对应超类图形的方法，因此我们事先将对象的类型定义为超类图形，就可以使用静态类型check来书写代码，但是，超类图形自身并不能绘制具体的图形，所以，不能生成对象实例。
￼
如图，在定义子类是，在子类中只声明那些需要具体定义的方法，这样的类就是抽象类，或者称为虚类
ObjectiveC在语法上并没有什么特别的机制来区分抽象类和能够生成实例的普通类的定义，在ObjectiveC中抽象类这一术语只停留在概念上，而大多数面向对象的语言都使用virtual或abstract作为关键字来指明抽象类

在ObjectiveC中，即使是抽象类，只要能够使用alloc方法，也可以生成类实例，但折磨做没有什么实际意义，例如，类NSObjecit可以生成实例，但几乎没有什么用处，只能为子类提供有用的公共方法，从这点看来，我们可以说类NSObject具有很强的抽象类特质

1.2抽象类的例子

例如，我们试着在不使用GUI的条件下，编写一个简单的图形类，据此来告诉大家抽象类到底为何物，以及到底该如何使用：

代码清单11-1 类Figure的接口部分

Figure.h

#import <Foundation/NSObject.h>
#import <Foundation/NSGeometry.h>

@class NSString;

@interface Figure : NSObject
@property(assign) NSPoint location;//设置图形的位置
-(void)setSize :(NSSize)newsize;//指定图形大小
-(double)area;//计算图形大小
-(NSString *)figureName;//返回表示图形名字的字符串
-(NSString *)stringOfSize;//返回表示图形大小的字符串
-(NSString *)description;//当前图形的位置d、大小
                         //返回表示图形面积的字符串
@end

类Figure并没有规定具体的子类的实例是什么形状的名单在结构体NSPoint类的属性location中保存了图形的位置坐标。类型NSPoint包含CGFloat类型的成员x、y表示画面上点的坐标

方法setSize的参数为结构体NSSize，类NSSize定义了CGFloat类型的成员width和height 表示长方形的大小

代码清单11-2类Figure

Figure.m

#import <Foundation/NSString.h>
#import "Figure.h"

@implementation Figure

@synthesize location;
-(void)setSize:(NSSize)newsize{
    /*virtual*/
}
-(double)area{
    return 0.0;
}
-(NSString *)figureName{
    return nil;
}
-(NSString *)stringOfSize{
    return nil;
}
-(NSString *)description{
    NSPoint loc=self.location;
    return [NSString stringWithFormat:@"%@ : location=(%.2f,%.2f), %@,area =%.2f",[self figureName],loc.x,loc.y,[self stringOfSize],[self area]];
}
@end

首先 属性location由@synthesize来定义，子类中也使用该定义，需要注意的是，其他方法的定义实质上是没有意义的
请大家注意最后定义的方法description，该方法会返回包含了图形名字，位置，大小，面积的字符串，在返回构造的字符串时，还会向self发送消息来获得相应的值
方法哪的self并不能被当作Figure类的直接调用接口，而是向某种具体的表示图形的子类的实例发送description消息时的接口，此时，self表示的是那个图形类的接口，因此，通过使用那个子类中的定义，方法area就会计算出面积，方法stringOfSize也会返回表示大小的字符串
不仅在抽象类的定义中，在面向对象的语言中，我们也经常使用超类来实现子类的定义，虽然滥用的话会导致程序难于理解，但如果能熟练使用，对构筑灵活、易扩展的类层次关系还是非常有益的

下面代码清单表示的是类Figure的子类，即表示圆形的Circle和表示长方形的Rectangle

代码清单11-3 类Circle的接口部分

Circle.h

#import "Figure.h"
@interface Circle : Figure{
    double radius;
}
@end

代码清单11-4 类Circle的实现部分

Circle.m

#import <Foundation/NSString.h>
#import "Circle.h"
#import <math.h>

#define PI 3.14159

@implementation Circle

-(void)setSize:(NSSize)newsize{
    double x = newsize.width;
    double y = newsize.height;
    radius = sqrt(x*y+y*y);
}
-(double)area{
    return radius *radius *PI;
}
-(NSString *)figureName{
    return @"Circle";
}
-(NSString *)stringOfSize{
    return [NSString stringWithFormat:@"radius=%.2f",radius];
}

@end

类Circle的大小用半径，也就是接口参数radius来表示，方法setSize：用来设定大小，该方法用长方形对角线长作为参数来确定半径，这和鼠标拖拽时以起点为圆心，将起点到终点的距离作为半径的方法类似

代码清单11-5 类Rectangle的接口部分

Rectangle.h

#import "Figure.h"

@interface Rectangle : Figure{
    NSSize size;
}

@end

代码清单11-6 类Rectangle的实现部分

Rectangle.m

#import <Foundation/NSString.h>
#import "Rectangle.h"

@implementation Rectangle

-(void)setSize:(NSSize)newsize{
    size =newsize;
}
-(double)area{
    return size.width *size.height;
}
-(NSString *)figureName{
    return (size.width == size.height) ? @"Square" : @"Rectangele";
}
-(NSString *)stringOfSize{
    return [NSString stringWithFormat:@"size = %.2f x %.2f",size.width,size.height];
}

@end

类Rectangle中使用宽和高两个参数来表示图形的大小，通过方法figureName查找图形名时，如果宽澄宇高，则返回正方形
最后我们来看一下测试该类的main函数，虽然有点啰嗦，但却是难点所在，使用ARC进行内存管理，测试流程的本体时函数testLoop这里需要注意的是，变量fit的类型为（Figure *）

代码清单11-7 测试类Figure的main函数

#import "Figure.h"
#import "Circle.h"
#import "Rectangle.h"
#import <Foundation/NSString.h>
#import <stdio.h>

BOOL testloop(void){
    Figure *fig =nil;
    double x,y,w,h;
    char buf[64],com;
    
    do{
        printf("Share (C=Circle,R=Rectangle,Q=Quit) ?");
        if(scanf("%s",buf) == 0||(com =buf[0]) == 'Q' || com=='q')
            return NO;
        switch (com) {
            case 'C':
            case 'c':
                //Circle
                fig = [[Circle alloc]init];
                break;
            case 'R':
            case 'r':
                //Rectangle
                fig=[[Rectangle alloc ]init];
                break;
        }
    }while(fig == nil);
    printf("Location ?");
    scanf("%lf %lf",&x,&y);
    fig.location=NSMakePoint(x, y);//生成NSPoint
    printf("Size ?");
    scanf("%lf %lf",&w,&h);
    [fig setSize:NSMakeSize(w, h)];//生成NSSize并设定
    printf("%s\n",[[fig description] UTF8String]);
    return YES;
}
int main(void){
    BOOL flag;
    do{
        @autoreleasepool {
            flag=testloop();
        }
    }while(flag);//循环知道输入Q为止
    return 0;
}

首先，从终端读入字符串，如果字符串的开头是C就生成圆形的实例，而如果开头是R则生成长方形的实例，并将其赋值给变量fit，然后，输入图形位置和大小，这时图形的信息就会立刻被打印出来
    """},
  {'title' : '第十一章（2）' , 'message' : """
  2、类簇

2.1类簇的概念

类簇就是定义相同的接口并提供相同功能的一组类的集合，仅公开接口的抽象类也成类簇的公共类，各个具体类的接口由公共类的接口抽象画，并隐藏在簇的内部买这些具体类不能被直接使用，一般会作为公共类的子类来实现，所以有时也称他们为私有子类
实际编写代码是，公共类和普通类按照同样的方法使用，但是实际上被生成并存在在内存上的实例是隐藏在类簇中的某个类的实例，因为可以正确执行，所以程序几乎意识不到这点差异
实现某个类的方法并不是一成不变的，适用于某种情况的最后的方式，也许在其他情况下就意味着高成本，类簇有一个机制，可以从多个已存在的类中挑选出最合适当前场景的类并且自动启用，具体来说就是，根据所使用的是初始化方法、便利构造器还是类名开头的临时对象生成方法，来决定如何实现。
字符串类NSString就是提供给用户使用的类簇，在程序运行的时候，会产生和公共类NSString同样的行为，另外，基于实现上的原因或运行效率方法的考虑，有时也会有更合适的其他类的实例来表示字符串
例如，在C语言字符串和NSString字符串对象之间进行转换，这种操作在程序中是很常见的，这里假设有一个私有字符串类，名为NSSimpleCString 它能够用最接近C语言字符串的形式来表示数据，这样一来，通过使用NSSimpleCString就可以将C语言字符串转换成NSString字符串而当该字符串又必须转换为C语言字符串是，这种处理方式也可以保证快速方便地转换，再来关注一下表示文件路径的字符串，考虑到可能需要进行抽取文件扩展名、目录名等操作，为了能便利地操作组成路径的各要素和扩展名，有时也需要一个适合的私有字符串类，若实现准备好几种这样的字符串，虽然他们只能存储一种数据并时刻需要做各种变换，但应该能提高执行效率

表11-1中列举了Foundation框架提供的一些重要的类簇，除了NSString之外，Foundation框架还有很多NSArray、NSDictionary等其他基本的类，虽然在灿开稳定中，没有关于类簇的描述，但是像类簇（由初始化方法来产生的私有子类的对象）这样的类也是存在的

2.2测试程序
基于测试目的，我们编写了如下的程序，通过用多种方法产生NSString字符串，来查看一下实际运行时究竟使用了哪个类
这仅仅是一个测试程序，实际程序中并不要求知道类簇中具体使用了哪个类，而且也不应该编写这种实现的程序

代码清单11-8 查看类簇中的类

#import <Foundation/Foundation.h>
#import <stdio.h>

static void printClass(NSString *obj){
    printf("Class=%s , \tMember=%s ,\tKind=%s\n",[NSStringFromClass([obj class]) UTF8String],[obj isMemberOfClass:[NSString class]] ? "YES" : "NO",[obj isKindOfClass:[NSString class]]? "YES" : "NO");
}
int main(void){
    NSString *ss =@"static string";
    @autoreleasepool {
        printClass(ss);
        printClass([ss stringByAppendingString:@"(^-^)"]);
        printClass([NSString stringWithUTF8String:"(- -)"]);
        printClass(NSHomeDirectory());
    }
    return 0;
    
}
函数printClass（）会打印输出如下信息：参数NSString字符串实例所属的类名，是否为NSString类的实例，是否为NSString子类的实例，在这里，函数NSStringFromClass（）的作用是返回类名，函数NSHomeDirectory（）的作用是返回执行程序的用户根目录

运行结果：

Mac os X 系统版本不同的情况下会产生不同的结果，即使在程序看来是同样的NSString但实际上内部可能使用了不同的类，另外，还需要注意，方法isMemberOfClass：的执行结果并不是NSString的实例

2.3编程中的注意事项
ObjectiveC中没有专门构成类簇的语法，一般情况下，公共类默认为抽象类，而具体的类则是作为i 公告类的私有子类来实现的，
使用类簇时，不用在意和普通类的差别，但要注意以下2点：

（1、查看实例所属类时
	对类簇来说，所有实例都是私有子类的实例，因此，从类簇的测试程序中俄我们可以看出，方法isMEmberOfClass：即使是将公共类作为输入参数，也很难知道结果	
	当实例所属类的处理策略被改变时，可以使用方法isKindOfClass：判断是否为子类实例，使用方法respondsToSelector：判断是否为特定方法，这些方法都十分有效
（2、生成子类时
	很多情况下，公共类作为抽象类被实现时，各个方法是在私有子类中具体实现的，因此即便生成类直接继承公共类的子类，也不能立即产生用户想要的功能
	在类簇中添加新功能时，请参考11.3节的介绍

3、生成类簇的子类

类簇使多种类别实现抽象画，在公共类的外部只有类簇时可见的，虽然也可以使用类簇本身，但此时使用类簇中类别的子类时有些麻烦
下面说明一下如何产生基于扩展或改变类簇功能的类，因此类簇目前时作为Foundation框架的基本类来实现的，所以一般情况下，没有必要生成子类

3.1使用范畴

虽然范畴不是用来生成子类的，但是在10.2节中提到过，添加新的范畴可以扩展公共类的功能，也可以实现像实例变量那样使用关联引用的功能
图11-3是在NSString中添加新功能的概念图，因为公共类NSString中添加的范畴也会被类簇中隐藏的子类所继承，所以类簇中所有的类都可以使用新添加的功能


3.2基本方法的重定义

我们根据具体的数据结构和算法定义各种各样的类簇，类簇包括一小部分基本方法，其他方法都是在基本方法的基础上实现的，基本方法在子类中实现，而其他方法在公共类中实现，每个子类中不同的实现细节都隐藏在基本方法中，也就是说，即使在类簇内部，也实现了过程抽象化和信息隐藏
因此，定义私有数据结构及对其访问的基本方法是为类簇生成新的子类的最好方式

在各个类簇中，哪些包含有基本方法，附录中都有详述，除基本方法之外，对那些希望独立实现的方法也做了相关的解释说明。
表11-2归纳类一些主要类簇的公共类的基本方法，例如NSString的基本方法是length和characterAtIndex： NSString的子类NSMutableString的基本方法是replaceCharactersInRange：withString：

下面具体说明类簇的子类的实现方法
（1、确定私有数据结构
	确定作为 实例变量的数据结构，作为超类的类簇不能使用所有的数据结构
（2、定义初始化方法
	定义inti…这样的初始化方法，不能继承和使用init之外的超类的初始化方法，只要没有私有数据结构，就可以使用init，所以没有必要定义初始化方法
（3、定义便利构造器
	必要的话，以数据类型名作为前缀，定义生成临时对象的类方法，不能继承及使用超类的同样的方法
（4、定义基本方法
	定义自己的基本方法
（5、定义其他方法
	通过定义基本方法，公共类声明的方法可以暂且执行，但是利用生成数据结构的特征也许能够产生更加高效的方法，而且可以重写这样的方法，如果已经在子类上单独扩展了功能，那么只要定义相应的方法就可以

3.3生成字符串的子类

下面尝试生成一个简单的实例程序，定义一个NSString的子类BitPattern，他的取值对应整数范围0-255由表示8比特的0、1字符组成，为了获得更好的测试效果，我们只定义基本方法length和characterAtIndex：

代码清单11-9 类BitPattern的结构部分

BitPattern.h

#import <Foundation/NSString.h>
@interface BitPattern : NSString{
    unsigned char value;
}
-(id)initWithChar:(char)val;//指定初始化方法
-(NSUInteger)length;
-(unichar)characterAtIndex:(NSUInteger)index;
@end

代码清单11-10 类BitPattern的实现部分

BitPattern.m

#import "BitPattern.h"

@implementation BitPattern

-(id)initWithChar:(char)val{
    if ((self = [super init]) !=nil)
        value = val;
    return self;
}
-(NSUInteger)length{
    return 8;
}
-(unichar)characterAtIndex:(NSUInteger)index{
    return (value &(0x80 >> index))? '1':'0';
}
@end

代码清单11-11 类BItPattern的测试程序

#import <Foundation/Foundation.h>
#import <stdio.h>
#import "BitPattern.h"

int main(int argc,char *argv[]){ //使用ARC
    NSString *bits,*tmp;
    @autoreleasepool {
        bits = [[BitPattern alloc] initWithChar :argv[1][0]];
        printf("Bit Pattern=%s\n",[bits UTF8String]);
        tmp = [@"Bit Pattern = "stringByAppendingString: bits];
        printf("%s\n",[tmp UTF8String]);
    }
    return 0;
}

    """},
  {'title' : '第十二章（1）' , 'message' : """
 1、协议的概念

1.1什么是协议

大多数情况下，对象的主要作用就是表示所处理的消息的类型，而表示对象的作用和行为的方式的集合就称为协议
协议这个称号常用于表示互联网的通信协议，OBjectiveC中的协议最初就是从各个对象之间的通信协议中抽象出来的一种语言称谓，而现在作为广义的概念来使用了，Java中的接口这一概念也吸收了ObjectiveC中的协议概念
这么我们拿显示生活中例子来说明协议的概念，我们都知道CD播放器，MD播放器，数字音频播放器，这些产品都提供了播放、停止、跳过等公告功能，数字音频播放器虽然出现比较晚，但由于他采用了同样的操作方法，所以即使是初次接触的用户也很容易上手，也就是说，CD播放器、MD播放器等的公共功能也适用于数字音频播放器
￼
播放、停止、跳过等公共功能就是我们所说的协议，只要与这些操作方法相对应，也就是说只要提供了公共协议，无论使用什么样的存储媒体，都可以播放或停止播放音乐，而对协议来说，每个播放器也可以独立实现各自的功能

1.2对象的协议

在对象模型化的软件世界里，不同的对象也可能包含相同的方法集合，但通常情况下，这些对象之间并不是继承关系
将多个对象作为元素保存在队列中，并执行添加、删除、升序排序等操作，这就是我们所说的集合对象、集合对象只要有必要的功能即可，至于其内部是如何实现的，这对使用者来说则是非透明的
在图12-2中，数组、线性表、二分查找数就是这样的集合对象，这些类之间并没继承关系中的哪个类，都可以使用该协议进行编程
￼
在继承中，超类的实现直接影响着子类，具体来说，定义的实例变量和方法都会被子类自动继承下来，但这样有时候也有问题。例如，在之前描述的3个类的例子中，由于实现方法是完全不同的，因此无论是继承实例变量还是方法都没有意义
ObjectiveC中的协议仅仅是声明方法的集合体，实例方法则由各个类自行完成，因此，使用协议的各个类之间是否有继承关系都无关紧要，重要的是如何实现这些方法
使用协议的情况下，如果类实现了该协议声明的所有方法，我们就说类遵循该协议，而他的子类实例因为继承关系也拥有了这些协议方法，当类适用于各个协议时，他的实例也适用于这个协议
通过目前为止的说明我们已经了解到，当声明使用类时，因为子类实例也是父类的对象，所以子类实例也能执行父类的操作，协议也同样，使用协议名可以声明一种类型，该类型描述了适用于该协议的对象操作，此时，协议使用的类实例也就可以通过该类对象来执行操作了
在上一章中，我们说明来了抽象类的方法，而协议就可以被理解为只有声明而没有实现方法和实例变量等的抽象类
下面我们来看一些具体的例子
在Foundation框架中，像信号量这样发挥线程间互斥功能的类有NSLock、NSConditionLock、NSRecursiveLock这些统称为锁对象，互相之间无继承关系，但他们都适用于协议NSLocking，该协议仅由lock和unlock方法构成，类似于信号量的P操作和V操作
在编程时，为了使访问公共变量的程序能够使用任意类型的锁，相对于使用特定的类型名，使用NSLocking协议适用的类集合对象来作为类型声明效果会更好

￼

2、ObjectiveC中协议的声明

2.1协议的声明

协议采用如下方式声明
语法：协议的声明
@protocol 协议名
声明方法；
…
@end

协议名使用和C语言相同的语法规范，其命名习惯通常与类名相同，即首字母大写其他字母小写，此外，协议名也可以与已有的类同名
方法的声明也可以使用属性声明
例如，上一节所列举的NSLocking协议就使用了如下定义

@protocol NSLocking
-(void)lock;
-(void)unlock;
@end

协议通常被作为头文件书序，并在类的声明之前导入

2.2协议的采用

当声明的类中实现了某个协议的方法时，接口部分使用如下记述，和普通接口的书写不同的是，超类名字后面要用<>将协议名括起来，这点需要注意
语法：协议的采用

@interface 类名：超类名<协议名>
{
	声明接口变量；
	…
}
声明方法；
…
@end

这样声明时，协议中的方法就被作为了类声明的一部分，因此，在类的接口声明汇总，就无须在声明这些方法类，与接口中声明的方法一样，协议中的方法在实现文件中也必须要实现，但在超类中已实现的方法就不用再重新实现了
像这样，类的接口声明指定了某个协议的情况，我们称为类采用了该协议，采用协议的类及其子类也就成为了该协议适用的类，而子类也可以同时使用别的协议
例如，采用协议NSLocking的类NSLock的接口如下所示（省略了一部分方法）
@interface NSLock : NSObject <NSLocking>{
@private
	void *_priv;
}
-(BOOL)tryLock;
-(BOOL)lockBeforeDate:(NSDate *)limit;
@end

一个类中可以同时采用多个协议，这时在接口部分的<>括号内，将多个协议名用逗号分隔即可，例如，类A采用了协议S和协议T，按照如下方式书写

@interface A：NSObject <S,T>
…
@end

现在，即使多个协议中重复包含同一个方法的声明也没有任何问题，例如，协议S和协议T中都包含了方法copy：，只要在实现文件中实现copy：方法，也就是实现了协议S中的copy：方法和协议T中的copy：方法

但是，选择器相同而函数参数的返回值的类型不一样，即签名不同的方法在协议中重复声明时就会产生问题，一个类内不能声明包含同一个选择器的另一个方法，也不能定义多个这样的协议
而当协议中的方法在某个范畴中实现时，就可以在该范畴中声明采用协议，指定方法如下
语法：范畴中协议的采用

@interface 类名（范畴名）<协议名>
声明方法;
…
@end

通过此方法还可以在已知类中添加协议的方法实现

2.3协议的继承

在某个协议中，可以追加另一组方法来产生新的协议，这称为协议的继承，声明方法如下所示
语法：协议的继承

@protocol 协议名1<协议名2>
声明方法；
…
@end

这样声明的协议包含了继承的协议中的一组方法，以及新增的一组方法，而且协议还可以有多个继承源，增加多个继承源时在<>内将多个协议名用逗号分隔即可

2.4指定协议的类型声明

我们可以声明某个对象适用于某个协议，例如，当我们想要声明变量obj适用于协议S时，就可以采用如下方式定义

id<S>obj;

对象也可以时临时参数，下面的例子就表明临时参数elem适用于协议mag
-(void)addElement:(id <mag>)elem;

在声明指定协议的类型时，编译器会对类型进行静态检查，但需要注意的是，在运行时，并不会对类型进行动态检查
类是否适用于协议，与每个方法是否得到了实现无关，而是根据在接口文件中是否声明了采用协议来判断，也就是说，在类的实现部分，即便实现了某个协议的所有方法，只要在接口文件中没有声明采用协议，就不能认为这个类时协议适用的
不仅是id类型，具体的类名和范畴的组合也可以被当作类型来使用，如下例所示：

-(void)setAlternativeView:(NSView <Clickable> *)aView;

在此例中，参数aView不仅是类NSView的实例，还适用范畴或继承，同时还是协议Clickable适用的对象，此例中静态说明类这些特性
如果一个对象适用了协议，那么在指定该对象的类时，类对象只要能适用于指定的协议就行，而不用管他是什么类的对象，这样就可以编写出不依赖于具体的类的实现的、高灵活性的代码
像这样，代码中只关注协议和抽象类，而没有具体类名的对象称为匿名对象
系统框架提供的协议中，很多都继承了协议NSObjcet，协议NSObject是基类NSObject的部分接口，规定了对象的基本行为，如上所述，像id<协议>这样的类型定义虽然很常见，但如果协议继承了NSObject就能够向编译器告知对象的基本功能

2.5协议的前置声明

如果只在头文件的类型声明中使用协议名，可以指定前向引用，这与4.3节中说明的类的前置声明是一样的，但是在定义文件中吗，为了让编译器能够检查类型，就必须引用协议的定义，例如，声明Clickable这个名字为协议，可以采用如下方式
@protocol Clickable;

2.6协议适用性检查

在运行时可以动态地检查对象是否适用于某个协议，因此在程序中就有必要把协议当成数据来看待
使用编译器命令符@protocol（）后，就可以获得表示指定协议数据的指针 @protocol（）参数中包含类型（Protocol *）可以代入变量

+(BOOL)conformsToProtocol:(Protocol *)aProtocol
	aProtocol参数指定的协议和类适用时，返回YES
-(BOOL)conformsToProtocol:(Protocol *)aProtocol
	接收器和参数aProtocol指定的协议适用时，返回YES
例如，要检查对象obj是否适用于NSLocking，可以用如下方式：
if([obj conformsToProtocol:@protocol(NSLocking)])…


2.7必选功能和可选功能

到目前为止，采用协议的类都必须实现协议中列举的所有方法，而ObjectiveC 2.0中规定了一项新的功能：协议列举的方法中，分为必须实现的方法和可选择实现的方法，也就是说可以指定不用实现的方法
协议中声明的方法群虽然和协议关系紧密，但也存在一些可有可无的方法，这种情况下，我们可以将这些方法指定为可选，这样一来，根据协议的记述，实现方法时就能统一接口
在协议声明中，编译器命令符@protocol和@required可用来设定其后出现的方法时可选的还是必选的，而@optional和@required命令符在声明中以什么样的顺序出现以及出现多少次都可以，如果声明中没有特殊指定，那么就默认为@required，表示方法是必选的
下面我们以闹钟为例进行说明，在闹钟协议中，当前时间的设定、脑涨的ON/OFF设定以及起床时刻的设定都是必选的；而贪睡功能（停下来几分钟后再响铃的功能）的ON/OFF设定、闹钟铃声临时停止的设定则是可选的、下面的实例代码写的有点复杂，通常情况下是应该更简明一些的

@protocol Alarm
-(void)setCurrentTime:(NSDate *)date;
@protocol (assign)BOOL alarm;

@optional
@property (assign)BOOL snooze;
-(void)pauseAlarm:(id)sender;

@required
-(void)setTimeAtHour:(int)h minute:(int)m;
@end

由于采用协议的类可以不实现可选方法，因此有时就需要动态地检查方法是否可用，在该例中，闹钟对象不一定具有贪睡功能，而如果有的话，由于方法的接口是明确的，因此检查该方法是否可用也很容易

2.8使用协议的程序示例

这里，我们首先来看一个协议RealNumber，他的功能是取得实数值

代码清单12-1 协议RealNumber

RealNumber.h

@protocol RealNumber
-(double)realValue;
@end

这时一个很简单的例子，下面我们在类NSMutableArray中添加范畴，保存协议的对象并添加排序操作

代码清单12-2 category RealArray的接口部分

RealArray.h

#import <Foundation/NSArray.h>
#import "RealNumber.h"

@interface NSMutableArray (RealArray)
-(void)addRealNumber:(id <RealNumber>)number;
-(void)sort;
@end
 代码清单12-3 category RealArray的实现部分

RealArray.m

#import "RealArray.h"
@implementation NSMutableArray (RealArray)
-(void)addRealNumber:(id <RealNumber>)number{
    [self addObject:number];
}

static NSInteger compareReal (id <RealNumber> a, id <RealNumber> b,void *_){
    double v=[a realValue]-[b realValue];
    if(v>0.0)
        return NSOrderedDescending;
    if(v<0.0)
        return NSOrderedAscending;
    return NSOrderedSame;
}
-(void)sort{
    [self sortUsingFunction:compareReal context:0];
}
@end

这里使用了9.4节中提到的sortUsingFunction：context：方法，比较各个元素的功能由局部函数compareReal（）完成，函数返回值为NSComparisonResult枚举类型
接下来定义使用协议的类，RealNumber首先使用5.3节中编写的分数计数器来尝试扩展这个分数类的功能，中间，省略的部分和代码相同

Fraction.h 与 Fraction.m 略

字符串NSString也适用于协议RealNumber这里定义协议适用的范畴并扩展其功能

代码清单12-6 类NSString的范畴的接口部分

NSStringReal.h

#import <Foundation/NSString.h>
#import "RealNumber.h"

@interface NSString (Real)<RealNumber>
@end

代码清单12-7 类NSString的范畴的实现部分

NSString.m

#import "NSStringReal.h"

@implementation NSString (Real)

-(double)realValue{
    return [self doubleValue];
}

@end

同样，如果添加范畴。类NSNumber等也能够适用于协议RealNumber
最后，在main（）函数中确认上述操作

代码清单12-8 用来测试协议RealNumber的主函数

#import <Foundation/Foundation.h>
#import <stdio.h>
#import "RealNumber.h"
#import "Fraction.h"
#import "NSStringReal.h"
#import "RealArray.h"

int main(void){
    @autoreleasepool {
        id array = [NSMutableArray array];
        [array addRealNumber:@"1.3"];
        [array addRealNumber:@"0.35"];
        [array addRealNumber:@"0.2"];
        [array addRealNumber:[Fraction fractionWithNumerator:1 denominatior:3]];
        [array addRealNumber:[Fraction fractionWithNumerator:3 denominatior:8]];
        [array addRealNumber:[Fraction fractionWithNumerator:3 denominatior:2]];
        [array sort];
        printf("%s\n",[[array description] UTF8String]);
    }
    return 0;
}

    """},
  {'title' : '第十二章（2）' , 'message' : """
 3、非正式协议

3.1什么是非正式协议

我们可以将一组方法声明为NSObject的范畴，这称为非正式协议，或者称为简化协议，为了和非正式协议相区别，有时也将上一章节之前讲述的协议称为正式协议，虽然都称为协议，但是在功能上缺失不同的
非正式协议知识作为if 按丑进行声明，而并没有实现，实际上，范畴中声明的方法即使没有实现，也可以编译或执行，但是在发送消息时会出现运行时错误
在类中，如果要使用一组非正式协议声明的方法，就需要在接口文件中重新声明这组方法（并不是必须）并在实现文件中实现，但并不要求实现范畴中的所有方法
由于非正式协议知识基类的范畴，因此，和使用正式协议时一样，既不能在编译时做类型检查，也不能在运行时检查协议是否适用，如果要检查非正式协议中的方法是否已实现，只能对每个方法调用respondsToSelctor：
下面我们来总结一下非正式协议的相关概念：

- [ ] 非正式协议被声明为NSObject类的范畴
- [ ] 非正式协议中声明的方法不一定要实现
- [ ] 编译时，不能检查类对非正式协议的适用性
- [ ] 运行时，不能检查类对非正式协议的适用性，只能确认是否实现了每个方法

3.2非正式协议的用途

非正式协议有这么多问题，到底要如何使用它？在Cocoa中，从系统方调用用户编程方的对象来互发消息时，经常会使用非正式协议
例如：Application框架的类NSColorPanel中定义了非正式协议（AppKit/NSColorPanel.h）

@interface NSObject (NSColorPanelResponderMethod)
-(void)changeColor:(id)sender;
@end

使用调色板改变颜色时，界面上选择的对象，如果实现了该方法，那么无论继承关系如何，都可以在接收到消息后执行改变颜色的处理，而如果没有实现该方法，则不会接收到这个消息
此外，ios的UIKit框架中定义了非正式协议UIAccessibility（UIKit/UIAccessibility.h）

@interface NSObject (UIAccessibility) //一部省略
@property(nonatomic) BOOL isAccessibilityElement;
@property(nonatomic,copy) NSString *accessibilityLabel;
@property(nonatomic,copy) NSString *accessibilityHint;
@property(nonatomic,copy) NSString *accessibilityValue;
@property(nonatomic) UIAccessibilityTraits accessibilityTraits;
@property(nonatomic) CGRect accessibilityFrame;
@property(nonatomic,retain) NSString *accessibilityLanguage;
@end

可访问功能是指视觉，听觉有缺陷的用户也可以方便地使用设备的功能，例如功能VoiceOver就可以读出所触摸的按键等的种类，界面上设置的UIKit组件已经采用了上述非正式协议，而其他节目元素，只要实现了上述特性，也都能使用可访问功能
由于非正式协议的方法是作为基类的方法定义的，因此，即使在程序中写明向任何一个实例发送消息，在编程时也不会出现警告
例如box对象，即使我们不知道他是否实现了上述非正式协议NSColorPanelResponderMethod的方法，也可以按照如下方法使用方法respondsToSelector来编程，值的注意的是，即使声明了box的类型，编译时if代码中也不会出现如下警告

if([box respondsToSelector:@selector(changeColor:)])
	[box changeColor:self];

非正式协议与实现范畴中的方法时的情况有所不同，他在NSObject中并没有添加什么实质内容，源文件中导入的范畴声明，实际上是方法的原型声明
像上例这样，在并不需要整个方法群的情况下，一般都会使用非正式协议来声明，现在ObjecitveC2.0中也就可以使用带可选标记的协议，而各部分代码中使用的协议的编程风格也随处可见

专栏：使用宏（macro）来区分系统版本的差异

如果留心观察框架中提供的类头文件，就会发现很多下面这样的预处理行

#id MAC_OS_X_VERSION_MAX_ALLOWED >=MAC_OS_X_VERSION_10_2

宏MAC_OS_X_VERSION_MAX_ALLOWED表示当前使用的开发环境的版本，同样，还有宏MAC_OS_X_VERSION_MIN_REQUIRED他用来说明使用该SDK开发的应用在运行时对系统版本的最低要求。
此外，还有像MAC_OS_X_VERSION_10_2 这样表示系统版本的宏，通过使用这些宏，可以根据心就等不同版本来编写合适的代码，但是，在旧版本的系统中不能定义新的宏，例如，在Mac os x10.2环境中就没有定义宏MAC_OS_X_VERSION_10_4于是，为了使旧版本也可以进行编译，就必须按照如下方式，使用Mac os x10.1对应1010，10.2对应1020，10.3对应1030

#if MAC_OS_X_VERSION_MAX_ALLOWED >=1040

有时，在属性方法等声明的末尾还会添加如下的宏

（1、AVALIABLE_MAC_OS_X_VERSION_10_4_AND_LATER
（2、DEPRECATED_IN_MAC_OS_X_VERSION_10_4_AND_LATER
（3、NS_AVAILABLE(10_7,5_0)
（4、NS_DEPRECATED(10_0,10_6,2_0,4_0)
（5、NS_CLASS_AVAILABLE(10_7,5_0)

（1）是10.4及其后版本使用的新功能。
（2）与（1）相反，表示不推荐使用旧功能
（3）与（1）相同，表示在Mac OS X10.7之后的版本或者iOS 5.0之后的版本中可用
（4）更复杂，表示在Mac OS X10.0以及iOS2.0之后的版本中可用使用，而分别在10.6、4.0中不推荐使用
这些与上述宏的MAC_OS_X_VERSION_MAX_ALLOWED及宏MAC_OS_X_MIN_REQUIRED的定义相对应，可以用来替换指定函数属性的注释，而如果使用了非法函数或非推荐的方法，在源代码的使用位置处就会产生编译错误或警告
（5）表示类是否有效，对应添加给该宏的类，程序内采用如下方式判断其是否有效
if([NewClass class]){/*只有NewClass可以使用才能执行*/}

    """},
  {'title' : '第十三章（1）' , 'message' : """
1、对象的复制

1.1浅复制和深复制
用与一个实例对象相同的内容，生成一个新对象，这个过程一般称为复制，其中，只复制对象的指针称为浅复制，而复制具有新的内存空间的对象则称为深复制，浅复制和深复制有时也称为浅拷贝和深拷贝

从图13-1可以看出来，现在变量A指向了一个对象，而这个对象的实例变量又指向了另一个对象，把变量A复制到变量B时，首先，我们可以考虑只复制对象的指针这种方法，其次，也可以将变量A指向的对象原样复制一份，并通过指针来共享这个对象的复制体中的实例变量，最后，复制对象中的实例变量，还可以递归地进行对象复制C
￼
（a）是将对象代入到变量中，（b）是典型的浅复制，（c）是深复制
用指针功效某一对象的时候，同时也会共享哪个对象的操作结果，生成副本时，对源文件和副本的操作都是独立的，这一点通过（a）和（c）这两种情况下对X及X‘这些对象进行变更操作就会很清楚，如果想共享变更操作的结果，就应该选择（a）代入或（b）浅复制，而如果希望各自独立管理的话，那就用（c）深复制
像这样，共享指针的方法和对象的复制方法差异确实很大，因此，在实际编程中，就需要我们根据目标需求来区分使用，例如，像只复制一部分实例变量，其他则通过指针来访问这样综合使用浅复制和深复制的方式有时候也是比较合适的方法

1.2区域

Cocoa中一直把动态分配的内存管理称为区域，新运行时系统中不使用区域，而之后提到的copyWithZone：方法中的参数也知识格式类似，这里，我们先简单地介绍一下区域的概念
动态分配内存的堆区域使用了地址空间中很大一片区域，一方面，从空间的局部性原理和虚拟内存管理的角度来看，倾向于同时使用的有关联的数据群，如果能被有效配置在内存中距离较近的位置，就可以实现高效的内存访问
于是，我们可以在堆内设定多个区块，使关联的数据和对象可从特定的内存区域中分配并保存，这个区域就叫作区域
因为区域是为此目的服务的，所以他在运行效率上并没有多大贡献，现在较新的运行时环境中都没有用到它，但实例的生成和复制的机制中还保留着区域功能，
通常，生成实例对象要使用类方法alloc，而NSObject中也有一个类方法可以指定区域来生成实例
+(id)allocWithZone:(NSZone *)zone;
	NSZone结构体是专门用于表达区域的数据结构，现代运行时中，因为参数zone会被忽略，所以一般设置为NULL，但方法的功能和alloc一样

1.3复制方法的定义

NSObject中有copy方法，它能够通过复制接收器来生成新实例，但是，实际的复制操作并不是copy来完成的，而是由实例方法copyWithZone：来完成的，发送copy消息给实例对象后，指定参数为NULL，这样就可以调用自身的copyWithZone：该方法就是这样生成新的实例
鉴于这样的复制方法，为了使实例能够复制，光实现copy方法还不行，还需要定义方法copyWithZOne：方法copyWithZone：返回复制生成的新对象，如果执行失败则返回nil值，copy的返回值也是同样的
由于方法copyWithZone：是在协议NSCopying中声明的，因此就要在类中实现采用该协议的方法，如果该方法适用于协议NSCopying，那么方法在copy的声明属性指定为可选等情况下，编译器就会被告知可以进行复制

@protocol NSCopying
-(id)copyWithZone:(NSZone *)zone;
@end

NSCopying协议在头文件Foundation/NSObject.h中定义。但是NSObject自己并不采用该协议，方法copy只使用NSObject进行简单的定义
方法copyWithZone：的定义方法可以总结如下：
（1、超类如果没有实现方法copyWithZone：可使用alloc和init来生成新实例，并将该实例变量谨慎地复制并代入
（2、超类如果实现了方法copyWithZone：可直接调用该方法来生成实例，再将子类中添加的实例变量根据需要复制并代入
（3、实例变量中的共享对象没有必要复制，采用手动引用计数管理时需要retain
（4、采用引用计数管理时，方法copyWithZone：及copy的调用者就是对象的所有者，因此该返回值不适用于autoreleaase
（5、对常数对象的类而言，定义方法copyWIthZone：不一定要生成新对象，采用手动引用计数管理方式的情况下，通过self适用retain来返回结果，使用ARC和垃圾回收器时，只返回self
此外还有另一个函数NSCopyObject（）他会将实例对象当作二进制序列完整地复制下来并生成另一个对象，但该函数容易出错，比较危险，所以并不推荐使用，特别在使用ARC的情况下绝对要禁止使用该函数

1.4复制方法的例子
接下来介绍几个复制方法的例子
假设未来实现图像的管理而定义了ImageCell类，该名字中包含了字符串image，节目中能显示的图像被保存在NSImage实例中，在实例变量中也有该名字，NSImage是Application框架中的类，而且，表示该图像在窗口中的坐标的实例变量的类型为NSPoint，NSPoint内的成员x和y，分别表示坐标位置
@interface ImageCell : NSObject <NSCopying>{
	NSMutableString *name;
	NSImage *image;
	NSPoint position;
}
…
@end

该类所表示的图像，就像扑克的图案一样，其大小是固定的，由于即使被复制，图片也会被共享，所以在复制ImageCell类实例时，就没有必要再复制NSImage的实例了，只要共享指针就可以了，大家查看一下附录就会发现NSMutableString紧挨着协议NSCopying这种情况下，可按如下方式定义copyWithZone：方法
-(id)copyWithZone:(NSZone *)zone{
	ImageCell *tmpcopy =[[[self class] allocWithZone:zone] init];
	//重要 使用[self class]而非类名
	if(tmpcopy){
		tmpcopy->name=[name copyWithZone:zone];
		tmpcopy->image=[image retian];//使用手动引用计数管了
		tmpcopy->position=position;
	}
	return tmpcopy;
}

这里即使不使用copyWithZone：的参数zone而赋值为NULL也没有关系，此外，还可以使用alloc和copy来代替allocWithZone：和copyWithZone
使用手动引用计数管理时，image发送的retain消息必须被保存，虽然这里使用了->来直接赋值，但对属性赋值来说，如果有其他合适的初始化方法或访问器，也是应该考虑采用的
接下来，让我们尝试一下继承ImageCell来定义新类，就像象棋中车这个棋子一样，这里在类DirectedImageCell的定义中增加了图像的方法属性，接口部分如下所示，enum direction是列举方向的枚举类型，由于超类ImageCell适用于协议NSCopying，因此DIrectedimageCell中可以不指定协议

@interface DirectedImageCell : ImageCell{
	enum directions direction;
}
…
@end

在DirectedImageCell中定义新的方法copyWithZone：

-(id)copyWithZone:(NSZOne *)zone{
	DirectedImageCell *tmpcopy =[super copyWithZone:zone];
	if(tmpcopy)
		tmpcopy->direction =direction;
	return tmpcopy;
}

这里调用了超类的copyWithZone：方法，但结果返回的实例的类并不是ImageCell类，而是DirectedImageCell类，这点需要注意，定义超类方法copyWithZone：时不直接使用类名，而是将方法allocWithZone：适用于[self class]	当从子类DirectedImageCell中调用这个方法时，因为self为DirectedImageCell的实例，所以使用[self class]返回的类就是DirectedImageCell类
那么，在定义类ImageCell的方法copyWithZone：时，将变量tmpcopy声明为类型ImageCell *会不会有问题呢？即使实际的对象时DirectedImageCell的实例，因为实现中包含的ImageCell初始化类，所以也没有问题，此外，数据类型如果表示为id，->运算符不可以使用
考虑到这个原因，不仅限于copyWithZone：方法，只要用到继承，我们都不建议写方法内类自身固定的类名

1.5实现可变复制

通过阅读第9章我们已经了解到，从常熟对象生成可变对象可以使用MutableCopy方法
-(id)mutableCopy
	然而，该方法使用NSObject简单生成，实际上真正生成实例方法的事mutableCopyWithZone：
-(id)mutableCopyWithZone:(NSZOne *)zone
	该方法在只包含它的协议NSMutableCopying中声明，协议本身定义在头文件Foundation/NSObject.h中，NSObject本身不采用该协议，在使用方法mutableCopy时，如果将zone参数指定为NULL，则实际调用mutableCopyWithZone：方法这种结构与方法copy和copyWithZone：如出一辙
如果自己需要定义一个包含了常熟对象和可变对象的类，那么使用mutableCopyWithZone：方法会更加方便一些
    """},
  {'title' : '第十三章（2）' , 'message' : """
2、归档

2.1对象的归档

有时我们会有这样的需求，即将程序中使用的多个对象及其属性值，以及他们的互相关系保存到文件中，或者发送给另外的进程，为了实现此功能，Foundation框架中，可以吧互相关联的多个对象归档为二进制文件，而且还能将对象的关系从二进制文件中还原出来，像这样，将对象打包成二进制文件就称为归档
例如，将Xcode开发环境中构造的GUI对象的关系保存到名为nib的文件中，该文件中就包括了各对象的属性值及对象之间的关系，这样就可以在开发环境中再次打开该文件进行编辑，或者在运行时使其作为实际的对象运行
此外，在制作包含复制和粘贴、拖拽和释放等功能的应用程序时，为了保存操作对象的信息，有时也会利用归档，之后讨论的XML和属性吧，其中的一部分也会常使用包含归档数据的方法
但是，并不是说归档适用于所有的数据。将对象归档保存时，保存方法、还原方法都必须要实现，由于归档与对象具体的结构紧密，因此，当类定义或对象之间的关系改变的时候，归档的方法也必须随之改变，很多情况下，使用XML或属性表等高通用性的格式来保存数据，从程序的效率及稳定性上来说都会更好一点
本章将简要说明Foundation框架的归档功能

2.2Foundation框架的归档功能

将对象存储转换为二进制序列的过程称为归档、打包或编码，逆变换则称为解档，解码或对象还原
Foundation框架中的归档和系统框架是互相独立的，也就是说mPowerPC和Intel都可以利用，在对象包含的实例变量值中，整数及实数这样的基本数据类型，以及指向其他对象的指针等都可以归档，普通指针虽然不能归档，但根据指向的数据类型有时则是可以归档的
一个对象指向其他对象，这种关系称为对象图，沿着对象的指向关系往下走，有时就会再次回到原来的对象，这样的情况称为闭环，Foundation框架可以将对象图归档成书库，其中，作为出发点的对象就可以称为根对象，对象图中即使包含闭环也没有关系
可以使用NSKeyedArchive和NSKeyedUnarchiver完成对象的归档和解档操作，而且他们都是抽象类NSCoder的子类
所有可以归档的对象都必须要适用于协议NSCoding，协议NSCoding在Foundation/NSObject.h中定义，NSObject自身并不采用该协议，NSString、NSDictionary等Foundation框架的主要类都适用协议NSCoding
协议NSCoding按照如下方式声明
@protocol NSCoding

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(void)initWithCoder:(NSCoder *)aDecoder;

@end
￼

2.3归档方法的定义

协议NSCoding中，函数encodeWithCoder：定义了归档自身的方法，下面我们就来看下这个方法的大概过程，参数中会传入NSCoder（具体为NSKeyedArchiver）的实例，该实例称为归档器，NSKeyedArchiver的实例在Foundation/NSKeyedArchiver.h中声明

-(void)encodeWithCoder:(NSCoder *)coder{
	[super encodeWithCoder:coder];//超类需要适用协议NSCoding
	[coder encodeObject:对象 forKey : 关键词字串];//或者使用encodeConditionObject：forKey
	…
	[coder encodeDouble:实数变量 forKey:关键词字串];//有适合多种类型的方法
	…
}

首先，如果超类适用于协议NSCoding，那么super将调用encodeWithCoder堆超类的实例变量进行归档，如果超类像NSObejct一样不适用于协议NSCoding，则不能调用
接下来，类自身会对包含的实例变量归档，在类没有自己的实例变量且超类中定义了方法encodWithConder：的情况下，该方法就不需要再定义了
通过使用NSString字符串作为键值，可以指定归档解档的内容，当某个类实例归档时，他的实例变量必须指定成不同的键值，在单个对象内部，如果超类使用类一个键值，那么子类中就不能使用该键值，键值只需要在同一个类内区分出来即可，不同的类可使用相同的键值
对象的归档使用方法encodeObject：forKey：因为归档器要对第一个参数的对象调用方法encodeWithCoder：进行归档，所以时递归调用，当对象图有闭环时，同一个对象会重复要求归档，而实际上已归档的对象时不用重复归档的
C的数据类型如整数实数等，都分别有相应的归档方法，数组、结构体等有时需要转换为二进制
归档某个对象时并没有必要吧对象指向的所有对象都归档，但图13-3的情况需要注意
￼
图中，将对象B作为根对象进行归档操作时，去掉了实例变量X指向的对象A，即不在归档中包含对象A，但是，如（b）所示，对象B出发经由别的路径指向A，结果对象A也包含在归档中的情况下，从变量x就找不到对象A了，这样在归档还原时就可能出现问题，为解决这个问题，可以在别处使用encodeConditionalObject：forKey：方法，该方法可以确保在不归档的情况下不进行编码

2.4解档方法的定义

未来从归档中还原对象，需要在各类中定义初始化方法，即协议NSCoding的方法initWithCoder：下面将详细解释一下，如何定义该方法，方法参数被传入NSCoder（具体为NSKeyUnarchiver）实例变量，这个对象也称为解档器，NSKeyedUnarchiver的接口在Foundation/NSArchiver.h中定义

-(id)initWithCoder:(NSCoder *)coder{
	self =[super initWithCoder:coder];
	//超类不适用于协议NSCoding时
	//建议使用[super init]
	变量 = [[coder decodeObjectForKey : 键值]	retain];
	…
	变量 = [coder decodeDoubleForKey : 键值];
	…
	return self;
}

只要在编码和解码中指定同样的键值，解码就可以按照任意顺序，即使有不能还原的变量也没有关系
下面我们就将编码和解码方法一并列出

-(void)encodeObject:(id)objv
		       forKey:(NSString *)key
	将字符串作为键值来对参数对象编码
-(void)encodeConditionalObject:(id)objv
					  forKey:(NSString *)key
	在对象图中需要参数objv时将字符串作为键值编码
-(id)decodeObjectForKey:(NSString *)key
	使用指定键值来还原编码对象，需要返回值对象时可以使用retain来保存（仅限于手动引用计数管理方式）

编码解码C数据类型的方法有很多，下面举一个整数编解码方法的例子
-(void)encodeInt:(int)intv
		 forKey:(NSString *)key
	将字符串作为键值对整数参数归档
-(int)decodeIntForKey:(NSString *)key
	将键值为参数字符串的整数解码

2.5归档和解档的初始化方法

NSKeyArchiver的实例，即归档器，可以将对象的编码结果写进数据对象中，NSKeyArchiver的初始化方法如下所示
-(id)initForWritingWithMutableData:(NSMutableData *)data
	将预先生成的NSMutableFata实例作为参数，初始化NSKeyedArchiver实例，参数的数据对象被保存起来，这个数据对象最终生成归档

生成归档器后，接下来就可以使用前述的encode方法对对象或数据进行归档，编码根对象后，对象图全体就会被递归地进行归档
所有归档完成后，最后必须调用finishEncoding方法进行后处理
-(void)finishEncoding

处理完成后，由于归档器初始化时传入的数据对象已经进行了归档，因此就可以将其保存到文件中，或者向其他进程发送消息
解档器NSKeyedUnarchiver的初始化方法如下：
-(id)initForReadingWithData:(NSData *)data
	为了将参数的数据对象从归档中还原，需要初始化接收器，参数data被保存在接收器中

还原归档的对象图和还原一个对象时同样的，都是使用方法decodeObjectForKey：
上面我们说明了归档和解档的实例生成方法，而其实还有一种更简单的方法也可以将归档结果写入到文件中，并进行读取和还原

+(BOOL)archiveRootObject:(id)rootObject
				   toFile:(NSString *)path
	NSKeyedArchiver类中的方法，通过指定根对象将归档结果写入指定路径的文件中，函数处理成功时返回YES
+(id)unarchiveObjectWithFile:(NSString *)path
	NSKeyUnarchiver类中的方法，从指定路径文件中读入归档数据进行解档，返回根对象，方法处理失败时返回nil

3、属性表

3.1属性表概况

属性表是Cocoa环境中用来表示或保存各种信息的标准数据类型，他可以将数组或词典等对象的结构表现为字符串或二进制形式来保存在文件中，或者从中读取出对象的信息
上一节提到的归档，其主要目的是在程序内部保存和还原对象，因此并不适合用来保存与具体的类关联较弱的信息，在保存及共享和程序内部实现关系较弱的抽象数据时，建议使用属性表
属性表有ASCII码，XML、二进制三种格式。在ASCII码格式的属性表中，字符串、数据、数组、字典（NSString、NSData、NSArray、NSDictionary）四个类的组合结构表现为文本格式，而在XML格式的属性表中，除字符串、数据、数组、字典之外，还可以表示包含数值和表示布尔值的NSNumber以及表示日期的NSDate的结构，而二进制格式则是将这样的结构保存成二进制文件、而不是文本
字符串或数值等基本数据使用NSString和NSNumber来表示，表示二进制数据时使用NSData。NSArray和NSDictionary被用来生成对象结构，NSArray和NSDictionary也可以嵌套使用，此外，这些类也可以时表示各种可变对象的子类，在NSDictionary的接口中保存整个属性表时，该字典对象就称为根词典，字典的键值必须为字符串
将属性表保存成文件时，习惯使用文件扩展名“.plit”	可以使用Xcode来编辑这样的扩展名文件
使用属性表来保存各个应用的环境变量值是用户默认的设置

3.2ASCII码格式属性表
ASCII码格式的属性表是从OPENSTEP中继承的，它在苹果的开发文档中被记为“Old-Style ASCII Property Lists”有时也称为文本格式属性表，他的存在主要是未来兼容性，虽然可以从文件中读入，但却不能写出，其缺点是只能使用ASCII码字符，而不能使用NSNumber或NSData，因此在实际程序中一般不使用
但是，作为一种字符串格式，这种属性表可以很容易地取出，看起来也一目了然，同时还可以使用文本编辑器来编辑，因此在Debug或生成小的测试程序时也很有效
通过将方法description适用于生成属性表结构的NSArray和NSDictionary实例，ASCII码属性表就可以获得字符串格式
反过来，从ASCII码属性表的字符串中还原对象结构时，发送方法propertyList到该字符串对象即可

-(id)propertyList(NSString的实例方法)
	从ASCII码属性表的字符串中还原并返回对应的对象结构，返回的结构为常量对象
属性表和类型的对应关系如表13-1所示
￼
属性表内的字符串一般用“”括起来，只有英文数字时引号可以忽略，中文等要通过将Unicode编码到ASCII码范围内来表示

二进制数据需要表示为十六进制并用<>括起来
数组用（）括起来，各元素间用逗号分隔
字典用{}括起来，键通常使用字符串，并与其值用等号链接，各个键值对之间用分号分隔

下面我们来尝试使用ASCII码属性表来表示9.5节中图9-2教师设备的例子，整体使用一个包含3个字典对象的数组，如果含有布尔值就用数值来表示，实际上，数值也是被当作字符串来处理的，可以适当插入空格和换行

{
	{capacity =180;mic =1; projector =(PC,DVD); room = LR501; screen=1;}.
	{capacity =150;mic=1; projector=PC;room =LR401;screen=1;},
	{
		capacity =45;
		min =0;
		note=“Chair with table top”;
		room =LR402;
		screen = 0;
	}
}

3.3XML格式属性表

NSArray或NSDictionary的实例通过使用方法writeToFile：atomically：就可生成XML格式的属性表文件，反之，从文件中读出属性表并复制对象时，可使用方法initWithContentsOfFile：，然而，对象构造只能为常量对象
例如，可以使用Unicode表示的中文
XML格式的属性表中使用的标签如表13-1所示，未来表示字典的键，这里还有用了<key>标签
与之前的例子相同，图9-2（b）的教师设备一例中，这里用XML格式属性表来表示最初的字典对象的内容，可以看出，使用标签可以表示布尔值或数值

<dict>
	<key>capacity</key>
	<integer>180</integer>
	<key>mic</key>
	<true/>
	<key>projector</key>
	<array>
		<string>PC</string>
		<string>DVD</string>
	</array>
	<key>room</key>
	<string>LR501</string>
	<key>screen</key>
	<true/>
</dict>

3.4属性表的变换和检查

转换或检查属性表格式时需要使用类NSPropertyListSerialization
该类实例在Foundation/NSPropertyList.h中定义，方法的参数类型为NSPropertyListFormat如下所示

NSPropertyListOpenStepFormat   ASCII格式
NSPropertyListXMLFormat_v1_0   XML格式
NSPropertyListBinaryFormat_v1_0 二进制格式

+(NSData *)dataWithPropertyList:(id)plist
					    format:(NSPropertyListFormat)format
					   options:(NSPropertyListWriteOptions)opt
					       error:(NSError **)error
	参数plist是表示属性表的对象（字典、数组等）将他转换为format指定的属性表格式（XML或者二进制格式）并返回数据对象，参数opt指定为0，参数error返回出错时的错误信息
+(BOOL)propertyList:(id)plist
       isValidForFormat:(NSPropertyListFormat)format
	检查参数plist的属性表是否符合format指定的转换格式
+(id)propertyListWithData:(NSData *)data
			       options:(NSPropertyListReadOptions)opt
			        format:(NSPropertyListFormat *)format
				   error:(NSError **)error
	从存储着任意一种格式的属性表的数据对象中将对象结构复原出来，参数opt指定为0
	参数format为变量指针，用来返回参数data的属性表格式，如果Format为NULL则不返回结果
	参数error返回出错时的错误信息

关于属性表的详细介绍，请见参考文档“Property List Programming Guide”等
    """},
  {'title' : '第十四章（1）' , 'message' : """
1、什么是块对象

1.1C编译器和GCD

块对象是在Mac OS X 10.6及iOS4.0 平台下可以使用的功能，他不是ObjectiveC而是C语言的功能实现，苹果公司的文档中将其称为块对象或Bolock，在其他编程语言中，他与闭包（closure）功能基本相同，未来和C语言的语法相区别，本书中称之为块对象

如前所述，苹果公司正在使用LLVM的clang作为C语言编译器来改进C/ObjectiveC/C++系的编译处理，快递箱也是这些语言功能的成果之一
从Mac OS X10.6及iOS 4.0起，为了使线程在多核上能更有效的运行，苹果公司新开发了大·中央·调度（GCD，Grand Central Dispath）这样的构造，GCD广泛包含了运行时和框架改进等内容，块对象就是其中一个重要的成员，GCD和多线程的相关内容在第19章中有更详细的介绍。
块对象是苹果公司提出的C语言的新功能，而不是标准功能，但在MacOSX 及iOS中，块对象已经被普遍使用了，因此，面向这些平台的软件开发，离不开块对象的相关知识
下面，我们将首先以C语言为前提，来介绍一下块对象的基本功能和使用方法，然后再在14.3节中，对ObjectiveC的程序中块对象的使用方法和注意事项进行详细说明

1.2块对象的定义

块指针或闭包是什么呢？我们将首先介绍一下其语法，然后再了解实际的使用方法。
块对象的参数列和主题部分的书写方法与普通函数相同，主体中如果有return，就可以定义返回值块
语法：块对象的定义
^(参数列){主体}

这里，从“^”开始到参数列，主体最后的大括号，这一段记述称为块对象的块句法，实际上，块句法并不被用于在内存中分配的块对象，它只是编写代码时的一种表达语句，块对象本身常用于代入到变量后评估，或被作为函数或方法的参数传入等，此时，变量或参数的类型声明和函数指针使用相同的书写方法，只是函数指针声明中使用“*”而块对象使用“^”
例如，可采用如下方式声明函数指针f，实现传入一个int类型的参数，且无返回结果
void (*f)(int)

同样我们也能够生成传入一个int类型的参数，且无返回结果的块对象，假设将其传入变量b，那么变量b即可采用如下方式声明

void (^b)(int);

在变量声明的同时将块对象赋值为变量b的代码如下所示，块对象自身使用printf打印参数的整数值
void(^b)(int) = ^(int i){printf(“%d\n”,i)};

像函数的原型声明一样，这里也可以写临时参数名

void(^b)(int i) = …;

变量b可以像函数一样被调用执行，如代码清单14-1的例子所示，因为是C语言的程序，所以文件的后缀名为.c 虽然编译器也不需要设定特殊的选项，但需要在Mac OS X10.6及之后的版本中执行，程序执行后，会一次输入5和20

代码清单14-1 将块对象代入变量的例子

block1.c

#include "block.h"
#include <stdio.h>

int main(void){
    int k=10;
    void (^b)(int) =^(int i){printf("%d\n",i);};
    
    b(5);
    b(k*2);
    return 0;
}

可见，代码执行的结果，就是定义了像函数一样可以返回值的块对象
在代码清单14-2的main函数中，首先作为一个块对象返回输入参数的2倍，并用printf打印返回值，然后，将该块对象传递给函数func，函数func会将其解释为参数block，并将实际参数10传入该块对象，然后打印值
main函数还直接以写块句法的方式来表示传递给func函数的实参，该块对象实现的是累加1到参数整数之间的数值，然后返回累加值，由于块句法的主体可以采用和普通函数相同的书写方式，因此也可以使用局部变量，执行程序汇后，结果就会一次打印出8，20，55

代码清单14-2 返回值的块对象例子

block2.c

#include "block2.h"

void func(int (^block)(int)){ //block为函数的临时参数
    int v=block(10); //打印传递的块对象参数
    printf("%d\n",v);
}
int main(void){
    int (^b)(int) =^(int x){return  x*2 ;}; //参数乘于2
    printf("%d\n",b(4));
    func(b);    //向函数传递块参数
    func(^(int a){
        int i,k=0;
        for (i =a;i>0;i--){
            k+=i;
        }
        return k;
    });
    return 0;
}

1.3块对象和类型声明

同函数指针一样，未来简化类型的书写，我们也可以使用typedef简化声明，例如，有一个像代码清单14-2那么传入的参数为int型，且返回值为int型的块对象，如果将其类型声明为myBlockType可以采用如下方式
typedef int(^myBlockType)(int);

使用该类型后，声明函数func就可以使用下面的方式
void func(muBlockType block)

此外，定义包含3个该类型元素的数组blocks时，可以使用如下方式，如1和2所示

int (^block[3])(int);    //1
myBlockType block[3]; //2

如果块对象没有参数，参数列则可以设置为（void）此外也可以将参数列连同括号全部省略，或者只保留括号，如下面3个例子所示

void(^foo)(void) =^(void){/* …*/}; //(a)
void(^foo)(void)=^{/* … */} //(b)
void(^foo)() =^(){/*  … */}//(c)

亏句法和函数不同，他不指明返回值类型，编译器虽然会自己推测返回值的类型，但是有些时候未来使代码能够按照预期正确执行，指明return返回的类型也未尝不是一件好事，例如，下面的例子表面上看似没有什么问题，但由于sizeof操作符韩惠的类型有unsigned long 因此，其中一个return就应该根据映射添加类型转换

func(^(int n)){
	if(n<sizeof (struct goods))
		return n;
	return sizeof(struct goods);
}

此外，我们还能够通过使用__BLOCKS__宏来检查当前系统环境下是否可使用块对象，根据编译的不同条件，即可区别可以使用块对象时的情况和不可用使用块对象时的情况

1.4 块对象中的变量行为

从代码14-1和代码清单14-2中，我们了解到可以像使用函数指针那样使用块对象
这里，让我们来关注一下在函数块内声明的自动变量在块句法中使用时的情况，我们说的自动变量其实是函数块内的局部变量，他们通常不用static关键字修饰，与此同时，我们也来看一下函数的形参，请见代码清单14-3

代码清单14-3 包含自动变量的块对象例子

block3.c

#include "block3.h"
#include <stdio.h>

void myfunc(int m,void (^b)(void)){
    printf("%d:",m); //只打印数字
    b();             //k运行块
}
int glob1 =1000;

int main(void){
    void (^block)(void);
    static int s=20;//局部静态变量
    int a =20; //自动变量
    block =^{printf("%d,%d,%d\n",glob1,s,a);}; //1
    myfunc(1, block);
    s=0;
    a=0;
    glob1=5000;
    myfunc(2, block);
    block=^{printf("%d,%d,%d\n",glob1,s,a);};//2
    myfunc(3, block);
    return 0;
}

在代码1中，变量block被赋值为块对象，请注意块对象中包含着外部变量glob和main函数内定义的局部变量s和a，之后，程序将块对象作为此案书传给myfunc函数并调用，然后又在改变变量glob、s、a的值后再次调用函数myfunc，在代码2处，变量block被赋值为块对象，然后调用myfunc函数，执行程序可得到如下结果

￼

下面我们来看一下结果，第一行中各个变量的值应该没有任何问题，那么第二行是否有问题呢，可以发现，变量glob和s的值改变了，而变量a的值和第一行相比没有任何变化，第三行显示的是在代码2处代入块对象后的变量值，此处变量a的值也改变了，如此看来，块对象好像只在块句法中保存自动变量的值

块对象就是把可以执行的代码和代码中可访问的变量“封装”起来，使得之后可以做进一步处理的包，而闭包这个称呼本身就是把变量等执行环境封装起来的意思，我们把闭包引用，读取外部变量称为捕获
下面我们来总结一下之前的介绍
- [ ] 块句法主体中，除块句法内部的局部变量和形参外，还包括块句法当前位置处可以访问的变量，这些变量中有外部变量，还有包含块句法的代码块内可以访问的局部变量
- [ ] 从块对象内部可以直接访问外部变量，也可以直接改变变量的值
- [ ] 在包含块句法的代码块内可访问的局部变量中，书写块句法时自动变量的值会被保存起来，然后再被访问
	（a、所以，即使变量最初的值发生了变化，块对象在使用时也不会知道
	（b、变量的值可以被读取但不能被改变
	（c、自动变量为数组的时候，会发生编译错误

下面举例说明为什么不能改变自动变量的值，假设代码清单14-3的main函数内有如下块句法

block =^{ 	glob +=10;//没问题
	s+=10;//没问题
	a+=10;//产生编译错误
};

也就是说，因为改变了自动变量a的值所以产生了编译错误，错误信息如下所示，这里，不能赋值的变量不是main函数内的自动变量a，而是块内捕获的变量

block3.c:22:11:error:variable is not assignable(missing __block type specifier)

看起来好像有点复杂，简言之就是，在块对象中虽然可以使用可访问的变量，但自动变量的话只能读取复制值，换言之，自动变量在运行时就相当于const修饰的变量

 1.5排序函数和块对象

这里我们来看一个Mac OS X 10.6及iOS4.0 的C库（BSD API）中所引入的使用块对象的函数，并体会一下使用块对象的好处
C语言的标准库中有一个qsort函数可以可以按照升序（从小到大的方向）排列数组中的数据，因为排序算法使用的是快排，所以便使用了qsort这个名字，头文件stdlib.h中有一个函数采用了如下方式声明

void qsort(void *base,size_t nel,size_t width.int(*compar)(const void *,const void *));
	数组的头指针由参数base指定，数组的元素数，每个元素的大小分别用nel和width表示，第四个参数是函数指针。该函数的指针参数指向2个元素，并在其之间进行比较，第一个元素大时（大元素排序在后）返回正整数，小时返回负整数卖个相等时返回0
例如，下面这个结构体表示了商品的价格、库存和商品名称

struct goods{
	int price;
	int storck;
	char *item;
};

该结构体的数组table中包含PRODUCTS个数据，这里我们调用qsort函数将这些数据按照价格从小到大的顺序来排序，如下所示：

qsort(table.PRODUCTS,sizeof(struct goods),compf);

函数compf的定义如下：

static int compf(const void *p1,const void *p2){
	const struct goods *e1,*e2;
	e1=p1;
	e2=p2;
	return (e1->price - e2->price);
}

下面，介绍一个使用块对象而非函数指针来进行排序的函数qsort_b，原型声明在头文件stdlib.h中，这时，函数最后一个参数就不再是函数指针，而是换成了对象

void qsort_b(void *base ,size_t nel,size_t width,int(^compf)(const void*, const void *));
	
使用qsort_b函数也能像上面那样实现排序数组table的数据功能，方法如下，毫无疑问，块对象也可以代入变量

qsort_b (table,PRODUCTS,sizeof(struct goods),^(const void *p1,const void *p2){
	const struct goods *e1,*e2;
	e1=p1;
	e2=p2;
	return (e1->price -e2->price);
});

这样我们就知道了使用块对象可以实现和函数指针相同的功能，既然如此，我们为什么还有专门使用块对象呢？
大家不妨考虑一下，在上例中，如果不是按价格而是按商品库存数量来排序的话该怎么做呢？或不尽兴升序而进行降序排序的话呢？
代码清单14-4示范了块对象的使用方法，因为块对象可以捕获变量sort_stock和descending的值，所以可根据设定值按库存数量进行排序，或者进行降序排序，此外，当想用其他排序方法时，只要修改一下包含qsort_b函数调用的代码块附近的部分就可以完成

代码清单14-4 使用代码块来灵活排序的例子

int sort_stock =/* 0:价格，1:按k库存数量排序*/;
int descending =/* 0:升序，1:降序*/;
...;

qsort_b(table,PRODUCTS,sizeof(struct goods),^(const void *p1,const void *p2){
    const struct goods *e1,*e2;
    int d;
    e1=p1;
    e2=p2;
    if(sort_stock)
        d=e1->stock -e2->stock;
    else
        d=e1->price -e2->price;
    if(descending)
        d=-d;
    return d;
});

向排序函数传递的函数指针或块对象会告诉函数如何进行排序，而与之最相关的信息就是排序函数调用前后的代码，不仅限于排序算法，其他API也是如此，通过在想要调用函数的地方使用块对象，就可以利用调用出的上下文信息
使用函数指针时，需要血不同的函数来对象各种不同的功能，此外，为了给函数传递需要的附加信息，往往还要使用多余的参数和外部变量，而这些都违背了编写代码要进可能独立易懂的原则，例如，Mac OS X的C库函数中很早就有了函数qsort_r，该函数与qsort函数的不同之处，就是增加了参数thunk，另外，函数指针的第一个参数void*也是新增的

void qsort_r (void *base,size_t nel,size_t width,void *thunk,int(*compf)(void *,const void *,const void *));

参数thunk中可以传递任意指针，而该指针会被传递给函数compf的第一个参数，因此，在将某些信息以一个结构体的形式传递时，就可以控制排序行为，但是，着就要求我们在信息传递方法上多费些心思，结构体和函数必须分开定义，否则扩展性和易读性就会变差
不仅是C库的函数，ObjectiveC中也有像这样通过传递指针来传递附加信息的方法，但是，通过灵活使用块对象，我们就可以将这样的函数或方法实现为易读、灵活的书写方式
    """},
  {'title' : '第十四章（2）' , 'message' : """
2、块对象的构成

2.1块对象的实例和生命周期

在之前的例子中，块对象都是在函数等代码块的内部，而其实块对象也可以写在函数的外部，例如代码清单14-5中的1处，代入到变量g中的块对象就是一个很好的示例
这段代码虽然编译时没有任何问题，但执行后就可能会在注释5处显示异常值，或者发生运行时错误，而如果不明白对象的实质到底是什么，我们就不能理解出现这一问题的原因

代码清单14-5 块对象和栈之间的关系示例

block5.c

#include "block5.h"
#include <stdio.h>

void pr(int (^block)(void)){ //参数为块对象
    printf("%d\n",block()); //执行块对象后打印的结果
}

int (^g)(void) =^{return 100;};  //1

void func1(int n){
    int (^b1)(void) =^{return n;}; //2
    pr(b1);
    g =b1; //3
}

void func2(int n){
    int a=10;
    int (^b2)(void)=^{return n*a;};
    pr(b2);
}
int main(void){
    pr(g);
    func1(5);
    func2(5);
    pr(g); //5
    return 0;
}

编译块句法时，会生成存放必要信息的内存地址（实体为结构体）和函数，变量中代入的以及向函数传入的实参，实际上就是这片内存区域的指针，如代码清单14-5中的1所示，在函数外部的块句法被编译后，块对象的内存区域就同外部变量一样被配置在静态数据区中
另一方面，2和4 处函数中的块句法有着不同的行为，执行包含块句法的函数时，和自动变量相同。块对象的内存区域会在栈上得到分配，因此，这些块对象的生命周期也会自动变量相同，只在函数执行期间存在
图14-1表示的是在执行代码清单14-5的代码时栈的情况（地址因编译的方法或系统环境而异）（a）是函数func1调用函数pr的情况，（b）是函数func2调用函数pr的情况，可以看出，这些函数内的块对象和自动变量b1，b2以及a并列位于栈上，变量b1和b2是指向块对象首地址的指针，位于栈顶部的块block是函数pr的形式参数，也指向相同的地址
￼
块对象将要保存的自动变量的信息复制到了内存区域中，图14-1的（a）中保存了形参n的值，（b）中保存了变量a的值，内存区域的大小是不同的。该内存区域中也包含了评估块对象时所执行的函数指针等的信息
即使反复执行块句法处的代码，也不会每次都为块对象动态分配新的内存区域。但是，被赋值到内存区域中的自动变量的值，诶次都会更新，另一方面，含有块句法的函数在递归调用时，同自动变量相同，块对象就会在栈上保存多个内存区域
下面我们来总结一下：
1、块句法写在函数外面时，只在静态数据区分配一批内存区域给块对象，这片区域在程序执行期会一直存在
2、块句法写在函数内时，和自动变量一样，块对象的内存区域会在执行包含块对象的函数时被保存在栈上，该区域的生命周期就是在函数运行期间

此外，在现在的实现中，当函数内的块句法不包含自动变量时，就没必要复制值，所以块对象的内存区域也会被设置在静态数据区，但因为实现方法可能改变，所以应该尽量避免编写具有这种依赖关系的程序

2.2应该避免的编码模式

下面让我们重新看一下代码清单14-5，想一下发生执行错误的原因
3处将变量b1的块对象赋值给外部变量g，但是变量b1中保存的是指向栈的指针，也就是图14-1（a）中0Xbfff984地址表示的位置，函数func1执行完后，该块对象的生命周期也随之结束，如图14-1（b）所示，由于函数func2的调用会使栈上被写入其他信息，因此5处执行时就会发生错误，像这样，栈上生成的块对象在生命周期外是不能被使用的
如果能明白块对象的构成，那么也就能很容易看懂下面的代码清单14-6的复制操作，我们可能会认为，这个复制操作中，返回值为i的各个块对象被保存在数组blocks的第i个元素中，但是，由于保存块对象实体的内存区域只有一块，因此在for循环中数组中保存的指针都是一样的，这样一来，数组的每个元素都保存着返回值为9的块对象

代码清单14-6 证明块对象只有一个实体的实例

block6.c

void func(void){
	int i;
	int (^blocks[10])(void);
	for(i=0;i<10;i++)
		block[i]=^{return i;}; //将块对象代入数组中的各个元素中
	for(i=0;i<10;i++)
		pr(block[i]);	//打印块对象的输出结果
}

如果想为数组的各个元素代入不同的块对象，就必须要进行下一节中所说的复制，但是，使用ARC时操作是不同的

2.3块对象的复制

如前所述，函数内的块对象和自动变量相同，生命周期只在函数执行期间，但是，在函数或方法的参数重代入块对象也是很常见的方式，这种情况下，使用与函数调用关系或栈状态无关的块对象是非常便利的
有一个函数可以复制块对象到新的堆区域，通过使用该功能，即使是函数内的块对象也能独立于栈被持续使用，此外，还有一个函数可以释放不需要的块对象
Block_copy(block)
	参数为栈上的块对象时，返回堆上复制的块对象，否则（参数为静态数据区或为堆上的块对象）则不进行复制而直接将参数返回，但会增加参数的块对象的引用计数
Block_release(block)
	减少参数的块对象的引用计数，减到0时释放对象的内存区域

在使用这些函数时，源文件中需要添加头文件Block.h，该文件在/urs/include目录中
如前所述，堆上分配的块对象使用引用计数来管理，即使在使用垃圾回收的情况下，也必须成堆调用Block_copy和Block_release函数
代码清单14-5的例子中，如果将3处的代入改成如下方式，在运行程序时就可以不用在块对象的生命周期
g=Block_copy(b1);
代码清单14-6中数组的代入也可以按照如下方式书写
for(i=0;i<10;i++)
	blocks[i] =Block_copy(^{return i};);

2.4指定特殊变量__block

块对象可以包含其访问的自动变量的副本，但是只能直接读取值，另外，若要在多个块对象之间共享可以读写的值，就只能利用外部变量或静态变量
多个块对象间可以共享值，然而，这种共享需要指定函数块内的局部变量，这样的变量用__block修饰符来指定，这个修饰符不能和static或auto或register同时指定
下面就让我们通过一个程序示例来看看修饰符__block到底发挥了什么样的作用，代码清单14-7中，函数func内写了2个块句法，两个都读取、更改__block修饰的变量sh，如果是一般的自动变量，无论哪个块中，变量sh都保持0值不会更改，所以就要在函数中生成块对象的副本并代入外部变量g

代码清单14-7 __block修饰符的效果示例

block7.c

#include "block7.h"
#include <Block.h>
#include <stdio.h>

void (^g)(void) =NULL ; //块对象使用的外部变量
int c=0; //每次执行块时变量都加1

void func(int n){
    __block int sh =0;
    void(^b1)(void) =^{
        sh+=1;
        printf("%d:b1,n=%d,sh=%d\n",++c,n,sh);
    };
    void(^b2)(void) =^{
        sh+=20;
        printf("%d:b2,n=%d,sh=%d\n",++c,n,sh);
    };
    b1(); //[1],[5]
    b2(); //[2],[6]
    g=Block_copy(b1);
    sh+=n*1000;
    n=999;
    b2();
};

int main(void){
    void (^myblock)(void);//块对象使用的变量
    func(1);
    myblock =g;
    myblock(); //[4]
    func(2);
    myblock(); //[8]
    Block_release(g);
    Block_release(myblock);
    return 0;
}

程序执行结果如下：
￼

开头的行编号对应着编码执行位置，这些在编码的注释中都有说明，形式参数n的值即使被修改，在执行结果中也显示不出来，而变量sh修改后的结果却会被共享
最有趣的是执行结果的最后一行，这里被执行的块对象是在第一次调用函数时生成的副本，可以看出，执行块对象后，第一次调用中使用的变量sh值一直保留了下来

从这个例子中能看出，通过使用__block修饰的变量，因块对象的处理而改变的值就可以被共享并读取，这种关系在同一个块句法执行时生成的块对象之间有效

修饰符__block修饰的变量（简称为__block变量）有如下功能：
（1、函数内块句法引用的__block变量是块对象可以读取的变量，同一个变量作用域内有多个块对象访问时，他们之间可以共享__block变量值
（2、__block变量不是静态变量，他在块句法每次执行块句法时获取变量的内存区域，也就是说，同一个块（变量作用域）内的块对象及他们间共享的__block变量是在执行时动态生成的
（3、访问__block变量的块对象在被复制后，新生成的块对象也能共享__block变量的值
（4、多个块对象访问同一个__block变量时，只要有一个块对象存在着，__block变量就会随之存在，如果访问__block变量的块对象都不存在了，__block对象也会随之消失

因为可能会涉及实现，所以这里省略了对__block变量的行为的说明，但是有一点需要注意的是，随着块对象的复制，__block变量的内存位置有时会发生变化，而且，大家不要写使用指针来引用__block变量的代码，因为那样可能得不到预期的结果

3、ObjectiveC和块对象

3.1方法定义和块对象

随着块对象的引入，Cocoa API中添加了使用块对象的各种方法
首先，我们来看一下块对象作为方法参数传递时参数类型的指定方法，现在，假设有一个块对象，他有2个整数类型的参数并返回BOOL类型的结果，将块对象代入变量block时，使用了如下方式

BOOL (^block)(int,int) =^(int index,int length){…;};

使用该块对象作为参数的方法setBlock：声明如下：外侧的圆括号包围的部分时参数类型，block是形式参数名

-(void)setBlock:(BOOL (^)(int,int))block;

类型部分中也可以写形式参数名，这样记述虽然略显冗长，但可以使各个参数的作用更容易理解

-(void)setBlock:(BOOL(^)(int index,int length))block;

方法返回的块对象在传递时也是同样的

-(BOOL(^)(int,int))currentBlock;

在ObjectiveC 中使用块对象时，在块句法也可以写消息等ObjectiveC的语法元素

3.2作为ObjectiveC对象的块对象

令人惊奇的是，ObjectiveC程序在编译运行时，块对象会成为ObjectiveC的对象来执行操作
块对象可以像继承了NSObject的类实例那样运行，一般的接口对象执行的操作虽不完全但也能适用于块对象，也可以代入id类型的变量
此外，我们也可以使用copy方法生成实例对象的副本，这和Block_copy的使用相同，使用手动计数管理方式时，可以使用retain、release及autorelease方法，同样也可以将块对象保存在数组等集合中，然而，需要注意的是，目前retainCount方法返回的引用计数结果是不正确的

3.3ARC和块对象

使用ARC和不使用ARC时，块对象的操作是有区别的，这点需要注意
如之前所述，栈上保存的块对象在包含块句法的函数执行结果后也可以继续使用，但必须复制块对象才行，同样，在ARC中需要保存块对象时，编译器会自动插入copy操作
具体地说，就是在被代入强访问变量以及被作为return的返回值返回的时候，这些情况下，程序不需要显式地执行块对象的副本
代码清单14-6的数组代入的例子中也没有完整地书写copy方法，但是也可以按照预期执行，也就是说，数组blocks是强访问变量，在块代入之前就已经生成了copy执行代码了
但是，作为方法参数传入的块对象是不会自动执行copy的，而且当块对象作为声明属性的值时，属性选项一般会指定copy，例如，Application框架的NSTask类就包含如下块对象的属性声明

@property (copy) void{^terminationHandler)(NSTask *)};

然而，程序中即使有copy方法，由于编译器会判断所有者的操作而进行相应的处理，因此这点也不用在意
此外，请不要使用Block_copy和Block_release因为已经定义了（void *）型参数指针，所以ARC不能推测所有者
还有一点是__block变量的行为不同，不使用ARC时，__block变量只代入值，示情况可能会悬空指针，ARC中因为有__strong修饰符__block变量，使其作为强访问变量来使用，因此就不会成为悬空指针

3.4对象内变量的行为

之前已经介绍了块句法中有外部变量或自动变量时这些变量的行为，这里，我们将详细介绍块句法使用对象时的行为，特别是引用计数的处理
首先让我们来看下下面这段代码
void (^cp)(void);//可以保存块的静态变量

-(void)someMethod{
	id 0bj =…;//引用任意实例对象
	int n=10;
	void (^block)(void) =^{[obj calc:n];};
	…
	cp=[block copy];
}

图14-2（a）中，块对象在栈上生成，自动变量obj和n可以在块内使用，变量obj引用任意实例对象时，块对象内使用的变量obj也会访问同一个对象，这时，实例变量的引用计数不发生改变
￼
下面，假设块对象自身被复制，并在堆区域中生成了新的块对象（14-2（b））这里，实例对象的引用计数加1，由于方法执行结束后自动变量obj也会消失，因此，引用计数加1，就使得块对象成为例所有者，实例对象不是被复制而是被共享的，不只从块对象，从哪都可以发送消息
需要注意的是在某个类方法内的块句法中被书写类同一类的实例变量这种情况，例如下面这个例子，假设ivar为包含方法someMethod的类实例变量

void(^cp)(void);
-(void)someMethod{
	int n=10;
	void(^block)(void)=^{[ivar calc : n];};
	…
	cp=[block copy];
}
￼
这种情况下，当块对象被复制时，self的引用计数将加1，而非ivar如图14-3所示，方法的引用参数（见8.2节）self在堆上分配，在上例中，self好像没有出现在块句法中，我们可以按下面的方式理解
^{[self->ivar calc:n];};

块句法内的实例变量为整数或实数时也是一样的，self的引用计数也会增加，也就是说，挡雨self对等的对象不存在是，所有的实例变量都将不能访问

块对象和对象的关系可以总结如下：
（1、方法定义内的块句法中存在实例变量时，可以直接访问实例变量，也可以改变其值
（2、方法定义内的块句法存在实例变量时，如果在栈上生成块对象的副本，retain就会被发送给self而非实例变量，引用计数器的值也会加1，实例变量的类型不一定非得时对象
（3、块句法内存在非实例变量的对象时，如果在栈上生成某个块对象的副本，包含的对象就会接收到retain，引用计数器的值也会增加
（4、已经复制后，堆区域中某个块对象即使收到copy方法，结果也只是块对象自身的引用计数器加1，包含的对象的引用计数器的值不变
（5、复制的块对象在被释放时，也会向包含的对象发送release

3.5集合类中添加的方法

Mac OS X 及iOS 的API特别是Foundation框架中，增加了很多使用块对象的类和方法，由于篇幅有限，这里举一些集合类中添加的典型方法作为例子进行介绍
第一个例子是在排序，NSArray类中有一个通过使用块对象比较元素来排序的方法，这个方法会将排序结果保存到训的数组中返回，NSMutableArray类中也有排序方法，但它排序的是数组元素自身
-(NSArray *)sortedArrayUsingComparator :(NSComparator)cmptr;

NSComparator是块对象的类型，使用typedef定义，如下所示，NSComparisonResult为比较结果的枚举类型，基本上采取与函数qsort_b同样的方式代入块对象

typedef NSComparisonResult(^NSComparator)(id obj1,id obj2);

下面的方法实现的是从数组中返回满足块对象指定条件的最初的元素索引，如果没有满足条件的元素，则返回NSNotFound值

-(NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id obj,NSUInteger idx,BOOL *stop))predicate

从数组第一个元素开始，作为方法参数的块对象会被顺序传入元素的对象和索引，传递给块对象的元素如果满足条件就返回YES，否则就返回NO，第三个参数stop为输出用的指针参数，当返回YES时，可以打断条件检查的递归处理
例如，该方法的参数中可以传入下面的块对象，该块对象会搜索大雨10个字符长度的字符串，在遇到符合变量terminator内容的字符串时，处理结束
^(id obj,NSUInteger idx,BOOL *stop){
	if([obj isEqualToString:terminator])
		*stop=YES;
	return (BOOL)([obj length] >10);
}

下面的方法会从数组的第一个元素开始按照顺序将元素对象和索引赋值给块对象，因此，块对象将会对元素依次进行处理，块对象的参数和上一个方法相同

-(void)enumerateObjectsUsingBlock:(void (^)(id obj,NSUInteger idx,BOOL *stop))block

最后举一个字典类NSDictionary中添加方法的例子，该方法会一次取出字典中存储的入口，并将键值和元素对象传入块对象，使用BOOL类型指针来终端处理的方法和之前所示的方法同样
-(void)enumerateKeyAndObjectsUsingBlock:(void(^)(id key,id obj,BOOL *stop))block

3.6在床体重使用块对象

在MacOSX 中打开应用窗口进行操作时，执行“保存”操作后，窗口上会显示出窗体，我们可以指定保存地点，保存文件名以及各种参数，这里跳出的窗体就是Appliction框架的NSSavePanel类的实例
从窗体出现到点击关闭按钮期间，应用可以执行其他和跳出窗体完全无关的操作，为此，在执行关闭操作来咱叔停止显示弹出窗口时，既要执行其他方法进行善后处理，但是，关闭跳出窗体时，应该进行的操作和用到的信息，与显示跳出窗体的方法时关系最为紧密的
￼
这里，我们会预先在显示窗体时将关闭窗体时执行的善后处理以块对象的形式传入，只要在块对象句法中书写了善后处理代码，就可以在自动复制，保存或调用时使用处理用到的变量值和对象
下面是在指定窗口中显示窗体时调用的NSSavePanel类的方法

-(void)beginSheetModalForWindow:(NSWindow *)window
		           completionHandler:(void(^)(NSInteger result))handler

通过调用这个方法来执行保存处理的save：方法可按照如下方式书写，按下窗体的按键时执行的处理也可以书写在同一个位置

-(void)save:(id)sender{
	…
	NSSavePanel *svpanel =[NSSavePanel savePanel];
	[svpanel beginSheetModalForWindow : window completionHandler:^(NSInteger result)]{
		if(result ==NSFileHandlingPanelOKButton){
			/*按下保存按键时的处理*/
		}
		else{
			/*按下取消按键时的处理*/
		}
	}];
}

然而，上述情况下，因为块对象是在栈上生成的，所以save：方法执行结束时，块对象也会随之消息，那么，块对象释放应该先复制再传入呢？
调查发现，NSSavePanel在接收块对象后会复制保存一份，所以，在方法save：中就没有必要在复制块对象了，在延迟（或异步）使用所接收的块对象的方法中，其实现与方法应该是相同的，但遗憾的是，这一天的信息在类文档中不一定会写明
相反，如果自定义了将参数块对象随后执行这样的方法，则需要复制块对象，并在不需要时尽快释放
然而，使用ARC书写代码时，就不需要考虑这一点，代入变量的块对象会自动复制一份并保存

3.7ARC中使用块对象时的注意事项

使用ARC开发软件时需要注意不要写死循环代码，之前也讨论过，使用块对象时，想对象可能会被自动保存，这时也许就会产生死循环，先看一个简单的例子
图14-5，对象Handler为专门执行某个处理的对象，对象Logger是打印系统的操作历史的对象，而对象Manger则持有这些对象，假设在对象Handler处理结束时块对象已经被赋值给了属性cleanUP，那么在随后的善后处理中就对其进行调用，而实际的应用也是由执行整体控制的对象，以及分担各个处理作业的对象协调构成的
现在，假设对象Manager将推对象代入到了Handler属性中，如之前所述，块句法中有实例变量时，selfe而非实例变量的引用计数会自增，这时，块对象内包含了Manger，形成了Manager-Handler-块对象-Manager的循环包含，这些对象不会被释放，一只保存在内存中
￼
这样的情况很容易在不知不觉中就发生了，clang编译器只能检测出典型的包含循环，所以总会有漏网的情况
这种情况下可以用代入临时变量的方法来解决
在图14-5中，对象Manager方法内使用了如下方式设定块对象

handler.cleanUP =^{[logger writeLog];};

接着，使用弱访问的自动变量weakLog，如下所示

__weak Logger *weakLog =logger;
handler.cleanUP =^{[weakLog writeLog];};

采用这种方式后，从块对象中就不用引用对象Manager了，因为不能强访问原先的对象Logger所以只要存在该块对象就会释放Logger对象

这个例子很简单，而一般我们遇到的处理都很复杂，在执行块对象期间，可能就会因副作用而释放弱访问对象，为此，我们可以将self自身作为弱访问对象捕获，并在块对象内使用强访问来保存对象，由于和self相当的对象在释放时可能会因操作符->而发生执行时错误，所以需要进行条件判断

__weak Manager *weakSelf =self;
handler.cleanUp =^{
	Manager *strongSelf = weakSelf;//确保执行时不释放
		if(strongSelf){
		[strongSelf -> logger writeLog];
	}
};
    """},
  {'title' : '第十五章（1）' , 'message' : """
1、应用和运行回路

1.1运行回路

无论是有GUI（图形用户界面）的Mac os x应用，还是iPhone iPad 的应用，都是通过用户选择菜单，点击（或拖拽）界面或操作键盘等而作出反应的，这些程序和命令行程序相比有很大的不同
这些应用从操作系统接收鼠标点击等事件的消息，并将其转到相应的例行程序来处理，如此反复，这样的过程被称为运行回路（run loop）或事件循环（event loop）
￼
图15-1概括说明了应用和运行回路的处理流程，运行回路从操作系统（更精确地说时窗口服务器）中接收事件，并根据事件种类和状态来调用相应的例行程序，同时也会忽视那些没不要处理的事件，这些事件的到来非常随机，当应用程序正在处理某个事件消息时，没有消息到来的时候，应用会进入休眠等待的状态
从应用程序开发者的角度来说，某个事件触发时，总有一个ObjectiveC的对象接收到该事件消息，例如：在创建GUI应用时，每个GUI组件都有对应的动作消息，当按钮、菜单等组件被点击时，这些行为消息就会被发送到相应的组件对象中处理，在视图上进行拖拽时也一样，视图方法会捕获描述事件的参数并传给视图对象，这样视图对象就能成功地获得拖拽操作的坐标等信息
因此，开发者只要集中精神实现消息事件的处理方法就可以了，这样一来，编程就变得非常简单，只要实现用户的各种操作请求即可，也就是说需要实现并封装一些方法以应对用户发出的命令和操作，而命令行程序从开始执行到结束基本上都是流水线式的处理，可见两者的编码方式明显不同
因为Cocoa应用本身就有GUI功能，所以一旦开始运行，就一定会产生一个运行回路，他也称为主运行回路，同时，应用的事件处理或资源的管理功能需要一个对象来完成，所以Mac os x中提供了NSApplication类的实例，iOS中提供了UIApplication类的实例。该实例会根据操作系统发送的事件选择对应的处理对象，并发送相应的消息，关于这些类的情况在下一章节中还会接触到
回路运行后，当有新的事件消息到来而别的处理还没有结束的情况下，应用就可以把该事件放入等待队列并在之后按顺序执行，这种性质非常适合多线的异步执行，多线程应用的情况下，使用NSRunLoop类来访问运行回路，多线程的相关内容请参考第19章
在使用引用计数方式的情况下，主运行回路在启动事件处理方法时会生成一个自动释放池，并在方法终止的时候释放他，而垃圾回收的情况下，一个事件处理完后就会启动一个垃圾回收器，应用中执行的方法基本上时自己管理自动释放池，不需要担心什么时候垃圾回收，当然，如果某个方法要生成很多临时对象，最后在合适的地方释放这些内存，而主线程之外执行的方法则要自己生成自动释放池，这一点请注意

1.2定时器

现在介绍一下能够在特定的时间或者按照一定的时间间隔来发送指定消息的组件，如果能灵活使用该组件，就能够轻松地实现一些必须使用并行处理才能够实现的操作
在foundation framework 中，NSTimer类能够让指定的消息在一定的时间间隔后执行，而定时器对象即实现了NSTimer类的实例
定时器的使用必须要有运行回路，在运行回路上注册定时器后，到达规定的时间时，运行回路就会调用注册的方法来处理
这里只简单说明一下MSTimer的主要方法，详细介绍请参考相关文档，此外，NSTimer的接口在Foundation/NSTimer.文件中

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)sec
								 target:(id)target
							      selector:(SEL)aSelector
							      userInfo:(id)userInfo
							       repeats:(BOOL)repeats
	创建NSTimer对象，并在运行回路上注册之后返回，该对象已实现了运行回路
	该方法自身的调用很快就会结束，sec变量指定的秒数过去后，定时器被触发，参数aSelector指定的
	消息被发送给target参数的对象，NSTimeInterval的类型是实数，目前由typedef定义为double类型
	aSelector指定把定时器对象当作唯一参数的选择器，定时器对象本身就是消息发送时的参数，如果要附加消息，通过参数userinfo指定包含该信息的对象即可，无附加消息时，则将userInfo设为nil
	参数repeats为YES时，同一个消息会按照指定的时间间隔被反复发送，为NO时，消息只被发送一次

-(id)userInfo
 	返回作为附加信息的定时器对象，主要被用于获得定时器信息
-(NSTimeInterval)timeInterval
	返回定时器对象中设定的时间间隔
-(void)invalidate
	将定时器对象设置为无效，使运行回路释放定时器消息

1.3 消息的延迟执行

下面介绍一下经过一段时间后再执行消息的方法，该方法由NSObject定义，所有对象都可以使用，同样，延迟执行也要有运行回路
-(void)performSelector:(SEL)aSelector
		    withObject:(id)anArgument
		     afterDelay:(NSTimeInterval)delay
	该消息被发送后，至少要经过delay秒，aSelector指定的消息才会被真正发送给anArgument参数指定的接收者
+(void)cancelPreviousPerformRequestsWithTarget:(id)aTarget
								     selector:(SEL)aSelector
								withObject:(id)anArgument
	如果有使用performSelector：withObject：afterDelay：这个三个实例方法注册的请求，则取消，在该方法中，指定的选择器与参数对象必须一致，而在方法cancelPreviousPerformRequestsWithTarget：中，只要目标对象一致就可以取消

和使用定时器对象的情况相比，虽然该方法不能定义重复执行的方法，但是他可以指定发送给目标对象的参数，具有高灵活性
显然，延迟执行可以实现在设置的时间间隔后执行某种操作，而除此之外，在使消息处理和GUI操作并发执行时，以及在消息没有按照预期顺序来执行时，通过延迟执行都能有效地解决这些问题
例如，我们都知道GUI组件的下拉菜单，当用户选择菜单项的时候，只有在相应的处理结束后菜单才会关闭，根据下来菜单的选择的不同，在某些情况下，当窗体大小和形状发生变化时，下拉菜单也会保持着被打开的状态并停留在原来的位置上，为了避开这样的情况，只需在选择菜单项时使用延迟执行，并预定调用方法的时机即可

2、委托

2.1委托的概念

当对象需要根据用途改变或增加新功能时，为了执行新添加的处理，就需要引用一个特殊的类似于“被咨询者”的对象，这个对象就称为委托，委托可在运行时动态分配
委托时对象之间分担功能并协同处理时的一个典型的设计模式，在面向对象中，委托一般可以被解释为“某对象接收到不能处理的消息时让其他对象代为处理的一种方式” 在图15-2中，对象A可以处理消息X，但是不能处理消息Y，这里对象A委托对象B来处理消息Y，但表面上看却是A处理了2个消息，这就是典型的委托
￼

2.2 Cocoa环境中的委托

在Cocoa环境中，与其说委托时处理自身不能处理的消息，还不如说它时应用为了添加必要的处理而增设的对象，图15-3（a）是非委托的情况，这种情况下会执行默认处理（也可能无法处理），（b）为委托的情况，这种情况下会与委托对象协同处理或完全由委托对象处理
￼
委托有很高的可复用性，在作为i 组件使用的类中十分有效，通过使用委托，可以在不损害原类别的独立性的同时，给软件增加独立的功能
举例说明如下：
Application框架的NSWindow类是普通显示界面的高可复用类，NSWindow实例可以指定委托对象进行某些处理，窗体显示、主窗体显示、按下关闭键、尺寸设定等消息发生时，委托对象都会收到通知，以及关于是否能处理这些消息的咨询
例如，按下窗体的关闭按钮时，按照默认操作该窗体会立即被关闭，但是，有时候也会希望在某个操作结束之前不要关闭窗体，按下窗体的关闭键后，将询问是否可以关闭的消息发送给委托对象，委托对象就可以根据当时的情况，拒绝关闭或弹出用户确认窗体
在举一个关于iPhone等内置加速度传感器的例子：
加速度传感器可以使用UIKit框架的UIAccelerometer类，加速度传感器时单体类，也就是只能有一个实例的类型，那么用用中如何感知iPhone的晃动及倾斜呢？
实际上是创建单个对象，将其注册为UIAccelermometer实例的委托，这样，检测到的加速度值作为消息每隔一定时间就传送给委托对象，不需要在询问UIAccelermoeter，应用既可以一直获得加速度值信息，也可以在传感器发生较大变化时获得，在其中的差异在委托侧的程序中实现
委托可以为已有类增加新功能，是一种灵活性较高的获取并利用信息的方式，而且，一个对象并不是只能有一个委托，某些情况下一个对象也可以拥有多个委托
毋庸置疑，现实中也存在一些建议使用继承的情况，虽然继承和委托必须要区分使用，但委托有很多继承没有的优点，熟练使用委托在很多情况下达到事半功倍的效果

2.3委托的设置和协议

在Cocoa环境中，委托常见的实例例子是名为delegate的id类型的实例变量，设置委托，返回委托对象的方法使用如下函数：
-(void)setDelegate:(id<XXXXDelegate>)anObject
	将参数对象设置为委托，一般不需要保留（retain）参数对象
-(id<XXXXDelegate>)delegate
	返回接收的委托对象

一直以来，委托的类型只使用id类型，Mac os x10.6以后，开始显式调用上述协议方法，协议名就是包含委托的类加上Delegate，例如，NSWindow类的委托的协议就是“NSWindowDelegate”这个名字，大部分情况下，协议造包含委托的类的头文件中声明，而引用在类和协议中多采用不同的饭声明方式
委托也可以租哟喂属性类声明，例如，UIKit的UIPickerView类中有如下方式声明

@property(nonatomic,assign) id<UIPickerViewDelegate> delegate;

在此例和上述一般的设置方法中，由于不保留委托对象，因此解除委托功能时就需要显式设置为其他值或者nil，否则就有成为空指针的危险
使用ARC时，可以使用弱引用来定义委托

@property(weak)id<xxxDelegate> delegate

Foundation框架、Application框架、UIKit框架中很多类都有委托功能，在实际编程中，除了要关注各类中可以调用的方法之外，还需要注意可以用委托实现什么样的功能

2.4使用委托的程序

将自定义类的实例作为某些对象的委托来调用时要怎么做呢？例如，至于是否关闭窗体NSWindow会向委托发送windowShouldClose：消息来询问，委托向消息发送者返回YES时窗体关闭，返回NO时则操作取消
如果要将某个对象作为委托使用，就需要在该类的接口部分中声明使用委托的协议，定义实现委托的方法的范畴就是一个好方法，而且，一个对象也可以作为多个类的委托进行操作，此时将使用与之相对应的多个协议
声明委托的协议时，基本上所有方法中都要指定@optional选项，持有委托的对象会在运行时检查该委托所能处理的消息，委托中没有实现消息不会被发送，所以，委托对象只需实现想要的处理方法即可，而不需要实现协议中记录的所有方法，也就是说，在之前的窗体例子中，只要实现windowShouldClose：方法就可以了
此外，由于某些情况下向委托发送消息是以存在运行回路为前提的，为此我们就需要注意生成命令行程序时的情况，例如，在Aplication框架中，NSSpeechSymthesizer类可以根据声音合成来播放文本，虽然通过命令行程序也可以执行播放功能，但向委托发送终止播放的消息时，如果没有运行回路，该消息则无法执行
一方面，自定义类虽然也可以有委托功能，但是实现起来并不简单，实现时需要使用respondsToSelector：等来检查委托是否可以处理吗某个消息
使用委托的程序例子可以参看第17章
    """},
  {'title' : '第十五章（2）' , 'message' : """
3、通知

3.1 通知和通知中心的概念

在面对对象的程序中，又是也需要将发生的事件通知给多个对象，例如，某个窗体代替别的窗体显示在前面时，未来执行这一行为，其他的窗体、面板或菜单的显示都要发生变化，这时，程序就需要将窗体在前面显示这一事件向关联的多个对象发出通知

在Foundation框架中，这种消息发送方式就称为通知，它的概念如图15-4所示：
￼
程序内提供了通知中心这个对象，期望取得通知的对象预先向通知中心注册期望取得的通知，通知有多种类型，分别以通知名来标记，也可以自定义新的通知名
某对象向通知中心发送请求，这称为发送（post）通知，于是，只要是注册过改通知的对象，都会获得通知中心推送的消息
消息发送目标，也就是在通知中心注册的对象，称为观察者（observer）对象在通知中心将自己注册为观察者时，会指定接收什么名字的通知以及什么选择器的消息，因为通知的接收方法是在观察者一方定义的，所以很容易实现的，而且也可以指定只接收特定对象发送的通知，观察者很多或者完全没有都没有关系
无论什么对象都可以自由使用通知的发送机制，而且不需要在通知中心注册，至于观察者对象时什么类的实例活着定义了什么样的方法，发送通知的对象都不需要知道，两者之间必须的共享的仅仅是通知的名字
这样的机制既不会讲题发送通知的对象和接收通知的观察者之间的独立性，又可以实现向多个对象发送消息
区别于发送者和接收者的一对一通信，某个对象向特定的多个对象发送消息，这样的通信形式称为多播，如果说一对一通信时电话或信件，那么多播就可以被比作时演讲会或邮件杂志，这里所说的通知的功能也可以被认为是多播的一种，此外，向非特定的多个对象发送消息称为广播，折合无线电播放或街头散发的传单是一样的，不需要选择特定的接收对象，有时多播也称为广播
使用通知的程序例子，在第17章中有详细介绍

3.2通知对象

向通知中心发送消息时，必要的信息会在NSNotification类实例中集中后发送给通知中心，这个对象就被称为通知对象，或者简称为通知，观察者从通知中心取得消息时也会取得附带的通知对象
通知对象的接口在头文件Foundation/NSNotification.h中定义
通知对象包含以下信息：
名字（name）
	用来识别通知的短文本，向NSNotification接口发送如下消息就可以取出名字
-(NSString *)name

对象（Object）
	和通知一起发送的附带信息的对象，多为发送通知的对象，也可以为nil，用如下消息取出
-(id)object

用户字典（userInfo）
	为了传递和通知相关的各种信息而使用的NSDicitionary字典，通过下面的消息取出，有时为nil
-(NSDictionary *)userInfo
因为向通知中心发送通知时会自动创建通知对象，所以没有必要自己创建，创建通知对象，可以使用如下任意一种NSNotification的类方法
+(id)notificationWithName:(NSString *)aName
				 object:(id)anObject
			      userInfo:(NSDictionary *)userInfo
	指定通知名、对象和用户字典，生成临时通知对象
+(id)notificationWithName:(NSString *)aName
				 object:(id)anObject
	指定通知名和对象生成临时通知对象，用户字典信息为nil

对象通常指定为发送通知的对象（即self）也可以设定为其他对象或nil，用户字典一般指定包含了通知相关信息的NSDicitionary接口，也可以指定为nil
通知名方面，可以自己决定新的名字，也可以预先在系统中决定，这些都在相关的类文档中有记载

3.3通知中心

通知中心使用NSNotificationCenter的类接口实现，通知中心的接口在头文件Foundation/NSNotification.h中定义

（1、默认的通知中心
各进城中都会预先准备一个通知中心，一般不需要自己创建，这就是默认的通知中心，可以使用如下类方法取得
+(id)defaultCenter

（2、通知的发送
可以使用如下任意一种方式来发送通知
-(void)postNotification:(NSNotification *)notification
	发送通知对象给接收该通知的通知中心，参数notififcation不能为nil
-(void)postNotificationName:(NSString *)notificationName
				    object:(id)anObject
				 userInfo:(NSDictionary *)userInfo
	指定通知名、对象和用户字典生成通知，然后发送给接收者的通知中心
	同样的方法postNotificationName：object：是将用户信息字典指定为nil后发送

（3、观察者注册
观察者对象要从通知中心获得消息，必须实现如下方法，观察者注册时，该方法的选择器也会同时注册
-(void) XXXXXXX:(NSNotification *)notification

观察者注册使用如下通知中心的方法
-(void)addObserver:(id)anObserver
		   selector:(SEL)aSelector
		       name:(NSString *)notificationName
		      object:(id)anObject
	对象anObserver在通知中心上注册为观察者，参数aSelector为包含anObserver的方法的选择器，在参数notificationName中指定期望发送消息的通知名，指定为nil时不会设定通知名相关的条件，只接收特定对象发送的通知时，参数anObject中需指定该对象，如果指定nil则表示没有设定发送源，两者都指定为nil时，则可以接收所有关于发送消息的通知

发送通知时，参数aSelector中指定的消息将被发送给观察者，参数为通知对象
仅指定特定的多个通知名的通知时，可以将各个通知名分别在通知中心注册，或者指定通知名为nil使其发送有关所有通知名的消息，并在接收后只处理那些必要的通知

（4、删除观察者的注册

作为观察者注册的对象也可以取消注册，者需要使用如下任意方法：

-(void)removeObserver:(id)anObserver
	删除参数anObserver为观察者的所有设定
-(void)removeObserver:(id)anObserver
			    name:(NSString *)notificationName
			   object:(id)anObject
	删除对指定的观察者、通知名和发送源的监视设定，参数为nil时则不会被作为条件使用

例如，从默认的通知中心删除对象obj为观察者的全部设定，如下所示：

[[NSNotificationCenter defaultCenter] removeObserver:obj];

从默认的头通知中心删除指定对象pobj为发送源的所有设置，可采用如下方式

[[NSNotificationCenter defaultCenter] removeObserver:nil name:nil object:pobj];

这里需要格外注意对象的内存管理
首先使用引用计数管理的情况下，通知中心在注册观察者时，并不保留（retain）观察者及发送源对象，所以，在释放这些对象之前，要确实从通知中心删除相关设置，如果不这样的话，指向释放对象的指针将成为空指针
使用垃圾回收机制时，观察者和发送源对象会使用弱引用在通知中心注册，所以，无论这些对象在通知中心是否注册，都有可能被回收释放，释放的指针也同时被清零，因此无需显式删除观察者的注册

3.4通知队列

使用发送通知的方法时，所以相关的观察者都会被有顺序地发送通知消息，这些处理终止后，发送方法也会终止，但这样的操作有时会产生问题，所以便引入了通知队列，通知队列是将通知对象临时存储在等待队列中，然后按照先入先出的原则（FIFO，First in First Out）向通知中心发送消息，通知队列时通过NSNotificationQueue类来实现的
这里解释一下通知队列的操作概要，详细介绍请参考相关文档
通知队列提供2种常见的通知操作

（1、异步发送
将通知追加到队列，然后在运行回路完成当前处理或者运行回路的输入都被处理完成后，再发送通知，通过使用该方法，就可以直接终止队列中追加的方法并进行下一项处理，这样一来，通知的发送就会在一连串处理之后再执行，这种方式也称为异步（asychronous）发送，一般的处理方式是同步（synchronous）发送
（2、合并相同的通知
通知队列中有相同的通知时，将他们合并为一个，以此来删除多余的通知，例如窗体内再次进行绘图操作的通知被从多处发送时，并不需要全部处理，重复的通知只处理一次会更加高效，通知名相同，通知源相同，或者2者都相同时，通知就可以被合并

专栏：通知名或异常名的定义

自定义使用通知名或异常名等时，一般都不直接使用字符串，而是用全局变量或宏名来定义，虽然看起来没什么用，但却是十分重要的
例如，假设某程序中有如下部分，他不能正确运行，而如果追究原因的话就非常麻烦，而且最终也注定是无用功（最后缺少i）但如果是变量名或者宏名，那么即使是拼写错误也会被编译器指出

[[NSNotificationCenter defaultCeneter] addObserver:self selector:@selector(showProgress:) name :@”anonymousProcessPriority” object:nil];
…

[[NSNotificationCenter defaultCenter] postNotificationName:@“anonymousProcessPriority” object:self];

此外，定义全局变量时，既可以节约内存，也可以快速进行字符串比较


4、反应链

4.1反应链概述

反应链（responder chain）是具有层级结构的GUI组件间自动发送消息的一种方式
从菜单中选择复制、取消 等时，或通过鼠标、按键输入时，根据位于最前端的窗体的不同，以及所选择的窗体GUI组件的不同，处理也不相同，虽然基本上时最前选择的GUI组件进行处理，而如果该组件不能处理消息，那么就可能由包含该组件的上层组件处理，此外，包含组件的窗体或委托或许也可以处理
处理消息的候补组件对象如算珠般串联在一起，将消息传递给这之间的某个对象时，在发现可以处理该消息的对象之前，会顺次向后面的对象转交该消息，这样的构成就称为反应链
在Mac os x中，按键、滑块、文本域等组件以及窗体的UIResponder类的子类，这些接口构成了反应链，当存在包含某组件A的组件B时，反应链通常按照A->B的方向传递消息，在Xcode中创建GUI时会同时生成反应链，可以使用程序进行连接，也可以在运行中动态变更，而且元素（回应）即使不是NSResponder（或者UIPesponder）子类也没有关系
在图15-5的窗体GUI组件层次中，文本输入部分和信息显示部分分别位于左右两侧，通过中央的间隔可以调整大小，文本输入部分包含在带有滚动功能的组件中，如果也包含配置用的组件的话，实际上就组成了图示的关系，窗体之外是NSView的子类，NSView同时也是NSResponder的子类，从图最前端的NSTextView接口到窗体，按此顺序就构成了像算珠一样的反应链，而如果指定了窗体的委托，那么就需要确认委托能够处理哪些消息
各窗体中，最初被发现消息的对象称为第一反应者，第一反应者基本上都是光标最近选择的对象
￼

4.2应用中的反应链

在Mac os x平台下，应用中的窗体分为处理应用的主要操作窗体和提供辅助功能的窗体，前者称为应用窗体，特别是读取文件信息进行显示或编辑的窗体称为文档窗口，其他窗体则包括打开面板、字体面板，以及表示各种信息的窗口等（图15-6）
在应用窗口或文档窗口中，显示在最前端的窗口称为主窗口，在包含面板等在哪的其他窗口中，最前的窗口则称为关闭窗口，主窗口也可以是关闭窗口
￼
反应链内的搜索，首先从关键窗口的第一反应者开始，关键窗口汇总无法应对找不到时，如果存在其他主窗口，主窗口的反应链也会按同样方式搜索
有时主窗口也不能处理时，消息最终会被传给NSApplication的接口，这样一来，当不能处理的消息就会被忽略，或者响起警告声
在iOS平台下，表示绘图区域的类UIView是其他GUI组件的超类，同时也是表示反应者的UIResponder的子类，接口由窗口（UIWindow类）、UIView类及其子类GUI组件由层次地重叠构成，UIKit会自动将任意一个按键或文本域作为第一反应者，第一反应者不能处理的消息，将沿着重叠的GUI组件，被有序地向窗口甚至引用程序（UIApplication类）传递
在第17章的示例程序中，也存在一些处理消息的对象由反应链构成来动态决定的地方
在Cocoa环境中，生成包含GUI的应用必须掌握反应链相关的知识，详细内容请参考“Cocoa Event-Handling Guide”“Event-HandlingGuide for  iOS”等参考文档
    """},
  {'title' : '第十五章（3）' , 'message' : """
第十五章（3）

5、消息传送

5.1 消息传送的构成

将消息发送给没有实现该消息方法的对象时，通常会出现运行时错误，但是，我们可以将不能被处理的消息转送给其他对象，这样的功能时可以实现的
下面将详细说明转送的结构
首先，蒋某消息发送到相应的接收者，这里，如果接收者没有实现应对该消息的方法，运行时系统就会发送如下消息给接收者

-(void)forwardInvocation:(NSInvocation *)anInvocation

这个方法在NSObject中定义，所有的对象都可以处理，在NSObject中，这个方法可调用如下方法
-(void)doesNotRecognizeSelector:(SEL)aSelector
	生成错误消息，表示异常NSInvalidArgumentException发生，无法处理参数选择器对应的消息

也就是说，只要接收者重定义了forwardInvocation：方法，当被发送不能处理的消息时，就可以将其转送给其他对象，或者自己执行错误处理

5.2消息转送需要的信息

正如下面所说的那样，方法forwardInvocation：的参数会被传入NSInvocation对象，而利用该对象包含的信息，就可以实现消息转送，NSInvocation的对象中保存了目标、选择器、参数等消息发送所必须的全部元素

下面是NSInvocation类的主要方法，NSInvocation的接口在头文件Foundation/NSInvocation.h中声明

-(SEL)selector
	返回设定的选择器
-(id)target
	返回设定的目标
-(void)invokeWithTarget:(id)anObject
	向目标参数发送表示接收者的消息，将消息的结构返回给源发送者

也可以自定义NSInvocation接口，或者重定义选择器、参数、返回值，这里不再赘述

5.3 消息转送的定义

使用上述的NSInvocation信息，forwardInvocation：就可以被重新定义，从而实现消息转送，但是，可以转送的仅仅是参数个数固定的方法，参数为不确定的列表的方法则不能转送
例如，调查不能处理的消息是否可以转送给对象fellow，当不能转送时则交由超类处理，可采用如下方式定义：

-(void)forwardInvocation:(NSInvocation *)anInvocation{
	SEL sel =[anInvocation selector];
	if([fellow respondsToSelector:sel])
		[anInvocation invokeWithTarget:fellow];
	else
		[super forwardInvocation:anInvcation];
}

再有，未来使运行时系统能够使用转送目的地的对象信息生成NSInvocation实例，必须重新定义返回的方法签名（method signature）对象
为了表示方法签名，定义了NSMethodSignature类，他的对象保存着方法的参数和返回值，但在消息转送或通信之外的情况下，程序中是不处理的
返回方法签名的方法在methodSignatureForSelector：和NSObject中定义，例如，转送目的地的对象如果是fellow，就可以按如下方式重新定义

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
	if([super respondsToSelector:aSelector])
		return [super methodSignatureForSelector:aSelector];
	return [fellow methodSignautreForSelector:aSelector];
}

然而，使用转送方法处理的消息不能被respondsToSelector：等调用，当需要知道该消息是否为目标对象可处理的消息时，必须重定义respondsToSelector：等方法

5.4禁止使用消息

如前所述，方法doesNotRecognizedSelector：表示消息不能处理时所产生的异常
利用此特性，在使用某个方法时就可以定义运行时产生的错误，一个典型的例子就是，当用超类定义的方法在子类中不能使用时，可以写下该方法及时禁止其使用
例如，想禁止使用方法setSize：时，可以采用如下方式定义，这里_cmd为方法的隐藏参数，表示方法的选择器，所以，写下@selector（setSize：）也是一样

-(void)setSize:(NSSize *)size{
	[self doesNotRecognizeSelector:_cmd];
}

5.5程序示例

这里定义一个行为类似于NSString子类的ReversibleString类，该类包含reversedString方法，返回反转后的实例变量的字符串，自身不能处理的其他消息则被转送给实例变量的字符串对象，而且使用ARC来管理内存

代码清单15-1 类ReversibleString的定义及测试

#import <Foundation/NSMethodSignature.h>
#import <Foundation/NSString.h>
#import <Foundation/NSInvocation.h>
#import <stdio.h>
#import <stdlib.h>

@interface ReversibleString :NSObject{
    NSString *content;
}
-(id)initWithString:(NSString *)string;
-(id)reversedString;
@end

@implementation ReversibleString

-(id)initWithString:(NSString *)string{
    if((self =[super init])!= nil){
        content =string;
    }
    return self;
}
-(id)reversedString{
    unichar *buffer;//将Unicdoe字符串反转
    int length,i,j,tmp;
    id reversed;
    if((length =[content length] <=0)){
        return @"";
    }
    buffer =malloc (sizeof(unichar) *length);
    [content getCharacters:buffer range:NSMakeRange(0, length)];
    for(i =0,j=length-1;i<j;i++,j--){
        tmp = buffer[i];buffer[j]=buffer[j];buffer[j] =tmp;
    }
    reversed =[NSString stringWithCharacters:buffer length:length];
    free(buffer);
    return reversed;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    if([content respondsToSelector:sel])//content可以对应时转送
        [anInvocation invokeWithTarget:content];
    else
        [super forwardInvocation:anInvocation];
}
-(BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector])
        return YES;
    if([self methodForSelector:aSelector] !=(IMP)NULL)
        return YES;
    if([content respondsToSelector:aSelector])
        return YES;
    return NO;
}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector])
        return [super methodSignatureForSelector:aSelector];
    return [content methodSignatureForSelector:aSelector];
}
@end

int main(void){
    char buf[100];
    id a,s,b,c,d,e;
    @autoreleasepool {
        scanf("%s",buf);
        s=[NSString stringWithUTF8String:buf];
        a=[[ReversibleString alloc] initWithString:s];
        b=[[ReversibleString alloc] initWithString:@"Reverse?"];
        printf("%s\n",[a UTF8String]);
        c=[[a reversedString] stringByAppendingString:b];
        printf("%s\n",[c UTF8String]);
        d=[[ReversibleString alloc]initWithString:c];
        e=[b stringByAppendingString:[d reversedString]];
        printf("%s\n",[e UTF8String]);
    }
    return 0;
}

类ReversibleString包含content实例变量，并向他转送消息，为了转送消息，方法forwardInvocation：和methodSignatureForSelector：都被重新定义了
执行结果显示，钙离子表示的是从文件中读入字符串，可见，除自定义的方法之外，还能够应对NSString方法UTF8String和stringByAppendingString

然而，类ReversibleString也没有实现NSString所有的接口方法，例如，NSString的初始化器就没有实现，由于在实例初始化完成前，实例变量content还没有准备好，因此是不能进行消息转送的

6、撤销构造

6.1撤销构造的概念

Cocoa环境中，未来能够撤销（undo）或重复（redo）之前的操作，准备了专门的类NSUndoManager，这里将将要说明使用NSUndoManager的撤销结构
取消之前的操作，可以通过记录操作前的状态来还原，或者执行域当前操作消息相反的操作NSUndoManager根据后者实现了撤销
NSUndoManager也是Foundation框架的类之一，接口在Foundation/NSUndoManager.h	中声明，将类方法alloc和初始化器init相组合就可以创建实例，下面将NSUndoManager的实例称为撤销管理器
在包含多个文档窗口的应用中，每个窗口都有一个撤销管理器，有的应用也可以只限定一个，然而，在使用APplication框架中NSDocument类来管理文档窗口的应用中，可以从NSDocument实例取得撤销管理器
应用中运行某种操作时，撤销管理器会同时记录包含你作用的消息，这就是撤销的基本结构，撤销管理器将这些消息有序地记录子啊撤销栈中，当有撤销请求时，就取出最新的记录内容执行
为了说明，下面几一个最简单的例子

-(void)increment:(int)n{
	撤销管理中记录[self decrement:n];
	value+=n;
}
-(void)decrement:(int)n{
	撤销管理器中记录[self increment:n];
	value-=n;
} 
由于者2个方法都包含你操作，因此执行该方法后就能取消已完成的方法，这样也就实现了撤销操作，但是撤销的方法在执行时，方法内也会执行“撤销管理器的记录”
实际上，在执行撤销时，一旦“撤销管理器的记录”被执行，NSUndoManager就会将该消息记录在重复用的栈上，重复和撤销时反义关系，在重复中执行的”撤销管理器的记录“保存在撤销栈中，所以，按上述方法实现时，就实现了撤销和重复操作
例如，假设方法increment：的调用（用数字标记）和撤销、重复的要求（用U和R标记）按如下顺序产生，此时栈状态如图15-7所示

+2  +3  +4   U    U   R 
￼

6.2在撤销管理器中记录操作

在撤销管理器中记录操作有2个方法，其中之一是使用如下方法记录撤销时本应执行消息的接收器、选择器及参数对象、域行为方法相类似的方法也会被记录

-(void)registerUndoWithTarget:(id)target
				    selector:(SEL)aSelector
				        object:(id)anObject

另一个就是使用如下方法，该方法的返回值为撤销管理器自身

-(id)prepareWithInvocationTarget:(id)target

例如，上例中记录[self decrement:n]的部分可以按如下方式书写，但是，这样一来decrement：消息就会在这里被处理完成，而上述方法的返回值原本就可以处理decrement：吗？实际上这里有些技巧

[[undoManager prepareWithInvocationTarget:self] decrement:n];

该方法中，撤销时的接收者在接收消息的同时，为了对下面收到的消息（此例中为decrement：消息）进行特别处理，还会进行些准备工作，具体来说就是，接收应该在撤销时发送来的消息，并将其作为NSInvocation对象完整保存起来，15.5节中为了转送消息而使用NSIvocation而这里使用NSInvocation则时为了保存，行为方法不限制消息形式
撤销管理器在请求撤销、重复时使用如下方法

-(void)undo;
-(void)redo;

在窗口中包含撤销管理器时，常见的方法是通过窗口委托来管理撤销管理器，此外，就如Application框架的类NSTextView那样，有的则各自包含撤销管理器，所以从菜单等发出撤销/重复请求时，该消息就会被通过反应链传递，第17章的立体中又简单的撤销功能的实现，请参考
撤销管理器中还有其他方法，如清除栈，将多个方法调用合并为一个撤销操作来记录，关于这些，本书不再一一介绍，详细信息请参考“Undo Architecture”等参考文件
    """},
  {'title' : '第十六章（1）' , 'message' : """
1、应用束

1.1应用束的构造

Cocoa应用会将执行文件或必要的资源格式保存在一个委托结构中，者称为应用束（Application bundle）、应用包装（wrapper）或应用包，资源就是应用执行时所必须的图像、声音、文本、设置信息等文件，像这样，将几个文件或目录以确定形式保存到目录结构中，然后在作为一个集合进行处理，在Cocoa中时很常见的方法，这样的结构一般称为束
图16-1显示了应用束的基本构造，通常，在使用Xcode进行开发时，应用束会自动产生，程序没有必要逐一指定目录中的结构，此外，图中的概况在将来可能会发生变化，但实际中的差异会被使用束的NSBundle类所吸收，因此写代码时不需要太在意这一点
￼
通过上图可以看书Mac os x中产生了多个子目录，而iOS则并不明确区分存放执行文件及各种资源，二者都有Info.plist文件，该文件为属性列表格式，记载着应用相关的重要信息，此外PkgInfo文件中还记录了macOS文件类型及创建器类似的信息

1.2nib文件和各语言资源

使用Xcode（Interface Builder）生成的GUI定义被写到nib文件中，nib文件的后缀为nib，也就是Next Interface Builder，是NeXTstep的由来，在nib文件中，应用的菜单和窗口组件的配置等信息会被归档化，并在执行时被动态读入，根据用途或目的的不同，包含多个nib文件的应用也很常见
nib文件的后缀名为nib或xib，xib文件为XML格式文件，两种后缀名的文件内容相同，在构建应用时，会作为带有后缀nib的资源文件被保存在应用束中
从Xcode4.2起，iOS应用中开始可以使用storyboard文件，因为Storyboard是以场景移动为中心来构造GUI的，所以比较适合变现实变处理这样的应用的架构，在各场景内部，对象之间的关系和nib文件相同，在应用被构建的同时，Storyboard内部也会变成nib文件资源
在使用nib文件、消息、用于说明的文本及突破等资源文件时，用户可能会需要根据语言来切换资源，另一方面，图片图像及效果声明文件等与资源也被期待着可以在各语言间共享
与语言无关的共享资源在Mac os x系统中被放置于Resources目录下，在iOS系统下则被放置在应用束目录下。根据所选择的语言种类来切换的资源被放置于“语言名.lproj”目录下，语言名采用ISO语言编码标准，使用en表示英文，用jp表示日本（见下文的Column）后缀名“lproj”来自于language project 并从NeXTstep使其开始使用
应用在运行时，会在运行环境中查找选择的（或是高优先度的）语言子目录，并使用其中的资源，NSBundle类执行资源检索，因此程序就不需要记录指定语言的编码
使应用能够对应特定语言的进程，我们称之为本地化，在Cocoa应用中，如果能在编码时使之对应多种语言，那么， 之后只需子啊应用束中追加特定语言的资源就能简单地实现本地化

专栏：指定语言和地区

存储个语言资源的目录名，基本上使用ISO 639-1标准中指定语言的两个字母，有时也会根据需要将地区代码和本地ID组合起来使用，下面例举几个重要语言的指定
在英语中，如果想要区分英国方言和美国方言，可以指定为en-GB en-US
￼

1.3信息文件的主要内容

应用束内的信息文件Info.plist以属性列表的形式将应用执行所必需的信息记录起来，当使用Xcode创建工程时，会使用“工程名-Info.plist”这样的文件名来进行文件的编辑。构建应用时，应用束中就会基于该文件生成Info.plist
使用应用束时，信息文件内关键词CFBundleIdentifier指定的字符串称为应用标识符（application identifier）该标识符常被用来系统中寻找相应的应用程序，为了不产生重名，推荐使用Java的包定义方式，例如com.apple.iPhoto
主键及其含义如表16-1～16-4所示，键的前缀文字LS是”Launch Services“的意思，键的含义和相关设定请参考“Information Property List Key Reference”等
属性列表中实际的键值和Xcode中表示的字符串有时是不同的，例如，之前所述的键CFBundleIdentifier可能就会被表示为“Bundle indentifier”（下面称为Xcode名）为表示键值原本的意思，在Xcode中，可以右击并选择上下文菜单中的“Show Raw Key/Values”
￼
￼
￼

1.4通过NSBundle访问资源

NSBundle是为各种束提供接口的类，可以从指定的束中搜索有GUI定义的nib文件、图像、声音、加载代码等，下面展示了几个主要方法，详细情况请参考相关文档，NSBundle的接口在头文件Foundation/NSBundle.h中记载：

+(NSBundle *)mainBundle
	程序所包含的应用束也称为主束，该方法返回与主束的路径相对应的对象，不能识别应用束时返回nil
+(NSBundle *)bundleWithPath:(NSString *)path
	返回path指定路径的束对象，没有path可访问的束时返回nil，此外也有使用NSURL指定位置的方法BundleWithURL
-(NSString *)bundleIdentifier
	返回信息文件（Info.plist）中指定的应用程序名
-(NSDictionary *)infoDictionary
	将信息文件的内容作为字典对象返回
-(id)objectForInfoDictionaryKey:(NSString *)key
	在信息文件（Info.plist）中，返回以参数key为键值的对象，可能的话将其本地化后返回

NSBundle实例表示具体的束，如应用束，该实例可以寻找束内的资源
-(NSString *)pathForResource:(NSString *)name
				     ofType:(NSString *)extension
	在接收者的束内，返回name指定的名字和extentsion指定的有后缀的资源路径名，文件没有后缀时麻将extension指定为nil或@“”，找不到文件时返回nil，同样，也有使用NSURL返回位置的方法URLForResource：withExtension：

上面的方法pathForResource：ofType：首先会在束内顺序查找根据运行环境选定的语言子目录，如果找不到就在Resources下面（iOS时在应用束下）寻找，这和使用NSBundle的查找资源的方法是一样的
例如，可按如下方式读取应用束内的SoCool.jpg图像，并将其作为NSImage（操作图像的类）的实例使用，图像文件在Resources下时也可以被特定语言本地化，程序方面不用担心这一点

NSImage *coolImage =nil;
NSBundle *bundle =[NSBundle mainBundle];
NSString *imgPath=[bundle pathForResource:@“SoCool” ofType:@“jpg”];
if(imgPath)
	coolImage=[[NSImage alloc]initWithContentsOfFile:imgPath];

获取保存资源的路径可以采用resourcePath方法，但是不推荐使用如下方式获取资源路径，当不能本地化时，也不能使用后述的指定ios资源的方法

rpath =[[NSBundle mainBundle] resourcePath];
imgPath =[rpath stringByAppendingPathComponent:@“SoCool.jpg”];

从束中获取资源路径或URL的方法不只上述一种
此外，在Mac os x平台中，可以利用apthForImageResource：方法获得图像路径，他是Applictaion框架中被作为范畴添加到NSBundle中的方法，在AppKit/NSImage.h中声明，其他nib文件或声音文件的获取方法请参考“NSBundle Additions Refrerence”

1.5 iOS中资源的访问

如前所述，iOS中也可以使用NSBundle方法来访问资源，但是，因为iOS有特殊的后缀，所以这里先介绍一下其概要
在iOS中，只要开发一个应用包，iPhone和iPad iPod 等就可以使用，这时，为了适应所使用的设备，nib文件的内容和图像的大小就必须要改变，但是人们又不想为各种设备分别进行编码工作，于是就可以使用这样一种指定方法，即根据所使用的设备来自动选择资源或参数

（1、按设备准备任意资源
在iOS中，当束的检索请求被指定为“文件名.后缀”这样的文件时，就会搜索如下形式的文件
文件名～设备.后缀

设备部分就可以指定以下几种形式
iPhone：表示iPhone或iPod
iPad ：表示iPad
例如：如果束内有“Above~iphone.nib”和“Above~ipad.nib” 那么，iPhone在运行中要加载“Above.nib”，实际上就加载了 “Above~iphone.nib”，当然，如果只有”Above~nib”那么也只能加载它了，该记法在图像、声音等其他资源中也可以使用

（2、准备高像素图片
可以添加高像素的图片，iPhone4的像素是以往的2倍，使用iPhone4读入图像时，如果有高像素文件，那么能够支持自动读入的话就会十分方便，为此，高像素图片可使用如下文件名设置

文件名@2x.后缀名
文件名@2x~设备.后缀名（兼容上述设备指定时）

UIKit框架中使用类UIImage类处理图像，该类可以使用如下方法检索并加载主束内的图片文件，生成包含图片的实例

+(UIImage *)imageNamed:(NSString *)name

在iPhone4执行应用的过程中，当给该方法指定了“beyond.png”文件名时，如果主束中存在beyend@2x.png文件，他们就会被自动读取

（3、使用信息文件的键值字符串指定设备
未来和设备相匹配，可以详细设置信息文件中读入的信息
例如，信息文件的键值UIInterfaceOrientation会在应用启动时指定接口适用的类型（表16-4）信息文件中记录的内容在各个设备上通常是共享的，如果只想在iPad中改变设置，可以使用如下字符串作为键值

UIInterfaceOrientation~ipad

像这样，在一般的键值字符串后面加上后缀～设备，即可表示仅此设备适用，设备部分可以指定如下值：
iPhone：表示iPhone
iPod ：表示iPod
iPad ：表示iPad

关于iOS资源的详细内容，请参考“iOS Application Programming Guide” “iPad Programming Guide”” Resource Programming Guide”等参考文档

1.6通用二进制

通用二进制时苹果公司的专门术语，是为了能在多个操作系统不同的CPU上运行二生成的执行文件形式，在PowerPC的Mac以及Intel的Mac中可以运行Mac os x，iOS平台下，也希望能适配各种处理器版本不同的iPhone手机，远离很简单，只需将不同CPU所对应的机器指令保存在一个文件中，然后在执行时选择合适的来运行即可，同样32位及64位所对应的机器指令也可以包含在通用二进制文件中，该技术在拥有4个不同的运行平台的POPENSTEP中已经得到了实现，称为MAB（Multi-Architecture Binary）或胖二进制（fat binary）
此外，通用应用这个术语指的是仅用一个应用包就可以在多个不同的环境下运行的应用，为此，束内保存了面向不同环境的资源和设定信息，在很多情况下，执行文件就是通用二进制
应用通常有Xcode构建，但也可以由命令行生成通用二进制，下面将简单说明一下其方法
首先生成某个框架专用的执行文件时，编译器使用-arch选项，例如，编译pri.c源文件来生成面向Intel32位机器的执行文件时，可按如下方式，编译器使用什么样的机器都没有关系（“%d”位命令提示符）

% clang -arch i386 pri.c

通常会生成a.out执行文件，这里，通过为lipo命令指定-info 选项，就可以查看它包含什么样的运行指令，如下所示

% lipo -info a.out
Non-fat file:a.out is architecture :i386

生成同时面向32位及64位指令的执行文件时，重复指定-arch 选项即可，而如果指定8.4节中介绍的-m32 或-m64选项，就只能生成其中一方的代码指令

-arch i386 -arch x86_64 pri.c
%lipo -info a.out
Architectures in the fat file :a.out are : i386 x86_64
 基本方法就是在编译时面向各架构分别制定编译选项，所以，源程序中如果有编译警告，指定的框架数就可能会反复显示
在Mac os x 10.6之前的版本中可以生成面向PowerPC的指令代码（架构指定为ppc），而在10.7后就不行了，因为32位代码指令中不可以使用现代运行库，使用了ARC等新功能的源程序不能编译，所以，在Mac os x 10.7中，通用二进制的优势并没有显露出来，而且指定编译器架构i386或x86_64时，也可以分别利用__i386__或__x86_64__这样的宏定义
iOS平台的机器使用ARM架构的CPU，因为编译时指定的架构师armv6或armv7，所以在生成iPhone和iPad上执行的通用应用时，要同时指定armv6和armv7（因为有兼容性，所以单指定armv6时也能运行）除此之外还有宏定义__arm__
上述查看执行文件时使用的命令lipo，原本是被用来整理面向各个架构的执行代码并生成通用二进制的，相反也可以被用来抽取其中的一部分代码，在生成通用二进制的情况下，编译时可以只指定必要的-arch选项，此外也可以生成面向各种框架的执行文件，然后再使用lipo命令对其加以整理，详情请参考在线手册

2、加载nib文件

2.1nib文件实例化
应用在执行打开多个窗口，或者打开新面板时，优势会从保存GUI组件间关联及配置的nib文件中读取信息，下面将简要说明一下这个处理过程，因为nib文件的生成方法不在本书的研究范围内，所以不在此做说明
请看图16-2，假设图右侧的nib文件部分时设定选项参数的面板，这个对象或实例并不是在应用启动时进行实例化，而是在必要时才进行
￼
nib文件定义了GUI组件间的通信消息 其中必须有一个称为所有者的对象，途中吗ing位mediator的对象就承担着该角色，所有者就是连接nib文件内的对象群和外部事件的桥梁，应用方面的咨询及nib文件内对象的访问基本上都是通过所有者来传达的
图中，myController对象会生成penalCtrl，同时显示nib文件的加载
加载nib文件后，其中定义的对象会被实例化，但是所有者不会被实例化，所有者使用的对象在加载nib文件前就存在，像这样，所有者可以根据与nib文件外对象的关系来设定，也可以确定nib文件中的对象，两者可以同时存在
加载nib文件就昂对象实例化与在13.2节中说明的解档基本相同，nib文件是对象图的归档，所有者的作用就相当于根对象，但是，nib文件中也可以生成无指向的指针对象，在这内存管理上有时会出现问题，这一点在下面的说明也会提到

2.2在Mac os x中加载nib文件

在Mac os x中加载nib文件通常使用如下方法
和其他资源一样，如果有面向语言的目录就从中查找，这时NSBundle的类方法，在Application框架中被定义为范畴，接口在Application/NSNibLoading.中声明

+(BOOL)loadNibNamed:(NSString *)aNibName
			     owner:(id)owner
	在束内查找字符串指定的nib文件（不需要后缀名），并将所有者对象owner实例化，如果失败就返回NO

参数owner指定的对象必须与nib文件内设定的类相同，如图16-2，将myController生成的对象panelCtrl指定为参数owner来加载nib文件，这样一来，nib文件内的对象就会被实例化，panelCtrl就开始作为nib文件内的mediator而发挥作用
这里，首先详细说明内存的管理
在使用引用计数的管理方式管理内存时，nib文件内的所有（除了所有者）对象都会被引用计数置为1并被实例化，接着，构造对象间的引用关系，被其他对象持有的对象则通过autorelease来释放所有者关系，如果nib文件中存在没有被引用的关系，那么最终便只有该对象不会被释放而保留着，所以就需要使用其他方法来释放内存
使用垃圾回收时，所有者强引用的对象因为可以访问所以没有任何问题而如果nib文件中存在没有被引用的对象，那么该对象在实例化后就有被释放的危险

2.3在iOS中加载nib文件

iOS中NSBundle使用下面的方法，和其他资源同样，如果存在面向所使用的语言的目录就从中查找，该方法用UIKit框架的范畴定义，接口在UIKit/UINibLoading.h中声明

-(NSArray *)loadNibNamed:(NSString *)name
				  owner:(id)owner
			        options:(NSDictionary *)options
	在束内炒炸字符串命名的nib文件（没有后缀名），并将所哟着对象owner实例化，参数options中可以指定选项，而且一般都传入nil，在nib文件内，没有被其他对象包含的对象（顶级对象）将用数组保存并返回

在iOS中，将nib文件中的所有对象（所有者除外）的引用计数都置为1并进行实例化，接着，构筑对象间的引用关系，被其他对象持有的对象则通过autorelease来释放所有者关系，使用键值编码的setValue：forKey：方法（第20章）来设定对象出口，需要明确出口所使用的实例变量的引用、存储方式时，请准备设置或声明属性
nib问津中如果存在没有被引用的对象，则将其保存在返回数组中，无论使用什么方法，我们都要确保内存释放

2.4nib文件内的包含循环

使用ARC管理内存时，nib文件内的对象之间容易形成包含循环，这点一定要注意避免
基本上nib文件就是一个树形结构，其中，所有者时根节点，并合其他组件和对象互相关联，首先，所有者引用顶层对象（必能称为其他对象组件的对象）时使用强引用，窗口上配置的组件有层次关系，保持着树形构造，另一方面，程序新增的自定义对象，可以将这些对象作为出口自由引用，因此，自定义对象包含的出口原则上应该通过弱引用才能使用
框架提供的类中，有些没有对应弱引用，由于这样的类会使用__unsafe_unretained 修饰的实例变量或assign属性的特性，因此一定要注意不要有空指针，不管是否有弱引用，在释放对象前，都需要将引用其他对象的实例变量赋值为nil，这点请注意

2.5nib文件内对象的初始化
nib文件内包含的对象如果实现了如下方法，在实例化后该方法就会运行

-(void)awakeFromNib
	从nib文件中读出，在完成实例化、出口及访问的链接口调用该方法
该方法在Application及UIKit框架中被声明为非正式协议，头文件分别为NSNibLoading.h和UINibLoading.h因为是非正式协议，所以任何类都可以实现该方法并记录初始化流程

2.6启动应用

应用最先读入的nib文件中，保存着菜单等运行应用所需要的重要信息，这称为主nib文件，信息文件（表16-2）中也有文件名，该文件在应用启动后运行回路（见15.12节）启动前被读入
加载主nib文件以及启动运行回路可通过Mac os x中NSApplication及iOS中的UIApplication类来完成，NSApplication类是Application框架的类，接口位于AppKit/NSApplication.h中，UIApplication类是UIKit框架中的类，接口在UIKit。UIApplication.h中记述
该实例在应用启动后仅被生成一个，除运行回路之外，还负责管理应用的各种资源，如菜单、窗口、应用的隐藏或终止等
未来访问这个唯一的实例，NSApplication类与UIApplication类都适用sharedApplication类方法，该方法是15.2节中也曾描述过的典型的单体设计模式

+(NSApplication *)sharedApplication(NSApplication 类)
+(UIApplication *)sharedApplication(UIApplication 类)
	返回应用类的唯一一个实例对象
	使用NSApplication时，如果实例不存在就生成实例，并执行必要的初始设置

为了生成Mac os x应用，在Xcode中选择Cocoa应用后，如下main函数就会自动生成（Xcode4.2版本）

#import <Cocoa/Cocoa.h>
int mian(int argc ,char *argv[]){
	return NSApplicationMain(argc,(const char **)argv);
}

函数NSApplicationMain（）为Application框架提供的函数，内容如下所示，这里MSApp为表示NSApplication实例的全局变量

int NSApplicationMain(int argc,char *argv[]){
	[NSApplication sharedApplication]; //1
	if([NSbundle loadNibNamed:主nib名 owner:NSApp]) //2
		[NSApp run]; //3
	exit(0);
}

在开始执行后，main函数开始运行，1生成NSApplication实例，2加载主nib文件，3启动运行回路
另一方面，在Xcode中，选择面向iPhone或iPad的应用对象后，就会自动生成如下main函数

#import <UIKit/UIkit.h>
#import “AppDelegate.h”

int main(int argc ,char *argv[]){
	@autoreleasepool{
		return UIApplicationMain(argc,argv,nil,NSStringFromClass([AppDelegate class]));
	}
}

函数UIApplicationMain（）时UIKit框架提供的函数，第三个参数需要使用字符串指定UIApplication或其子类名，如果为nil则选择UIApplication，第四个参数需要指定被作为UIApplication的委托（参考15.2节）使用的类名，AppDelegate时同样生成的委托类，函数UIApplicationMain（）的内部虽然被隐藏了，但基本上和NSApplicationMain（）同样
此外，应用中所固有的各种初始化设置，不需要方法main函数中，而是应该写到NSAppliaction和UIApplication的委托对象内，应用启动后，由于通知启动完成的消息会被送给委托对象，因此应在委托内部书写，而应用切换时或应用终止前想要执行的操作也可以写入，详情请参考NSApplicationDelegate协议或UIApplicationDelegate协议的参考文档

    """},
  {'title' : '第十六章（2）' , 'message' : """
3、iOS的文件保存场所
 
3.1主要目录及功能

在iOS中，未来安全起见，应用间的文件交换等会收到限制，为此，与个人电脑环境不同，文件保存的场所也被局限在了各应用所分配的特定场所中，该场所在应用安装时已被决定，称为应用的home目录，应用程序包及生成的文件被保存在home目录下，删除应用时会将其一并删除
应用的home目录下设置着主要目录，各目录具有不同的功能，文件能够长期保存的场所，与iTunes同步的场所，以及备份场所的路径名都是固定的
在这些文件夹中创建的文件，必须有应用程序来管理，不需要的文件如果不被删除，设备的内存容量就会变得紧迫

home/应用名.app/
	应用束本身存放在这里，因为有署名所以不能改变
home/Documents/
	应用生成并保存文件的场所，与iTunes连接时启动备份，而且，将信息文件的键值UIFileSharingEnable设定为YES后，就可以通过iTunes使文件和电脑同步
home/Library/Preferences/
	应用设定（16.4节中介绍的用户默认）被写入，与iTunes不会备份
home/Library/Caches/
	能够将应用临时使用的信息作为文件保存在这里，在下一次启动时加载可以利用的操作历史或操作过程等信息，但是，在设备还原等时可能会随之消息，iTunes不会备份
home/tmp/
	能够将应用临时使用的信息作为文件保存在这里，在应用不运行期间可能会被系统释放

3.2获取目录路径

在获取上述目录中的Documents和Caches的路径时，推荐使用Foundation框架的函数NSSearchPathForDirectoriesInDomains（）函数和使用的参数Foundation/NSPathUtilities.h中声明

NSArray * NSSearchPathForDirectoriesInDomains(
	NSSearchPathDirectory directory,
	NSSearchPathDomainMask domainMask,
	BOOL enpandTilde
)

该函数本来是Mac os x专用的，形参参数的组合在iOS中可能没有意义，而且，由于返回数组中只保存有一个路径，所以请使用objectAtIndex：方法将首部的元素取出使用
第一个形参中指定目录的种类，未来获取Documents和Caches的路径，请分别指定参数NSDocumentDirectory和NSCachesDirectory无论哪种情况，都请指定第二个形参味NSUserDomainMask，第三个形参为YES
而且，tmp目录的路径可使用下面的函数获取
NSString *NSTemporaryDirectory(void)

然而，可以使用这些函数取得的目录路径不一定存在，必要时需要由程序创建，为了查找路径是否存在或创建路径，可以使用Foundation框架的NSFileManager类，使用类方法defaultManager获的唯一的实例，并使该实例负责指定路径相关的操作，这里不再详细讨论

4、用户默认

4.1保存设定值

易用的应用会保存曾经的设定值、配置窗体等，并在下次执行时直接使用之前的设定，这样的设定值包括环境设定窗体中的设置，以及运行中保存的用户选择的内容等
在Cocoa应用中，未来保存这些设定而使用了一种通用结构-用户默认（user defaults）或者称为默认数据库，类NSUserDefaults提供了访问用户默认所需的接口
用户默认会访问与字典对象相同的字符串键值这样的信息，Mac OS X中，被记录的信息被保存在～/Library/Preferences/目录下的属性文件中，保存用户默认的文件名为应用名加后缀名“plist”
iOS中用户默认被保存在应用的根目录下的Library/Preferences/目录中
iOS中可以通过应用来改变设定值，也可以从系统工具“设定”中构建可设定的应用，为此，应用需要包含Settings窗体，详情请参考“iOS Application Programming Guide”等

4.2默认域

用户默认可以被分为多个组考虑，这些组称为域或者默认域（defaults domain）在域中，有的将内容保存在文件中并在之后继续使用，二有的则尽在应用启动时存在，下面将详细说明
（1、应用域
	使用属性列表管理的应用固有的设定值的集合，该设定值的饭集合称为应用域，域名中使用应用标识名（见16.1节）
（2、全局域
	使用者使用账户设定的各个应用共享的设定值，例如，所使用的语言，是否附加文件名后缀，以及当文字大于多少时将其平滑表示等，都设计多方面的因素，域名为NSGlobalDomain
	该域即使在iOS中也有效，可以获得设定的语言或键盘信息
（3、形参域
	Mac OS X的Cocoa应用可以从终端命令行启动，例如，虽然文本编辑器在/Application/TextEdit.app的路径下，但用命令直接指定应用束内的执行文件也可以启动

% /Application/TextEdit.app/Contents/MacOS/TextEdit

此时，应用域或全局域中包含的设定值可以作为参数来指定，例如，全局域中名为AppleAntiAliasingThreshold的键值表示将大于某一数值的文字平滑表示，在启动时可按照如下方式使用（因为太长所以显示为两行，实际上是一行）

% /Application/TextEdit.app/Contents/MacOS/TextEdit-AppleAntiAliasingThreshold 15

于是，在该文本编辑器中，15点以下的文字都不会被平滑表示，这时因为全局域的设定值是通过参数指定来临时传入的，所以通常在重新启动时就会恢复原值
像这样，参数指定的设定值组就称为参数域（argument domain）域名用NSArgumentDomain表示，且不能保存在文件中，iOS不使用该域
（4、语言域
	指定使用语言时，会生成该语言名（例cn）为域名的临时域（不保存文件）
（5、登陆域
	用户尚未设定应用的各种设定值时使用的默认值集合，域名为NSRegistrationDomain，且不被保存在文件中

当应用使用NSUserDefaults类从键值中查找对应的设定值时，会按如下顺序查找上述5个域，并使用最先找到的值

1、参数域
2、应用域（保存在文件中）
3、全局域（保存在文件中）
4、语言域
5、登陆域

如果各种设定值都需要默认值，可以将键和值的集合以字典方式组织，并在应用初始化时在登陆域中登陆，因为登陆域查找在最后执行，因此，当其他域都不能登陆时，就只能使用默认值

4.3查找用户默认的工具

Mac OS X平台下，用户默认除了在各个应用中使用外，还可以通过直接编辑属性列表，或使用命令行工具defaults来进行访问，只在终端上输入defaults就可以看到使用方法，也可以是使用main命令查看帮助手册
通过下面的方式可以全部显示某个应用域的内容，域名为应用的标识名，这里指定“-globalDomain”或NSGlobalDomain就能显示全局域的内容

% defaults read 域名

想要查看某个键的值时可通过如下方式

% defaults read 域名 键

不使用read而使用write或delete时，虽然可以写入或修改，但如果胡乱修改用户默认，就会导致应用无法正常运行等问题，所以一定要注意，而如果方法来这样的状况，就要删除应用域对应的文件并重新启动应用

4.4NSUserDefaults概要

下面将简要说明一下未来访问用户默认而提供的NSUserDefaults类，类接口在Foundation/NSUserDefaults.h中记述 全局域、参数域、登陆域的域名字符串分别为NSGlobalDomain、NSArgumentDomain、NSRegistrationDomain变量

（1、取得实体对象
NSUserDefaults只会生成一个实例并使用，可以使用下面的类方法来取得该实例对象
+(NSUserDefaults *)standardUserDefaults
	最初调用时将实例初始化后返回，一般情况下，自第二次调用起，会返回同一个实例

（2、取出键对应的值
要取出键对应的值，可在NSUserDefaults实例中使用如下方法，如前所述，键值是通过在多个域中查找而得到的

-(id)objectForKey:(NSString *)defaultName
	取出键值对象
	返回值为属性列表对象，即字符串、数据、日期、数组或字典对象，没有键值时返回nil
-(NSString *)stringForKey:(NSString *)defaultName
	将键值作为字符串对象取出，取出的对象不是字符串或没有键值时返回nil
	同样，取出数据对象、数组对象、字典对象、URL时，可以分别使用下面的方法
	dataForKey: arrayForKey:  dictionaryForKey:  URLForKey:	 
-(NSArray *)stringArrayForKey:(NSString *)defaultName
	取出包含字符串对象的数组对象，取得的结果不是字符串对象以及不存在键值时返回nil
-(NSInteger)integerForKey:(NSString *)defaultName
 	取出键对应的对象，并返回其整数值，不存在值时返回0
	同样，取出对象后返回实数值、双精度值、布尔值的方法分别是：
	floatForKey：、doubleForKey：、boolForKey：

（3、指定键并设置或删除值
在应用域中设置键值

-(void)setObject:(id)value
		forKey:(NSString *)defaultName
	在应用域中设置键对象，value如果不是属性列表可以处理的对象，则不能保证该处理的正确性
-(void)setURL:(NSURL *)url
	     forKey:(NSString *)defaultName
	在应用域中设置键对应的NSURL实例
-(void)setInteger:(NSInteger)value
	         forKey:(NSString *)defaultName
	在应用域汇总设置参数的整数值
	同样，设定实数值、双精度值、布尔值的方法分别是
	setFloat：forKey：、setDouble：forKey：、setBool：forKey：
-(void)removeObjectForKey:(NSString *)defaultName
	从应用域中删除键对应的入口

（4、设定默认值

-(void)registerDefaults:(NSDictionary *)dictionary
	在登录域中添加泊村默认值的字典对象，指定的键值没有在应用域等其他域中登录的情况下，将登录域作为默认值使用

（5、取出域内容

-(NSDictionary *)dictionaryRepresentation
	将所有的域内容作为字典对象取出

（6、在文件中显示设定内容

-(BOOL)synchronize
	将域内容写入到对应的属性列表文件中，因为该方法通常为自动调用，所以除了在应用终止时需要在文件中显示调用外，其他情况下都不用调用，处于某种原因不能写入文件时，返回NO；

5、应用的本地化

5.1消息的本地化

使用束结构可以将程序显示的消息与各种语言相对应，ObjectiveC的源程序，没有必要输入中文字符串
为此，首先需要生成Localizable.strings文件，并将其保存到各语言对应的目录（语言.lprog）中，文件名也可以为别的名字，不特别指定时使用Localizable.strings
Localizable.strings文件时将键字符串用等号连接成一对，并在结尾设置分毫，无论是键还是值，一般都用“”括起来，也可以省略值，不过这是也要同时删除等号，值即使被省略，键本身也仍然会被当成入口值，此外，也可以用/*…*/的形式来书写命令
键字符串一般使用ASCII码范围内的字符串来保存消息（一般为英语）值字符串中记录着使用了目标语言（中文等）字符集的消息，文件一定要使用UTF-16编码，仅使用ASCII码范围内的字符就可以记录全部时（英语）保持ASCII编码方式即可
下面来看一个Localizable.strings文件的简单用例

面向英语的Localizable.strings文件

/* File does not exist */
“File does not exist”;
/* Do you want ? */
“Do you want ?” = “Do you want to do it , Really ?”;
/* OK */
“OK”;

面向中文的Localizable.strings文件（UTF16编码）

/* File does not exist */
“File does not exit ” =“ 文件不存在 ”;
/* Do you want ? */
“Do you want ? ” = “ 当真可以执行吗？”;
/* OK */
“OK ”;

应用本身的束（主束）的NSBundle对象，通过使用下面的消息，可以取得键值字符串

-(NSString *)localizedStringForKey:(NSString *)key
						value:(NSString *)value
						table:(NSString *)tableName
	在束内查找参数tableName指定的名字及含有后缀名”.strings”的文件，返回参数key指定的键值字符串，当找不到对应的键时，参数value指定返回值
	tableName为nil或@“”时，使用Localizable.strings

为了更方便地获得本地化的字符串，定义了使用上述方法的宏（头文件Foundation/NSBundle.h）从主束中取出字符串时，使用该宏十分便利
NSLocalizedString(key,comment)
	在主束内查找文件Localizable.strings返回参数key指定的键值字符串，ObjectiveC方式下不使用comment，字符串对应的注释可以自由书写
NSLocalizedStringFromTable:(key,tbl,comment)
	在主束内查找参数tbl指定的文件，返回参数key指定的键值字符串

上述Localizable.strings的例子中，“File does not exist”对应的本地化字符串可以通过如下方式获得

NSSting *msg=NSLocalizedString(@“File does not exist”,NO_FILE);

而且，这些在源文件写的宏，可以使用命令genstrings生成Localizable.strings
在命令行中输入genstrings且不加参数，将显示帮助信息

5.2本地化指针

使用中文与英文不同，显示消息不能用中文编码，即使只构建中文应用时也需要有Localizable.strings该文件以及定义了GUI的nib文件、帮助等，包含中文的文件全部都用过被保存在zh_CN.lproj目录下
将英语、法语等多语言的应用本地化为中文时比较容易的，基本上只需生成各国语言子目录和Localizable.strings、nib文件及各种资源的中文版，并追加zh_CN。lproj就可以了
如果仅仅是英语应用，则不需要担心本地化，包括英语在内，面向各语言的子目录和Localizable.strings基本上都不是必须的，但是，这样的应用被认为没有国际化（internationlize）
相反，将这样的应用在时候进行国际化或本地化是非常困难的，因为消息是写在源程序里面的，所以必须要使用NSLocalizedString（）等来修改
虽然域本地化相关的详细设定和目录结构的生成可交给Xcode来完成，但我们需要了解本地化设定和实际生成的应用结构之间是如何对应的

专栏：本地化应用名

Mac的Finder及iPhone iPad的本地界面中显示的应用名可以设为各国语言，例如，这里我们来看一下如何将“SpaSearch.app”改为“温泉搜索（临时版）.app”
首先，信息文件（Info.plist）内应用名使用了应用束的名字，此时，需要书写CFBundleDisplayName和CFBundleName键（参考表16-1）

<key>CFBundleName</key>
<string>SpaSearch</string>                      < ——
<key>CFBundleDisplayName</key>		          | 
<string>SpaSearch</string>			        < ——

然后，面向各语言的子目录中生成InfoPlist.strings文件，该文件形式上与Localizable.strings相同，并用Unicode编码，子目录zh_CN.lproj（或zh.CN.lrog）下的InfoPlist.strings编辑如下

CFBundleDisplayName=“温泉搜索（临时版）”;
CFBundleName =“温泉搜索”;

Finder的表示使用CFBundleDisplayName字符串，CFBundleName被用于应用启动时菜单栏的表示，需指定短于16个字符（中文指定为8个字符）的字符串

5.3本地化

本地化（locale）就是编辑文本时的各种习惯或使用单位等的集合体，例如，表示日期的方式、作为小数点使用的字符（句号还是逗号）等，根据国家和语言的不同是存在差异的，为了生成在任何语言环境下都能通用的软件，就需要事先准备好这些字体，然后再在软件操作时选择合适的显示
为了表示本地化，Cocoa环境中提供了NSLocale类，当创建可以应对各种语言或地域习惯的应用时，就可以使用该类，用户根据使用环境而选择的本地化信息称为当前本地化，应用使用当前本地化信息进行操作
例如，NSString中有localizedStringWithFormat：类方法，它与stringWithFormat：同样可以指定字符串格式，假设使用该方法进行如下记述：

id date=[NSDate date];//返回表示当前时间的对象
id str=[NSString stringWithFormat:@“Date=%@”,date];
printf(“%s\n”,[str UTF8String]);
str=[NSString localizedStringWithFormat:@”Date=%@”,date];
printf(“%s\n”,[str UTF8String]);

在中文环境下执行时，结果显示如下

Date =2010-09-10 03:05:50 +0900
Date =2010年9月10日星期五 3点05分50秒 JST

同样的方法有如下初始化方式：

-(id)initWithFormat:(NSString 8)format
		     locale:(NSDictionary *)dictionary ,…

参数dictionary可按如下方式指定当前本地信息

id default =[NSUserDefaults standardUserDefaults];
id dic=[default dictionaryRepresentation];
str=[[NSString alloc] initWithFormat:@“Date=%@” locale:dic ,date];

用户默认信息保存在字典变量dic中，其中包含了语言相关的各种设定，这气势就是本地化的功能，此时，变量str中存储的字符串与使用localizedStringWithFormat：时是同样的，NSArray、NSDictionary等包含descriptionWithLocale：方法，该方法的参数也可以使用同样的方式指定
本地化相关的详细信息，请见参考文档“Locals Programming Guide”等

专栏：消息内的语序

用中文表示英语消息时，因为语序不同所以会费些功夫，此时，可以利用printf（）函数或NSS听日难过方法等的格式可以指定的特殊书写方式
通常，格式字符串内的格式符（%s等）可以与后面的参数依次对应，通过在格式符“%”后指定“数字”+“\$”就可以将数字指定顺序的参数，在该位置处发生变换，例如，下面的printf就会输出“Good：100”

printf(“%2\$s: %1\$d\n”,100,”Good”);

使用面向中文的Localizable.strings文件按照如下方式书写时，就可以将该字符串作为格式字符串使用，并使用中文的语序（像“文件0012.txt正在处理”那样）来表示，虽然不是万能的，但是灵活性很高

“%@ file %04d.txt” =“文件 %2\$04d.txt %1\$@”;

6、模块的动态加载

此章节将介绍程序的模块在执行中时如何实现加载的，该功能无法在iOS中使用，尽在Mac OS X中可以使用

6.1可加载束

程序内使用的类或范畴中，将当前不使用或可能不使用的模块加载在执行文件之外的其他文件中，并在必要时动态加载，这样就可以加速程序的启动，或者生成限定了功能的程序版本
而且，通过实现决定要加载的模块形式，并生成有别于程序的模块，就可以为程序添加各种各样的功能，这就是插件（plug-in）
在执行文件外创建并动态加载的模块通常会以可加载束（loadable bundle）的格式被保存在文件中，可加载束有与应用相同的目录结构，一个可加载束中保存着多个类和范畴的代码，可加载束作为资源保存在应用束内，也可以保存在外部，然而，加载方和被加载方仅有一个时都不能使用垃圾回收，如果使用引用计数管理方式，可以采用手动方式和与ARC混合的方式（见6.1节）
比起手动创建，可加载束一般采用开发工具Xcode来创建，不管哪种方式，都需要说明使用可加载束的应用的概况

6.2使用可加载束的程序

假设存在一个由类A、B、C、D以及主函数组成的应用，将主函数和类AB链接到执行文件中，将类C和类D当作一个可加载束（图16-3）
在执行文件一方，类A、B可自由使用，但是使用类C、D的代码不能写入到程序内，具体来说，代码中不能有显示类名的类对象，但是，用类C、D定义的消息可以自由发送，这是因为，在引用类对象时，如果该类代码时必要的，那么消息选择器所对应的具体方法的确定就被推迟到了执行时进行
￼

在类CD方面，不仅可以使用类C、D，也可以使用类A、B的代码，因为即使加载的代码中包含未解决符号（类名或函数名）但只要在加载时能解决也就可以执行
简便起见，假设类C、D的可加载束被保存为应用束的源文件，使用CandD.bundle作为其名字，在执行文件方加载该可加载束取得类C的类对象时，可以先取得CandD.bundle对应的束对象，然后对该对象适用classNamed：方法

-(Class)classNamed:(NSString *)classNamed
	返回一个类对象，他包含参数className指定的类名，束的执行代码尚未加载时，该方法会加载这个代码，不能加载指定的类时，返回nil

加载某个类代码时，他的可加载束内包含的其他代码也会同时被加载到内容中，所以，仅加载类C，内存中就会存在类D的代码，即使类C在内部使用了类D，也没有必要显式加载类D
当知道所加载的模块内的类名时，可以使用下面的函数指定

Class NSClassFromString(NSString *aClassName);
	参数aClassName指定了类名，返回持有该类名的类对象，类尚未加载时返回nil

类或范畴被动态加载时，如果类中定义了方法load，那么就可以自动执行，据此，加载后就可以执行任何初始化设置，这就是NSObject声明的方法，由于在某个类的load方法启动前，该超类的load方法就已经被调用，所以只需要写和该类相关的动作代码

+(void)load

下面，举例说明从执行文件方面加载可加载束的代码，可以看出，除字符串外，都没有使用类名C

static Class classC = Nil;

if(classC ==Nil){
	NSBundle *bundle,*module;
	NSString *path;
	bundle=[NSBundle mainBundle];
	path =[bundle pathForResource:@“CandD” ofType: @“bundle”];
	module =[NSBundle bundleWithPath:path];
	if(module ==nil ) /*ERROR*/
		return nil;
	classC=[module classNamed:@“C”];
}
return [[[classC alloc] init] autorelease];

可加载束内有时会包含图像、文本及本地化的文件等，未来使用这些文件，被动态加载的类需要知道自己被哪个束所包含，为此，可以使用如下的类方法

+(NSBundle *)bundleForClass :(Class) aClass
	参数啊 aClass使用被动态加载的类来返回包含该类的可加载束所对应的束

6.3插件概述

插件就是在程序加载过程中被动态追加的提供附加功能的模块，例如，为了能够读入不能被标准功能处理的数据文件，就可以通过插件来实现，此时，假设存在可读入新格式文件的类，并准备了使用这个类来处理文件的结构，那么只要能对应各种格式的文件开发出多种插件，就可以在不改变程序本身的情况下增加新的功能
在ObjectiveC编程中，插件也可以作为可加载束来实现，与程序中预先准备的代码不同，程序执行时并不一定需要插件，但是，一个程序可以同时加载多个插件，插件应该被定义为独立性高的模块，这样，无论是谁，只要遵从此特性，就都能生成新插件
插件与构成程序的可加载束不同，不能提前知道代码中包含的类名，为此，插件要使用如下方法加载代码

-(Class) principalClass
	返回可加载束的主要类（principal class）的类对象，必要时加载代码，不能加载时返回Nil

主要类时插件中包含的一个类，在可加载束的信息文件（info.plist）中为键NSPrincipalClass（表16-2）的值，也是链接代码时最先出现的类，由于使用该类的插件已经开始执行，所以必须要决定哪个类是主要类

Mac OS X的屏幕保护程序在/System/Library/Screen Savers/ 或 ～/Library/Screen Savers/目录中，并被保存成后缀名为“saver”的文件，这实际上就是可加载束，Mac os x中有ScreenSaver框架，将其中定义的类ScreenSaverView的子类作为主要类生成可加载束后，就可以作为屏幕储存器进行工作，这就是典型的插件例子


    """},
  {'title' : '第十七章（1）' , 'message' : """
1、Application框架和Interface Builder

下面介绍一个使用Application框架的GUI的程序，在Cocoa环境中创建GUI时，一般使用Xcode和一部分接口构建工具Interface Builder，而这里我们将介绍的是如何从源文件中创建
Interface Builder被用来生成GUI外观及初始设置、添加GUI组件（窗体或按钮、滑块等）和程序生成实例对象间的关系等，所以，在使用Interface Builder时，编程者只需要集中精力进行控制GUI对象的编程就行了
然而，Interface Builder虽然使用方便，但也有人质疑说编程学习者很难理解Interface Builder实际上到底是做什么。因此，这里我们首先会将所有的设定都使用文件记录，之后在说明使用Interface Builder后哪些部分可以不用记录
Application框架中的各个类以及Interface Builder的说明不是我们介绍的重点，因此这里不做详细解释，不过，Interface Builder需要根据很多指定的选项和设定的链接来执行，这一点还希望大家能够理解
但是，由于程序使用ARC类进行内存管理，并使用了对象的弱引用，因此在Mac OS X10.6及以前的开发环境中是不能编译的

2、程序概况

现在尝试创建简单的显示图像用的应用,命名为MyViewer，MyViewer将打开窗中指定的图像文件显示在新窗体里，可同时打开多个图像，也可以有简单的检查面板，将图像缩小到1/2大小
下面公开这些代码，省略其中一些冗长繁琐的部分

2.1对象键的关系

图17-1中显示了构成应用的主要对象键的关系，白色空箭头指向的目标对象是由源对象创建的，黑尖头指向的目标对象是源对象的委托
￼
NSApplication类接口就是代表应用自身的对象，管理者运行回路，该对象的委托中使用了MyViewerCtrl类的实例，该对象不仅处理发送给委托的消息或通知，还会处理菜单发来的消息，承担了应用的核心角色
每次需要显示新图像时，MyViewerCtrl都会创建WinCtrl类的实例，并生成多个接口，这些接口负责创建显示用的窗口和显示图像等具体工作，而且也是现实用的窗体的委托

2.2通知

应用中也包含了简易的检查面板，检查面板中显示当前主窗体（最顶层表示的窗体）中正在显示的图像的名字和尺寸，创建并管理检查面板可通过类MyInspector实例，该实例只能由一个，而且也是显示面板的委托
在主窗体改变时，该应用会使用通知功能将这一消息传递给检查面板（图17-2）图中箭头显示了通知的结果，即信息来自哪个对象以及被哪个对象所使用，各窗体称为主窗体时或被关闭时，都会发送相应的通知，MyInspector类接口从这些通知中了解到主窗口的切块，进而更改显示的面板
￼
检查面板中有2个按钮，其中一个表示将当前主窗体中显示的图像缩小到原图像的1/2，另一个是表示将现在显示的所有图像都缩小到原图像的1/2，为此，Myinspector类的实例会自己发送通知，WinCtrl类的实例接收到该通知后，会将各自管理的图像缩小

2.3撤销和重做

点击菜单上的取消，或使用命令键与z的组合就可以实现撤销，撤销被应用于反应链的快速反应，管理各个窗体的WinCtrl类的实例都各自拥有撤销管理器，最顶层的窗体接收撤销消息并进行处理，取消操作进包含图像缩小和文本编辑，同样也可以进行重做操作

2.4可加载束和本地化

管理检查面板的MyInspector类构成可加载束，检查面板在首次使用时会被动态加载，而且该应用中还进行了本地化，即便是中文也可以表示消息
图17-3为应用包的结构，可加载束在应用束内，因为它自己持有本地化用的文件，所以结构有些复杂
￼

2.5用户默认

菜单中有自动缩小项，选中时会将界面中不能容纳的大图像缩小显示，该选项的有无在用户默认中设定，而且，检查面板的位置和大小也保存在用户默认中

3、编程介绍

3.1main函数和MyViewerCtrl类

下面开始介绍MyViewer的源程序，其中也会简要说明Application框架类，纤细介绍请参考各类的参考文档
首先是main函数，处理内容在列表内的注释中说明，一般在使用Xcode创建应用时没回自动创建main函数，所以不需要自己来写，也可以使用Interface Builder来设定菜单和委托

代码清单17-1 MyViewer的main函数

下面介绍MyViewCtrl类，因为该类将称为NSApplication的委托，所以它采用了NSApplicationDelegate协议
MyViewerCtrl类实例只需一个即可，并通过单体（singleton）（见5.2节）模式定义，应用启动后，该实例接收到委托消息后便执行创建菜单等操作，使用Menu.plist文件中用ASCII码属性列表记录的信息来创建菜单，但因为过程太繁琐所以这里省略相关说明，使用Interface Builder时，菜单和GUI组件的创建由nib文件进行，因此不需要执行程序那样的处理
实例变量autoResizeItem表示是否选择自动缩小的菜单项，为了避开包含循环，该变量使用弱引用
应用启动后就会处理菜单对应的点击操作，使用方法openFile：开启打开面板并选择文件，进而生成WinCtrl实例，这里使用了块对象，还有一点需要注意的是，选择的文件应作为NSURL实例传入，生成的WInCtrl实例被保存在MyViewerCtrl内的数组中，窗口关闭时就会被从数组中删除，如果不这样做，就不能保留WinCtrl实例，该实例在窗体显示后就会被直接释放，保存到数组及从数组中删除这些操作都由WinCtrl实例自动进行
在方法cativateInspector：中读入可加载束并显示检查面板
终止时要确保已将用户默认信息写入到文件

代码清单17-2 MyViewerCtrl接口部分

代码清单17-3 MyViewerCtrl实现部分

3.2WinCtrl类

WinCtrl类实例生成显示图片的NSImage实例，并在初始化时打开图像文件，接着，打开窗体来显示该图片，其自身也是该窗体的委托，未来更简单地显示图片，这里使用了NSImageView类，在显示窗体的同时，也将自身保存在MyViewerCtrl的实例持有的数组中
使用Interface Builder时，没有必要像调用windowSetUp：方法那样自己写代码来完成窗体的创建和设定，
该类也会使用shrink：方法将显示图像缩小一半，而实际进行处理的方法setScaleFactor：则会将返回到当前缩小率的操作写在撤销管理器中，据此可以实现撤销、重做缩小操作，缩小处理执行到最后，会发送图像大小变化的通知，反之，如果成为检查面板发送的通知的观察者，就可以实现将所有的窗体图像同时缩小一半的操作，这些功能中虽然可以使用自定义通知，但正如在P294的Column中所述的那样，推荐将通知名等作为全局变量和宏名进行定义和使用
WInCtrl类实例就是窗体显示的委托，所以要采用协议NSWindowDelegate按下窗体关闭按钮时，首先会发送询问消息windowShouldClose：如果图像没有缩小显示则返回YES，然后窗体被关闭，此时，由于windowWillClose：消息也会被发送，因此这里还需要释放自己的内存
而图像缩小显示时，windowShouldClose：方法则会显示确认窗体（图17-4）并返回NO，按下按键后，将调用显示页时指定的方法alertDidEnd：returnCode：contextInfo：如果按下Ok键，就会取消窗体委托并关闭窗体，然后释放自身内存
为了能够执行窗体撤销操作，需要实现windowWillReturnUndoManager：方法
￼

代码清单17-4 WinCtrl接口部分

代码清单17-5 WinCtrl实现部分 

3.3类MyInspector

下面将介绍控制检查面板的类MyInspector，该类成为可加载束后，本地化文件必须单独包含，这点请一定要注意
类方法sharedInstance在创建实例时只会创建一个
检查面板上按键喝文本的设定由本地方法panelSetting来完成，该面板可以改变尺寸，也可以被设置成即使关闭后也不会释放的方式，这里用setFrameAutoSaveName：方法设定了面板的名字，而据此该面板的位置和尺寸也会被自动记录到用户默认信息中，使用Interface Builder时不需要进行这项设定
面板左侧的缩小按键，虽然目标设定为了nil，但在GUI环境中仍会想快速反应者发送消息。缩小和撤销、重做都可以在菜单操作，但这些也都会想快速反应者发送消息（为了避免繁琐，这里不详细介绍）使用Interface Builder时，通过将快速反应者的图标作为目标与组件相链接，即可表示想快速反应者发送消息
使用该程序，可以编辑显示用的文本域，因为文本域从最初就实现了撤销，因此利用这一点可以确认反应链的动作，检查面板为关键窗口时，执行撤销操作后，文本域的编辑结果而非显示图像的窗口就会被撤销
图像显示用的窗体为主窗体时或被关闭时，MyInspector实例就会成为图像尺寸改变时发送的通知的观察者，接收这些通知时，主窗体可能会切换
MyInspector实例还是检查面板的委托，能够处理面板关闭时以及面板为关键窗体时的消息，这里使用的isClosed变量指明面板是否被显示，当不显示时，就不需要更新
通过showInfo：局部方法可以显示更新，主窗体切换时，图像缩小后，以及检查面板显示后，都将调用该方法，该方法的参数为窗体，窗体的委托是WinCtrl实例，所以从该对象可以获得显示用的信息

代码清单17-6 MuInspector接口部分

代码17-7 MyInspector实现部分

4、应用束的组织

4.1创建编译和设置文件
如果要将主执行文本编译，可做如下操作吗，必须指定Foundation框架、Application框架或者Coca框架

clang -Wall -fobjc-arc -o MyViewer MyViewerCtrl.m WInCtrl.m main.m -framework Foundation -framework AppKit

接下来，编译可加载束的执行代码，选择-bundle生成束，选项-bundle_loader表示下一个参数MyViewer时加载该束的程序，在链接处理时，如果发现未定义名字，就要检查是否已在加载方定义

clang -fobjc-arc -bundle -bundel_loader MyViewer -o MyInspector MyInspector.m -framework Foundation -framework AppKit

应用的信息文件如代码清单17-8所示，应用名用键CFBundleIndentifier指定，应用执行后，为了保存用户默认信息，	～/Library/Preferences中会生成以该名字命名的属性列表文件

应用束用于中文的Localizable.strings如代码清单17-10所示，文字编码为UTF-16，用于英语的文件没有等号及右边的项，因此此处做了省略

代码清单17-10 MyViewer用于中文的字符串文件

可加载束用于中文的Localizable.strings

代码清单17-11 可加载束用于中文的字符串文件

这些都必须整理成图17-3的应用包格式，app后缀的目录不方便finder操作，因此从命令行执行创建目录的操作会更方便，从网络下载源码，然后输入make命令即可完成构建

4.2 程序运行例子
程序运行界面的例子如图17-5、17-6所示，因为设置了快捷键，所以命令键和o都可以显示打开面板
在图17-5中尝试打开多个图像，然后，按下检查面板的“所有”按键，将所有图像都缩小1/2（图17-6）菜单的“撤销”适用于各种图像，也可以还原图像大小
￼
￼

4.3GUI定义文件和程序

使用Interface Builder定义GUI后，定义内容会被保存在nib文件中，每个nib文件中会定义如下事项：
- [ ] 配置窗体和面板的内部组件，改变大小时指定尺寸变化
- [ ] 指定与各组件外观、动作相关的属性
- [ ] 配置图像和声音文件
- [ ] 按下按键时发送的消息及其目标
- [ ] 将其他对象设定为某个对象的出口
- [ ] 非GUI组件类的实例需互相连接
- [ ] 设置反应链
- [ ] 设置菜单
- [ ] 作为nib文件范围内的对象所有者的对象
- [ ] 设置工具条（鼠标位置处显示的说明）
- [ ] 设置Cocoa绑定

其中，Cocoa绑定就是利用第20章所述的键值编码，来大幅减少对象间因耦合而产生的代码的计数
Interface Builder并不是单纯的GUI组件配置工具，基于目标-动作模式（参考8.2节）的概念，当操作某个GUI组件时，可以设定向什么对象发送什么消息，这些对象可以配置包括自定义类在内的任意类实例，这样构成的对象只要是GUI组件，就可以在Interface Builder内实际操作，而且也不需要编译
此外，一个对象的实例变量或声明属性中也可以连接别的对象，Interface Builder将此“连接口”成为出口，在面向对象的程序中，设置由对象构成的拓扑结构非常麻烦，而利用Interface Builder就可以用非常简单的方式构建对象间的连接，但是，使用ARC时要注意不要产生死循环（见16.2节）
本章的图像视图如果利用Interface Builder来创建的话，就可以省略一大部分程序代码，对象间关系（图17-1）中可以利用Interface Builder设置的部分如图17-7所示
￼
从程序方面来看，只要在运行中指定并读入nib文件，用Interface Builder设定的对象结构就会被动态构成，之后直接利用就行了，例如，在nib文件中定义WinCtrl实例和窗体的关系时，只需读入nib文件，就可以生成与新的WinCtrl实例相对应的窗体了（见16.2节）
这次生成的源程序中，使用类MyViewerCtrl的方法setupMainMenu、类WinCtrl的方法winowSetup及类MyInspector的方法panelSetting的方法的内容基本上都不需要，此外，也不需要把菜单的内容当作属性列表记录的Menu.plist文件

专栏：ObjectiveC调试器的功能

Mac OS X的ObjectiveC编译器因为基于GCC，所以可以使用调试器GDB（GNU Debugger）在Xcode中方可以使用的调试器也是GDB，除类在控制台输入命令之外，在利用断点查找等情况下，如果已知命令也会非常方便，编译时，GCC和Clang都指定选项-g来生成调试信息
只要了解几个命令就能有效利用GDB，因此，即使不知道使用方法，也要去尝试用一下，GDB使用方法在书中或与Unix相关的文章、网站等处查找
Mac OS X的GDB中增加了面向ObjectiveC的功能，下面将简要说明：
（1、表示对象
新增的命令po（print-object）可被用来表示对象的相关信息，该命令的参数对象可使用description方法，并显示返回的字符串
为了获得变量或公式的值，通常使用命令p（print），但即使对象可以使用p命令。结果也只能表示id值，也就是指针值，而如果在使用*运算符后再使用p命令，调用该对象中的数据时就可以采用与表示结构体同样的方式
（2、使用消息格式
p命令的参数不只是变量值，也可以是书写的格式或函数调用等，这里还可以为消息格式，据此，就可以方便地向某个对象发送消息或查看状态等
消息格式的返回值为对象时，可以用po命令来表示，而如果返回值为整数或实数，则必须通过映射指定类型后次啊能表示，因为实际执行的方法时动态变化的，所以返回值类型与调试器无任何关联，例如下面的式子：

p (int)[val intValue]
p (NSRect)[view frame]

（3、设置断点
使用b（break）命令来设定断点，参数中可以指定源码内的行数或函数名，这里还可以新指定消息选择器
ObjecitveC语言中，很多情况下不同的类都定义了同样的名字，此时可以显示出候补的一览列表，并从中选择目标名字，所有的同名方法都可以指定断点，例如，发生例外时使用raise方法（参考第18章）但如果指定该raise为断电，那么，当异常发生时，调试器就可以十分方便地查找原因

break -[MyClass initWithName:]
break +[FirstClass new]

前面的+号为类方法，-号为指定的实例方法，括货左侧是类名，右侧为方法选择器
    """},
  {'title' : '第十八章（1）' , 'message' : """
1、异常

1.1异常处理的概念

异常（exception）就是指必须中断程序的正常执行来进行处理的特殊状态
Foundation框架由很多类，当指定的方法不能正常处理时就会产生异常，例如，NSMutableArray类的方法addObject：会将参数对象添加到接收器的数组中，当参数为nil时就会产生表示输入参数不正确的异常NSInvalidArgumentException而且使用方法objectAtIndex：访问的索引位置如果超过了元素个数，表示范围错误的异常NSRangeException就会发生，像这样，除了程序错误引起的异常外，文件、通信信道的输入输出终止也能引起异常
在最近的编程语言中，编码时往往采取将异常发生时的处理和程序原本应该执行的处理分开进行的结构，这就是异常处理机制（exception handling mechanism）当异常状况产生时，程序就会自动脱离出普通的函数和方法的调用，转为执行异常处理过程
因此，提供功能的程序方面就可以把精力集中在原本应该执行的处理上，来编写相应的代码，二功能的使用方也是如此，将异常处理代码和普通执行流程分开写更好，这样就有可以清晰地记述繁琐的错误处理了

1.2ObjectiveC中的异常处理

ObjectiveC的Mac OS X10.3中增加了异常处理机制，当异常发生时就会进入专门的处理流程进行处理，但是，利用异常的程序或通过引发异常来控制动作的编程类型并不被推荐，这点也明确写在了苹果公司的各种文档中，也就是说，因设计错误或程序错误二产生的执行时错误，在开发时就应该被去除
这里我们来看一下使用ObjevtiveC的异常处理机制的目的，首先，在软件开发时，特别是在测试等的时候，使用该机制可以把握意外的发生并对调试起到一定的辅助作用，基于这个目的的情况下，完成后的软件不会包含任何异常
再有，当应用中发生异常时，为了时该异常的影响不会波及到整个应用，而且在必要的善后处理后就可以快速终止程序的执行，也会使用异常处理机制，同样，当某个库或框架内发生异常时，该机制也会被用来在其内部捕捉并处理异常，以防止波及到外部
总之，ObjectiveC的异常的使用范围并不广泛，不是说感到“不能正常运行了，尝试修正一下吧”就是使用异常，异常是一种在非常情况下推出流程的方式，使用异常是为了“趁事态不严重时尽可能地妥善处理，然后在终止程序”大家一定要认识到这一点，在Java等程序汇总，读入文件不存在时也会使用异常来处理，但在ObejctiveC中，这样的编程风格时不被推荐的
有关异常处理的详细内容请参考“Exception Programming Topics”等文档

2、异常处理机制概述

 2.1异常句柄和异常处理域

异常发生时，为执行异常处理而准备的流程成为异常句柄（exception handler）该异常句柄处理的对象的代码部分称为异常处理域（exception handler domain）
Fig 18-1（a）是一场没有发生时的情况，此时一场句柄不被执行，（b）时在异常处理域执行的过程中又有其他异常发生时的情况，此时正常的执行流程会被中断，异常句柄的处理被立刻执行，异常句柄首先会查看该异常的内容，如果可以处理则执行相应的处理，然后继续执行程序，不能处理的异常一般就成为运行时错误，并导致程序终止，用异常句柄执行异常处理，有时也称为用异常句柄捕获（catch）异常
￼

2.2异常表示类NSException

在Cocoa环境中，可以用类NSException来表示异常，接口在Foundation/NSException.h中声明
通过生成NSException实例并发送raise消息，就可以启动异常处理，这也称为“产生异常”或“抛出异常”NSException实例称为异常对象

-(void)raise
	向异常对象抛出异常

或许有人不太习惯这种说法，实际上，像”没有内存可分配“、”参数不正确“这样必须要处理的问题就是异常状况，因为向NSException类实例发送raise消息时该状况已经发生了
但是，在异常处理机制方面看来，只要没有开始异常处理，就不是异常，也就是说，向NSException实例发送消息raise这一时刻和异常发生被同等看待了，而且，有时也会将指向NSException的实例称为异常，这也是同样的想法
异常对象包含18-1的信息
￼
异常的名字为全局字符串变量，被预先定义在各种类的头文件中，调查发生的异常时，将捕捉的异常对象名和这些异常名比较，而且，像什么样的情况下发生什么异常之类的信息，以及用户字典中传入的信息，在各类的参考文档中都有详述
用户也可以定义新的异常，并在程序进入非正常状况时抛出异常（之后会详细介绍其方法）

2.3异常处理机制的语法

异常处理机制采用如下语法：

语法：异常处理
@try{
	/*异常处理域*/
	/*在此记述正常处理*/
	…
}
@catch(NSException *exception){
	/*异常句柄*/
	/*记述异常处理过程，例如显示错误消息等*/
	…
}
@finally{
	/*后处理*/
	/*在此记述无论异常发送与否最后都会执行的代码*/	
	…
}

@try必须卸载@catch和@finally的前面

@catch块可以写多个，@catch块也可以不写，但此时必须有@fianlly块，按上述方式书写@catch后括号内的内容时，可通过变量exception访问与发生的异常相对应的NSException实例，在这部分中，可以像函数的形式参数那样指定任意变量名，这里指定的变量名时只在@catch块内有效的局部变量名
@finally块不需要时也可以不写，无论异常发生与否、@catch块捕捉到异常与否，该块内的代码都一定会执行，有关该块的详细介绍在后面的章节中还会提到

2.4简单的异常处理的示例程序

下面是一个简单的程序例子，他会处理发生的异常

代码清单18-1 example.m 

#import <Foundation/Foundation.h>

int main(int argc,char *argv[]){
    //使用ARC
    @autoreleasepool {
        id array =[NSMutableArray array];//空数组
        
        @try{
            if(argc ==1)
                array=[array objectAtIndex:1];//NSRangeException
            else{
                [array addObject:nil];//NSInvalidArgumentException
            }
            NSLog(@"success\n");
        }
        @catch(NSException *ex){
            NSString *name = [ex name];
            NSLog(@"Name :%@\n",name);
            NSLog(@"Reson:%@\n",[ex reason]);
            if([name isEqualToString:NSRangeException])
                NSLog(@"Exception was caught successfully.\n");
            else
                [ex raise];//再次抛出异常
        }
        NSLog(@"main exit");//行尾没有换行符也没有关系
    }
    return 0;
}

该程序根据命令行中是否存在参数而残生不同的异常，生成空数组，取出第一个不存在的元素时将产生异常NSRangeException追加新的元素nil时将产生异常NSInvalidArgumentException因为@catch块中捕获的异常可以访问ex变量，所以首先显示异常的名字和原因，接着，当发生的异常为NSRangeException时就显示能够捕获异常这一消息，而当其他异常发生时，则向ex发送raise消息来再次抛出异常，这样一来，NSRangeException意外的异常通常就会由运行时系统来处理

下面实际运行一下
首先，不给参数传递任何变量时的执行例子如下，通过main exit看书，异常被捕获，后续部分正在被执行
￼
接着是传递了参数时的情况，可以看出，异常虽然被捕捉了，但之后却显示了和普通运行时错误发生时几乎相同的消息，然后程序异常就终止了

这就是因为运行时系统的未捕获异常句柄（uncaught exception handler）流程捕获并处理了异常，异常处理域外部发生异常时，或长须异常句柄中异常处理不能结束时，未捕获的异常句柄就会向终端、控制台或日志文件中打印消息然后终止程序
但是Cocoa应用的主线程内发生异常时，NSApplication（或UIApplication）实例将捕获未处理的异常，所以未捕获异常句柄并不会直接终止应用，此时的日志可以从控制台中获得确认，然而，即使应用能捕捉到，异常的产生也仍可能会给应用带来若干影响，导致应用之后的处理不能正确执行，这点需要注意

专栏：日志输入函数NSLog（）
代码清单18-1中使用了NSLog（）函数，该函数使用和printf（）相同的格式字符串及相应个数的参数，向stderr（标准错误输出）输出错误，与带有NSString类的格式的方法相同，格式通过NSString字符串指定，也可以使用“%@”输出的各行的头部有时间，程序名等信息，行尾没有回车时将自动添加回车，而且，从Cocoa应用中用NSLog输出的字符串，也是控制台输出的日志



    """},
  {'title' : '第十八章（2）' , 'message' : """
3、异常的发生和传播

3.1异常的传播

异常处理的语法通常可以和其他控制语句组合，也可以潜入到其他语句中使用，而且，异常处理语法块内调用的方法或函数有时也包含异常处理语法，也就是说，伴随着程序的执行，某个异常处理域中可能还会有其他异常处理在执行，异常句柄中也可能再次发生其他异常
只使用@catch块不能结束口歌异常处理，为了委托外部异常句柄来处理，有时候就需要在@catch块内故意抛出异常，像这样，为保证异常的正常处理，被调用方向调用有序传递异常的过程，称为异常传播（propagation）任何异常句柄，帮不能被合适处理活在异常处理域外部发生一行时，最终都会由未捕获异常句柄来处理

3.2自己触发异常

如前所述，向异常对象发送raise消息可以抛异常，但是，实际上使用下面的类NSException的方法会更加容易

+(void)raise:(NSString *)name
         format:(NSString *)format,…
	将异常名及原因保存成信息并创建临时实例，直接产生异常
	原因由printf（）样式的格式字符串，以及用逗号分割的任意个参数构成，用户字典为nil

该方法及其他产生异常的方法的相关介绍，请参考NSException的参考文档
也可以自定义异常名柄产生新型的异常，此时，必须起一个可以和其他异常相区别的名字，异常名的添加方法请参考附录C

3.3用@throw语法产生异常

产生异常一般使用@throw语法，语法格式如下所示，object部分中可以指定任何对象，将@throw方法应用于NSException实例，同发送raise消息是一样的

语法：产生异常

@throw object;

即便@catch块内没有参数也可以使用@throw，此时@catch块捕捉的异常对象就被视为参数，同传入的参数效果一样，使用该写法，能够更加方便地记述捕捉到的异常传播处理
将NSException以外的普通对象指定为@throw参数也可以产生异常，在捕获这样的异常时，@catch语法中必须要指明该对象的类型，如果对象类型不明确，那么使用id类型后，结果就讲捕捉包含NSException在内的所有异常
@catch块可以被书写多个，但是必须要注意他们的顺序，这是因为，根据书写顺序能够得知用@throw产生异常时使用的对象和哪个@cathch块参数一致，例如下面的例子，MyClassA是MyClassB的超类，object是其中一个类的实例，这时异常一定会被1的@catch块捕捉到，而2不会捕捉到，此外，如果将3的@catch块写在1和2的上方，则异常只能被3的块捕捉到

@try{
	….;
	@throw object;
}
@catch(MyClassA *ex){ //1
	…
}
@catch(MyClassB *ex){//2
	…
}
@catch(id ex){ //3
	…
}

3.4@cathch的特殊语法

@catch 参数除了上面介绍的书写方法之外，也可以采用下面的方式书写，即括号内不写出具体参数，而是写三个点号

@catch(…){
	/*异常句柄*/
}

在需要捕捉异常而不需要知道异常内容的情况下，经常会使用该写法，如果存在其他的@catch块，则必须将其书写为最后的块，块内@throw不指定参数，就能传播异常

3.5异常传播和@finally

@catch块内发生异常时（或传播）或者不存在可以捕捉发生的异常的@catch块时，通常就会直接将处理移交给外部的异常句柄来执行，但如果有2finally块，那么在外侧异常句柄移交处理前，2finally块的内容将先被执行，在没发生异常时，@finally块会在@try块之后执行，而当异常不想外侧传播时，@finally块则必须紧接着@catch块执行，所以，这里就要书写实例释放或文件关闭等必须要执行的后处理（图18-2）如果不捕捉异常而只想执行后处理，也可以不写@catch，只写@try和@finally，此时，异常发生后@finally块就会被立刻执行（图18-3）
￼


3.6异常处理程序的注意点

（1、递归方法调用内发生异常
N重递归方法调用（或函数调用）中发生异常时，处理有时就会跳过内侧的方法二转移到外侧的异常句柄中进行（图18-4），此时，在被跳过的方法中，有些处理就可能会被非正常终止，例如，为了释放对象/对象不被释放掉二斤小的处理可能稍微结束，或者文件或通信相关的后处理没有得到执行等等
所以，当程序使用异常处理时，异常发生源，异常句柄及可能因异常而为导致被中断的方法调用都需要我们小心应对，在图18-4中，无论是方法C还是方法A和方法B，如果处理被中断时必须进行后处理，那么就要在@try中加入方法调用，并在@catch或@finallu中写后处理代码
￼
（2、引用计数管理和异常
使用引用计数的内存管理方式时，如果因为异常的发生二将处理交给了异常句柄，那么就不能保证这期间使用的对象能被正确释放，手动的计数管理方式和ARC也都一样，使用ARC时，还存在弱访问的变量不能清零的问题
因此，我们可以这么说，在ObjectiveC中， 写代码时不能一使用异常处理机制为前提

（3、关于C语言中的全局跳转函数
C语言中有两个函数setjmp（）和longjmp（）他们都可以从函数调用的深层递归中返回，但是，由于这里的异常处理机制在实现时使用了这些功能，所以异常处理机制流程和这些跳转函数不可以同时使用
ObjectiveC语言中组合使用C语言的函数时，要确保setjpm（）和longjmp（）的组合只在C语言的流程内结束，这点请注意

4、断言

4.1断言是什么

出于调试的目的，有时需要产看程序必须满足的制约条件是否被破坏了，例如，在某个方法执行前，变量x的值必须为零、此类条件的组合不应该发生等等
像这样，在程序中书写程序必须满足的条件，当条件破坏时就触发异常的结构称为断言（assertion）
断言使用宏来书写，宏定义在头文件Foundation/NSException.h中
断言宏的参数中写着必须为真的条件表达式，例如，变量x的值必须比变量y大时，可按如下方式表述（关于宏的内容会在后边介绍）

NSSAssert(x>y , @“Illegal values x(%d) & y(%d)” x,y);

条件为假时，异常NSInternalInconsistencyException就会被处罚，实际上，每个线程中都会自动生成NSAssertionHandler类实例，该对象虽然会触发异常，但基本上不需要对该类直接操作
编译时定义了NS_BLOCK_ASSERTIONS宏时，断言不会被写入代码，而因为没有写入，所以就会被当作空字符串处理，于是，在编译完成后的程序时，就要在编译器的选项中加入-DNS_BLOCK_ASSERTIONS
选项D的作用时可以从命令行定义宏，这样使用时，就不需要特意在文件中书写#define了

4.2断言宏

断言宏可以在ObjectiveC方法内以及C函数内使用，断言条件为假时，如果是在函数内，那么就用函数名来表示；而如果是在方法内，那么就用方法名来表示
首先，只在条件为真时使用的宏有2个：

NSParameterAssert(condition)  ….在方法内使用
NSCParameterAssert(condition) ….在函数内使用

此外还有宏可以在条件为假时传递触发的异常，以及生成用来说明异常的字符串，他们和printf（）一样，取得格式字符串和对用的参数，使用目前为止的C语言规范尚不可以定义参数个数不确定的宏，而在新的规范中是可以的

在方法内使用
NSAssert(condition,NSString *description[, arg,…])
在函数内使用
NSCAssert(condition,NSString *description[,arg,…])

专栏：包含可变个数的参数的宏

在新的C语言规范中，可以书写包含可变个数的参数的宏
例如，下面是一个很常见的例子，宏的形参部分中写着“…”，宏的展开部分中可以用__VA_ARGS__来访问该处，然而，在这个例子中，因为参数fmt被“>>>”连接，所以必须要指定确定个数的字符串

#include<stdio.h>

#define Debug(fmt,…) fprintf(stderr,”>>>” fmt,__VA_ARGS__)

int main(void){
	Debug(“%d\n”,1);
	Debug(“%d,%d,%d\n”,1,2,3,4);
	return 0;
}

5、错误处理

5.1错误处理结构的目的

在一般的流程型程序中，因为不能读入指定文件或输入数据有误等问题不能按照正常流程运行时，利用手写或函数返回值来表示错误发生时常见的方法，但是，单纯靠错误代码和消息，是很难确定错误的原因以及如何处理的
在Cocoa环境下为了能够统一表示错误的种类和消息，可以使用类NSError，简单地说，NSError持有显示图18-5那样的报警面板时所需的相关信息
￼
类NSError实例在Foundation/NSError.h中声明。然而在下面的描述中，NSError实例有时又称为错误对象

5.2表示错误的类NSError的使用方法

NSError实例包含表18-2所示的信息
￼
因为这些信息的具体内容因域和错误种类而异，因此这里不再详细说明，但书写确切应对错误的函数时，有必要详细调查一下各个信息，必要的信息在相关差别，API的参考文档及头文件中都要有说明
错误对象可作为函数或方法返回值返回给调用方，在Cocoa API中，大多数情况下都是用可能发生错误的消息的末尾参数来获得
例如在NSString中，使用如下方法可使指定的文件内容作为字符串返回（第二个参数enc指定字符串编码）

+(id)stringWithContentsOfFile:(NSString *)path
				 encoding:(NSStringEncoding) enc
					error:(NSError **)error 

第三个参数error为指针，指向NSError的实例指针变量，也就是指针的指针，此处的使用方法非常简单，如下所示，准备好保存实例的变量，并使用&运算符指向该地址即可，发生指定的文件不存在等错误时，代入错误对象给变量err，如果没有发生错误则不代入对象，因此，为了明确表示错误没有发生，英国养成预先为变量err代入nil的操作习惯
然而，使用ARC管理内存时，方法内的自动变量地址必须将（NSError **）类型的参数指定为nil（见5.6节）

NSString *path,*contents;
NSError *err;

…
err=nil;
contents =[NSString stringWithContentsOfFile:path encoding:NSShiftJISStringEncoding error:&err];
if(contents ==nil){
	NSAlert *alert =[NSAlert alertWithError:err];
	(void)[alert runModal]; //显示警告窗口
	break;
…
}

这里使用了Application框架的NSAlert类，将错误对象作为参数，即可方便地显示相应的警告窗体，也可以像第17章的示例程序那样，将其作为表单显示在窗体中，但正如简单图像视图的例子那样，NSAppliaction应用必须要考虑到运行回路
而且，如果应用被本地化为中文，那么警告面板中显示的消息就多为中文，实际上图18-5中的面板的中文时系统显示的，因为要使用到系统预先保存的中文文字，因此如果没有中文资源则使用英语
方法内部发生错误时，可以先泽直接像调用方返回错误，像框架方法那样使用最后的参数返回错误时，方法如下所示，这里使用ARC时也同样适用

-(NSString *)contentsOf:(NSString *)name error:(NSError **)error{
	…
	path=[directory stringByAppendingPathComponent:name];
	contents =[[NSString alloc]initWithContentsOfURL:path encoding:NSShiftJISStringEncoding error:error];//直接使用传入的指针
	if(contents ==nil)
		return nil;
	…
}

5.3获取错误对象的信息
为了获得表示错误内容的消息字符串，可向NSError实例发送下面的消息，没有必要直接访问用户字典或域等

-(NSString *)localizedDescription
	返回说明错误的字符串，字符串被本地化，不会返回nil，用户字典汇总如果存在NSLocalizedDescriptionKey键的对象，则返回该对象
-(NSString *)localizedFailureReason
	显示错误产生的原因，返回本地化的短字符串，有时返回nil，用户字典中如果存在NSLocalizedFailureReasonErrorKey键的对象，则返回该对象
-(NSString *)localizedRecoverySuggestion
	显示错误的处理方法或建议，返回本地化的短字符串，有时返回ni，用户字典中如果存在NSLocalizedRecoverySuggestionErrorKey键的对象，则返回该对象

以图18-5的警告面板显示时的情况为例，错误对象在调用上述三个方法时一次返回如下对象

localizedDescription
…字符串“因为没有合适的访问权限，不能打开文件“work””

localizedFailureReason
…字符串”没有合适的访问权限“

localizedRecoverySuggestion
…字符串“显示或变更访问权时，请用“Finder”选择文件，选择“文件”“查看信息””

5.4生成自定义错误对象

与异常相同，自己也可以生成NSError实例，可以使用下面的简易常数类

+(id)errorWithDomain:(NSString *)domain
			     cod:(NSInteger) code
		      userInfo:(NSDictionary *)dict
	指定域名、错误代码和用户字典后创建错误对象，用户字典为nil也没有关系，域名必须要指定

典型的错误域名如下所示表18-3:
￼
返回新出按键的错误对象时，如果错误原因和上述任一个域相同，就可以直接使用域和错误代码。
在Mac OS X环境下，用户字典即使为nil，只要指定了域名和错误代码，多数情况下警告面板中也都会显示中文的错误信息
自定义程序可以创建自己专用的新域名，此时，错误代码和用户字典的内容也西药自己来管理，错误消息及警告面板中显示的按钮标题等信息被一并保存在用户字典中传递，建议将字典中保存的字符串本地化
用户字典可以自由地登录入口，但为了特定目的，这里有多个键被预先定义为了常数，如表18-4所示，值为显示消息的字符串时，基本上都已经被本地化了
￼

6、错误反应链

通过将NSError结合应用框架来使用，就可以在GUI环境中灵活滴进行错误处理，核心模块是Mac OS X10.4后引入的错误反应链（error-responder chain）该模块与15.4节中介绍的反应链类似
下面将简述什么事错误反应链，该功能只在Mac OS X上有效，详情请参考“Error Handling Programming Guide”等文档

6.1错误反应链的结构

当与某组件错误相关的错误发生时，有必要将错误内容发送给用户，或根据用户的指示对错误进行处理（恢复）但是，如果根据错误发生场所来分别进行处理的话，从应用整体来看就会有处理不统一的危险，于是，可以将错误处理规则与GUI组件的层次结构互相对应，这样形成了错误反应链
正如在介绍反应链时所说的那样，GUI组件大部分时Application框架的NSResponder类的子类，他们在窗体中保持着层次结构，错误反应链和反应链同样，是位于底层的组件指向上层组件的对象（反应链）的连接
当与某个组件相关的错误发生时，会讲错误对象作为参数将消息presentError：发送给该组件，意识错误对象就会从该组件开始被转发给上层的组件，最终由窗体发送给NSApplication实例，错误提示和恢复被执行（图18-6）
￼

在错误传送中使用了方法presentError：它是NSResponder实例的方法，将错误发生给错误反应链指向的下一个对象，如果错误恢复成功则返回YES

-(BOOL)presentError:(NSError *)anError
	
处理文档的窗口可使用如下方法
-(void)presentError:(NSError *)error
   modalForWindow:(NSWindow *)aWindow
		 delegate:(id)delegate
didPresentSelector:(SEL)didPresentSelector
	    contextInfo:(void *)contextInfo

使用该方法时，错误通过指定的窗体表单显示，这里省略使用该方法时的详细情形，下面只简单说明一下presentError：方法
接收presentError：方法的反应器使用self的错误对象作为参数来调用下面的方法，并将返回的错误对象发送给上层的反应器

-(NSError *)willPresentError:(NSError *)anError

NSResponder的实现中将原样返回该参数，但是NSResponder子类中需要重写该方法，子类中可以访问错误对象参数包含的消息，然后将包含更加详细的错误消息以及恢复所需要的信息的新错误对象返回，然而，willPresentError：方法需要在子类汇总由用户来定制，而presentError：方法不能重写
同样，Application实例的委托也可以定义下面的方法

-(NSError *)application:(NSApplication *)application
	     willResentError:(NSError *)error
	
6.2错误对象 的更改和恢复

针对发生的错误，有时也可以根据用户的指示来执行恢复，例如，读入的数据形式不正确时，时继续读取还是使用代替数据或终止处理程序，这些都需要根据用户的选择来进行
此时，可以在香港的组件类中写入willPresentError：方法的实现代码，或者在NSApp委托中定义application：willPresentError：并返回包含恢复所需信息的错误对象
因为发生错误传递的错误对象以及用户字典时常数对象，所以上述方法必须要返回一个新创建的错误对象，而且，原错误对象使用新错误对象用户字典汇总NSUnderlyingErrorKey键并保存它（表18-4）
首先，为了让用户选择如何进行恢复，必须按照选择分支的个数来传入按键标题字符串，具体来说，就是想下面的错误对象方法返回字符串数组那样，将数组记录在用户字典中

-(NSArray *)localizedRecoveryOptions
	将警告面板的按键标题所使用的本地化字符串放入数组中返回，用户字典中如果存在NSLocalizedRecoveryOptionsErrorKey键的对象则返回

包含多个字符串时，第一个字符串在面板的最右侧（默认），然后是右边第二个，按照此顺序排列，也可能会返回nil，此时讲过面板只显示“OK”按键
当然，为了使用户选择合适的按钮，需要向用户战术确切的说明消息，如上一章所述，或许也需要预先将NSLocalizedDescriptionKey或NSLocalizedRecoverySuggestionErrorKey键的消息字符串在用户字典中重新记录

接着，在取得按键的选择结果后，指定对象来执行恢复处理，该对象就称为恢复尝试对象（recovery attempter）为了能作为下面的错误对象方法的返回值返回，该对象在用户字典中记录

-(id)recoverAttempter
	返回错误的恢复尝试对象，用户字典中如果存在NSRecoverAttempterErrorKey键的对象则返回如果没有如果则返回nil

恢复尝试对象可以是任意类的实例，但为了进行恢复处理，需要实现下面所示的NSErrorRecoveryAttempting非正式协议的其中任意一个方法，该非正式协议在Foundation/NSError.h中声明

@interface NSObject(NSErrorRecoveryAttempting)
-(void)attemptRecoveryFromError:(NSError *)error
				    optionIndex:(NSUInteger)recoveryOptionIndex
				         delegate:(id)delegate
		       didRecoverSelector:(SEL)didRecoverSelector
				    contextInfo:(void *)contextInfo;
-(BOOL)attemptRecoveryFromError:(NSError *)error
				       optionIndex:(NSUInteger)recoveryOptionIndex;
@end

前者主要被用于窗体页的应用，所以此处不做介绍，后者的情况下，表示错误对象和警告面板中用户选择的按键位置的索引会被作为参数传入，该索引与错误对象的用户字典中传入的字符串数组的索引一致，所以可以访问该值并进行相应的处理，恢复成功时返回YES，该返回值也是最初调用的方法presentError：的返回值
例如，某新错误对象可以选择继续、其他文件、取消这三个选项，返回该对象的方法定义如下所示，因为恢复尝试对象指定了self，所以能够应对选择结果的处理方法必须要在同一个类中定义

-(NSError *)willPresentError:(NSError *)err{
	NSMutableDictionary *dic;	
	NSError *nwerr;
	dic =[NSMutableDictionary dictionaryWithDictionary:[err userInfo]];
	//将原错误对象的用户字典复制为可变的字典对象
	[dic setObject:[NSArray arrayWithObjects:
		NSLocalizedString(@“Continue”,”Continue”),
		NSLocalizedString(@“Try Other”,”Try Other”),
		NSLocalizedString(@“Cancel”,”Cancel”),nil] 
		forKey:NSLocalizedRecoveryOptionsErrorKey];
	//使其能显示3个按键，并进行本地化
	[dic setObject:self forKey:NSRecoveryAttempterErrorKey];
	//指定self为恢复尝试对象
	[dic setObject:err errorWithDomain:[err domain ] code:[err code] userInfo:dic];
	//生成新错误对象
	return nwerr;
}
也可以在NSApp委托中实现同样的方法，此时必须要确保通过访问错误代码和用户字典，可以恰当处理各种类型的错误对象

专栏：单元测试

目前，各种软件开发环境中都提供了可以方便地进行单元测试（单体测试）的机制
单元测试就是在类或方法等单元中确认生成的程序是否正确执行的一种测试，在多数开发环境中，通过在软件开发的同时进行这样的单元测试，就可以在修正程序或添加功能等时机自动执行该测试，因此，该测试不仅能保证程序的质量，对软件的改善（重构）也有不错的效果
即使是ObjectiveC，使用Xcode的程序开发中也可以实施单元测试，这里主要借助了开源的成果，具体来说就是从Xcode构建OCUnit单元测试并执行，本书中不详细介绍Xcode中的实现方法，只简单地说明一下概要
单元测试将SenTestingKit框架类SenTestCase的子类定义为工程目标，从子类方法中调用测试操作，并通过使用SenTestKit框架定义的断言来确认是否能够得到期待的结果，如果结果与预想的不同，断言中就会发送错误报告
关于单元测试的具体实现方法，可以参考“iOS App Development Wordflow Guide（iOS开发向导）”等文档



    """},
  {'title' : '第十九章（1）' , 'message' : """
1、多线程

1.1线程的基本概念

线程（thread）是进城（process）内假想的持有CPU使用权的执行单位，一般情况下，一个进程只有一个线程，但也可以创建多个线程并在进程中并行执行，应用在执行某一处理的同时，还可以接收GUI的输入

使用多线程的程序称为多线程（multithread）运行，从程序开始执行时就运行的线程称为主线程，除此之外，之后生成的线程称为次线程（secondary thread）或子线程（subthread）
创建线程时，创建方的线程为父线程，被创建的线程为子线程，父线程和子线程并行执行各自的处理，但父线程可以等到子线程执行终止后与其会合（join）。而另一个方面，在线程被创建后，页可以切断父子关系指定他们不进行会合，该操作称为分离（detach）这里所说的NSThread就是在分离状态下创建线程
由于被创建的线程共享进程的地址空间，所以能够自由访问进程的空间变量，多线程访问的变量称为共享变量（shared variable）共享变量大多为全局变量或静态变量，但因为地址空间是共享的，所以理论上所有内存区域都可以称为共享变量
如果多线程胡乱访问变量，那么久不能保证变量值的正确性，所以有时候久需要按照一定的规则使多线程可以协调动作，此时久必须执行线程间互斥（或者排他控制，mutual exclusion）（见19.2节）
各个线程都分配有栈且独立进行管理，基本上不能访问其他线程的栈内的变量（自动变量）通过遵守这样的编程方式，就可以自由访问方法或函数的自动变量，而且不用担心互斥
使用引用计数管理方式时，为了使对象之间解耦合，子线程方需要创建与父线程不同的自动释放池来管理，使用垃圾回收时不需要这样

1.2线程安全

多个线程同时操作某个实例时，如果没有得到错误结果或实例没有包含不正确的状态，那么该类久称为线程安全（thread-safe）结果不能保证时，则称为非线程安全或线程不安全（thread-unsafe）
一般情况下，常数对象时线程安全的，变量对象不是线程安全的，常数对象可以在线程间安全地传递，但对变量对象共享时，需要恰当地执行互斥或同步切换
需要注意的是C语言的函数，就现状来看，BSD函数的大部分，例如printf（）等，都不是线程安全的

1.3注意点

在某些情况下，使用多线程可以使处理高速化，实现易于使用的结构，使实现更简单等。但并不是说使用多线程后就一定会得到这些优点
要想使多线程不出错且高效执行，并行编程的知识必不可少，线程间的任务分配和信息交换、共享资源的互斥，与GUI的交互及动画显示等，在使用时都要特别小心
一般情况下，自己实现多线程程序时很困难的，而且也容易埋下高隐患，稍有差池货设计失误，多线程便不能发挥效果，甚至还会导致未知原因的释放或异常终止，使用19.3节中介绍的NSOperation，虽然可以较容易地实现多线程程序，但是也必须掌握线程动作，互斥等相关知识，不能适应这些的读者建议去参考一下并行编程的相关书籍
而且，很多多线程中遇到的问题都可以通过NSTimer类或延迟消息发送（参考15.1节）来解决，大家也不妨尝试一下用这些方法来解决相关问题

1.4使用NSThread创建线程

Foundation框架中提供了NSThread类来创建并控制线程，该类的接口在Foundation/NSThread.h中声明
创建新线程需要执行下吗的类方法：

-(void)detachNewThreadSelector:(SEL)aSelector
					 toTarget:(id)aTarget
				     withObject:(id)anArgument
	对对象aTarget调用方法创建新线程并执行，选择器aSelector必须是仅获取一个id类型参数且返回值为void的执行方法（参考8.2节）

指定的方法执行结束后，线程也随之终止，线程从最初就被执行了分离，所以终止时没有和父线程会合，当主线程终止时，包含子线程的程序也全部随之终止
使用引用计数管理（手动及ARC）时，有时需要执行的方法自身来管理自动释放池，此外，参数aTarget和anArgument中指定的对象也与线程同时存在，即在创建线程时被保存，在线程终止时被释放
使用下述的NSApplication类中的方法也能创建线程，该方法使用上面的方法，而且在使用引用计数管理时还会创建线程的自动释放池

+(void)detachDrawingThread:(SEL)selector
				   toTarget:(id)target
			       withObject:(id)argument

创建新线程并执行的方法除了上述还有很多，本书中不再一一介绍，其他方法请参考NSThread、NSObject的参考文档
程序可以调用NSThread类方法来确认是否时多线程运行

+(BOOL)isMultiThreaded
	多个线程并行执行时或者只有主线程在执行时，只要在此之前已经创建了线程，则返回YES

1.5当前线程

一个线程称自身为当前线程（current thread）区别于其他线程
子线程将创建时指定的方法执行完后也会随之终止，但也可以中途终止，为此，可以使用当前线程（线程自身）来执行下一个NSThread类方法。但是，使用引用计数管理时，终止前一定要释放自动释放池

+(void)exit

使用下述方法获得表示线程的NSThread实例
+(NSThread *)currentThread
	获得表示当前线程的NSThread实例
+(NSThread *)mainThread
	获得表示主线程的NSThread实例，查看当前线程是否为主线程时，可以使用类方法isMainThread

每个线程都可以持有一个该线程固有的NSMutableDictionary类型的字典，向NSThread实例发送下面的消息类就可以取得字典

-(NSMutableDictionary *)threadDictionary
	
可以时当前线程仅被中断几秒，为此，可在线程中执行下面的类方法，参数为实数

+(void)sleepFOrTimeInterval:(NSTimeInterval)ti

也可以时线程在某一时刻前被中断，这是可采用下面的类方法，参数时表示日期的类NSDate实例

+(void)sleepUntilDate:(NSDate *)aDate

如果要是线程到某个条件成立前一直保持休眠状态，则要使用下一章节介绍的锁

1.6GUI应用和线程

在适应GUI的应用中，事件处理和绘图等大部分处理中线程都发挥类重要作用，也可以在子线程中创建窗体，或分担部分绘图功能，但要注意避免竞争或内存泄露，详情请参考相关文档
GUI应用中有较容易的方法来使用线程，即将GUI相关的事件处理或绘图集中在主线程中进行。使用下面的方法，捷克语从子线程依赖主线程中的方法处理，该方法为nSObject的范畴，在头文件Foundation/NSThread.h中声明

-(void)performSelectorOnMainThread:(SEL)aSelector
					    withObject:(id)arg
				       waitUntilDone:(BOOL)wait
	选择器aSelector和参数arg中指定的方法的执行依赖于主线程，wait为YES时，当前线程会一直等待至执行结束，主线程中必须有事件循环（运行回路）


2、互斥
	
2.1需要互斥的例子

在多线程环境中，无论哪个函数或方法都可以在多线程中同时执行，但是，在使用共享变量时，或者在执行文件输出或绘图等的情况下，多线程同时执行就可能得到奇怪的结果
例如，使用整数全局变量totalNumber来累加所处理的数据的个数，为了执行下面的加法计算在多线程环境汇总执行该方法会得到什么结果呢？

-(void)addNumber:(NSIngeger)n{
	totalNumber +=n ;
}

在OS功能支持下，线程在运行的过程中会时而得到CPU的执行权，时而被挂起执行权，2个方法的执行情况如图19-1中所示，在该图中，线程1将新计算的值保存在寄存器时挂起CPU执行权，同时线程2开始执行方法，即使CPU的执行权被挂起，寄存器的值也仍然可以被保存，所以各线程都能正常处理，但是，由于线程2写入的值消失了，因此整体上看，这偏离了我们期待的结果，原因是值的读取、更新、写入操作被多线程同时执行了
￼
在图19-1的例子中，我们将同时只可以由一个线程占有并执行的代码部分称为临界区（critical section）或称为危险区，互斥的目的就是限制可以在临界区执行的线程

2.2锁

为了使多个线程间可以相互排斥地使用全局变量等共享资源，可以使用NSLock类，该类的实例也就是可以调整多线程行为的信号量（semaphore）或者互斥型信号量（mutual exclusion semaphore）Cocoa环境中也称为锁（lock）
锁具有每次只允许单个线程获得并使用的性质，获得锁称为加锁，释放锁称为解锁
锁和普通的实例一样，使用类方法alloc和初始化器init来创建并初始化，但是，锁应该在程序开始在多线程执行前创建

NSLock *countLock =[[NSLock alloc]init];

获得锁的方法和释放（unlock）锁的方法都在协议NSLocking中定义

-(void)lock
	如果锁正被使用，则线程进入休眠状态
	如果锁没有被使用，则将锁的状态变为正在使用，线程继续执行
-(void)unlock
	将锁置为没有在被使用，此时如果有等待该锁资源的正在休眠的线程，则将其唤醒

在上例中，使用锁后会产生如下效果，但需要预先创建NSLock的实例aLock，在该代码中，从某线程执行1取得锁到该线程执行2释放锁期间，其他线程在执行1时将休眠状态，不能执行临界区代码，锁被释放后，在执行1时休眠的线程中选择一个线程，该线程在取得锁后进入临界区执行

-(void)addNumber:(NSIngeger)n{
	[aLock lock];//1
	totalNumber +=n; //临界区
	[aLock unlock];//2
}

某个锁被lock后，必须执行一次unlock，而且lock和unlock必须在同一个线程执行
下面来看另外一个使用锁的例子，考虑一下全局变量值自增时返回其结果的方法，多线程执行时，全局变量theCount若想正确地自增，就需要使用锁countLock来管理
可以采用如下定义：

-(int)inc{
	[countLock lock];
	++theCount;
	[countLock unlock];
	return theCount;
}

乍一看好像没问题，但从释放锁到返回值期间，其他线程可能hi修改变量值，如下所示：

-(int)inc{
	int tmp;

	[countLock lock];
	tmp = ++theCount;
	[countLock unlock];
	return tmp;
}

各线程持有独立的栈，自动变量tmp可以在整个线程中局部利用，而且无需担心被其他线程访问，如果按照这样的方式执行，就可以得到临界区之后的正确值

2.3死锁

线程和锁的关系必须在设计之初就经过仔细的考虑，如果错误的使用锁，不但不能按照预期执行互斥，还可能是多个线程陷入到不能执行的状态，即死锁（deadlock）状态
死锁就是多线程（或进程）永远在等待一个不可能实现的条件而无法继续执行，如图19-2所示
￼
线程1占有文件A并正在进行处理，途中又需要占有文件B，而另一方面，线程2占有着文件B，图中又需要占有文件A，大家不妨设想一下，如果线程1和线程2同时执行到了图中的箭头闻之会怎么样？线程1为了处理文件B想要获得锁lockForB，但是它已经被线程2获得，同样，线程2想要获得的锁lockForA也被线程1占有，这种情况下，线程1和线程2就会同时进入休眠状态，而且双方都不能跳出该状态
像这样，当多个线程互相等待资源的释放时，就非常容易出现死锁现象，有时是多个线程相干预，有时则是一个线程因为自己需要获得锁儿进入休眠状态，此外，由于多数情况下各个线程本身并没有错误处理，而且死锁又随时可能发生，因此追究原因就非常困难，也不能排除导致程序bug的可能

2.4尝试获得锁

NSLock类不仅能获得锁和释放锁，还有检查是否能获得锁的功能，利用这些功能，九可以在不能获得锁时进行其他处理

-(BOOL)tryLock
	用接收器长期获得某个锁，如果可以取得该锁则返回YES，不能获得时，与lock处理不同，线程没有进入休眠状态，而是直接返回NO并继续执行

该方法十分便利，但要确保只能在可以获得锁时才执行unlock，创建程序时必须要注意这一点

2.5条件锁
类NSConditionLock称为条件锁（condition lock）该锁持有整数值，根据该值可以获得锁或者等待

-(id)initWithCondition:(NSInteger)condition
	NSConditionLock实例初始化，设置参数condition指定的值
	NSConditionLock的指定初始化器
-(NSInteger)condition
	此时返回锁中设定的值
-(void)lockWhenCondition:(NSInteger)condition
	如果锁正在被使用，则线程进入休眠状态
	锁不在被使用时，如果锁值和参数condition的值一致，则将锁状态修改为正在被使用，然后继续执行，如果不一致，则线程进入休眠状态
-(void)unlockWithCondition:(NSInteger)condition
	在锁中设置参数condition指定的值，将锁设置为不在被使用，此时如果有等待获得该锁且处于休眠状态的线程，则将其唤醒
-(BOOL)tryLockWhenCondition:(NSInteger)condition
	尚未使用锁且锁值与参数condition相同时，获得锁并返回YES，不能获得锁时也不进入休眠状态，而是返回NO，线程继续执行

使用方法lock、unlock或tryLock都可以获得锁和释放锁，而且无需关系锁的值
然而，由于NSConditionLock实例可以持有的状态为整数行，所以实现用枚举常数或宏定义就可以了，如果只使用0或1，不仅不容易理解，也可能造成错误

2.6NSRecursiveLock

某线程获得锁后，到该线程释放锁期间，想要获得该锁的线程就会进入休眠，使用类NSLock的锁时，如果已经获得锁的线程在没有释放他的情况下，还想再次获得该锁，该线程也会进入休眠状态，但是，由于没有从休年状态唤醒的线程，所以这就是死锁，下面是一个简单的例子，这段代码不会执行

[aLock lock];
[aLock lock];//这里发生死锁
[aLock unlock];
[aLock unlock];

解决这种情况可以使用NSRecursiveLock类的锁，拥有锁的线程即使多次获得同一个锁也不会进入死锁，但是，其他线程当然也不能获得该锁，获得次数和释放次数一致时，锁就会释放
NSRecursiveLock类的锁使用起来非常方便，但排除被重复加锁的情况，用NSLock来重新记述的话，性能则会更好

2.7 @synchronized

程序内的块可以指定为不被多线程同时使用，为此可以使用@synchronized编译符，如下所示：

语法：线程的锁
@synchronized(obj){
	//记述想要排斥地执行的内容
}

通过使用该段代码，运行时系统就可以创建排斥地执行该代码块的锁（mutex）参数obj通常指定为该互斥锁想要保护的对象，obj自己不需要时锁对象
线程如果要执行该代码块，首先会尝试获得锁，如果能获得锁则可以执行块内代码，块执行结束时一并释放锁，使用break或return从块内跳出到块外时也被视作块执行终止，而且，在块内发生异常时，运行时系统会捕捉异常并释放块
@synchronized的参数对象决定对应的块，所以，同一个对象参数的@synchronized块如果有多个，则不可以同时执行
根据参数的选择方法的不同，@synchronized会在并行执行的受限对象和可以执行的普通对象之间动态切换，下面展示@synchronized参数的使用示例
（a）时指定只能单独存在的对象时的情景，同一个对象在其他地方也作为@synchronized的参数使用时，所有这些块不能同时执行，（b）也是一样，因为限制了参数的使用范围，互斥对象显然只能是该方法内的块
（c）是各个实例互斥的例子，一个实例一次只能执行一个线程，同一个类别的其他实例则多个线程可以同时存在，（d）在参数对象可能在多个地方更改的情况下有效，但以同样方式使用该对象的所有场所中都需要按照该方式书写，否则就没有任何意义
而且，也可以按照（e）的方式书写，此外还可以指定类对象，或者使用消息选择器（隐藏参数的_cmd）来指定方法等，不过一般情况下，为互斥的对象使用专门的锁对象是比较可靠的方法

static id g=…;

-(void)doSomething:(id)arg{
	static id loc=…;
	@synchronized(g){ … }  //a
	@synchronized(loc){ … }//b
	@synchronized(self){ … }//c
	@synchronized(arg){ … }//d
	@synchronized([self localLock]){ … }//e
}

@synchronized与上述NSRecursiveLock类的锁一样，可以递归调用，例如，下述这种简单的例子就不会死锁

@synchronized(obj){
	@synchronized(obj){
		….
	}
}

使用@synchronized块时，加锁和解锁必须成对进行，因此可以预防加锁后忘记解锁这种问题的发生，和普通的锁相比，复杂的并行算法的书写会较为复杂，但多数情况下都会使互斥更容易理解
    """},
  {'title' : '第十九章（2）' , 'message' : """
3、操作对象和并行处理

3.1新的并行处理程序

Mac OS X10.6及iOS4.0 后，导入了可以使系统全体线程更高效运行，并且使并行处理应用更易开发的架构，称为大中央调度（GCD ，Grand Central Dispatch）
目前为止，为了提高应用的运行速度和GUI的易用性，程序多采用了多线程，但是，这就需要与线程的创建、同步、共享资源的互斥等相关的知识、观察力、经验及技术，而且代码的调试和功能扩展也存在诸多困难
在使用GCD的程序中，可以将想要提高处理速度的部分分解为非同步执行的多个任务，并将这些任务放入等待队列（queue）中，虽然必须要指定任务见的依赖关系（前后关系）但却不需要关系线程的创建和调度，然后CPU内核书以及其他应用的要求都会被动态地判断，有系统决定最佳的并行成都和高效的调度方式并执行
GCD的核心使用C语言写的的系统服务，应用将应该执行的各种任务封装程块对象写入到队列中，通过对比各任务启动线程的代码，该操作可以非常轻量地运行
为了直接使用GCD的功能，必须要使用C语言函数，然而，在ObjectiveC中，通过用NSOperation类来表示任务，并将其追加到NSOperationQueue类队列中，即可实现并行处理，下面，将蛋说明这些类的使用方法，详细内容请参考“Concurrency Programming Guide”“Grand Central Dispatch（GCD）Reference”等文档
在下面的说明中，我们将需要执行的任务聚合在一起，称为抽象任务（task）

3.2使用NSOperation的处理概述

和将NSArray实例称为数组对象一样，下面的NSOperation实例也可以称为操作对象（operation object）或简称为操作
操作对象可以将需要执行的代码和相关数据集成并封装，操作对象通常不是被直接执行吗，而是在等待队列中按顺序调用，线程也不是一直被创建，而是保持一定的数量，并将操作交给空闲线程处理（图19-3）这种线程管理方式称为线程池，在GCD中，线程数由硬件或当前系统的整体负荷等条件来决定，至于各个操作在哪个线程执行以及采取怎样的调度方式等，编程人员则不用关系
￼
操作不仅仅可以按照等待队列中的顺序被调用，也可以像“任务A完成后调用任务B”这样指定调用的先后关系，此案死，任务B依赖于任务A，这种关系称为依赖关系（dependency）而且，还可以设定操作的优先权（priority）
为操作提供了等待队列功能的是NSOperationQueue类，以下将该类的实例称为操作队列（operation queue）或简称为队列，等待队列是一种先入先出的数据结构，也称为FIFO（First in First Out）操作一旦被加入到队列，至于如何执行，就要任凭系统来调度，但是，加入到队列的操作在执行之前也可以取消
下面我们来看一下如何将NSOperation类加入队列并执行任务，不过，在此之前，这里先介绍一下啊其他操作，操作对象也可以直接调用start方法来执行任务，但是为了能并行执行任务，标准做法实在start内创建线程，本书中不在介绍按照这种方式使用操作对象的方法，关于操作的定义方法等详细内容，请参考NSOperation类的参考文档或“Concurrency Programming Guide”

3.3NSOperation和NSOperationQueue的简单用法
NSOperation提供了处理任务的功能，他本事又是抽象类，所以就需要先定义子类，然后再在子类汇总定义必要的处理，但是，由于操作对象可以被多个线程同时访问，因此子类方法必须是线程安全的，NSOperation实例在头文件Foundation/NSOperation.h中定义
NSOperation子类必须将要执行的任务写入到下面的main方法中，由于在NSOpaeration中定义的方法不发挥任何作用，所以并没有必须调用super

-(void)main

NSOperation子类至少需要包含main方法，此方法应按照如下方式定义，利用垃圾回收机制时不需要自动释放池，只需要启动垃圾回收器即可，另外，@catch后的括号内并不表达省略的意思，而是就应该写成…（见18.3节）

-(void)main{
	try{
		@autoreleasepool{
			//这里书写任务中需要进行的处理
		}
	}
	catch(…){
	//再次抛出异常，不能使用@throw等向外部传播	
	}
}

NSOperation子类可以根据需要定义初始化器，由于NSOperation类指定的初始化器为init，因此子类的初始化器一定会调用init
NSOperationQueue的使用方法也很简单，创建实例后，将操作对象加入到队列中即可，NSOperationQueue接口在头文件NSOperation.h中定义，初始化器使用init
可以使用下面的方法将操作对象添加到队列

-(void)addOperation:(NSOperation *)operation

使用引用计数方式（手动或ARC）进行内存管理时，程序会一直保持着添加到队列中的操作对象，使用垃圾回收时，因为队列需要访问操作对象，所以知道执行终止操作对象才会被释放
创建的队列即使被多个线程同时操作也不会出任何问题，因此并不需要为互斥加锁，或者用@synchronized开来保护
一个程序中可以创建多个队列，到那时，一个操作对象一次只能加入到一个队列中，而且，一执行完或正在执行的操作对象都不可以加入到队列中，否则就会引发异常
操作对象一旦加入到队列，就不能从队列中消除，如果不想执行该任务，则可以取消该处理，稍后会说明取消的方法

3.4等待至聚合任务终止

虽然无法知道任务按照什么样的顺序执行，但在队列中添加的操作全部完成之前的这段时间通过使用NSOperationQueue的下述方法，就可以一直锁住当前线程（使之等待）这样一来，在聚合任务终止后就可以简单地进行下一个任务

-(void)waitUntilAllOperationsAreFinished
	到接收器队列中添加的操作全部执行完为止，一直加锁调用该函数的线程，队列为空时，没有要执行的任务，该方法立即返回
	调用该方法的线程在被锁期间，接收器队列会继续执行，其他线程也可以添加操作
-(void)addOperations:(NSArray *)ops
       waitUntilFinished:(BOOL)wait
	将数组ops中的操作对象添加到接收器队列中，参数wait为YES时，到指定操作执行完为止，调用该方法的线程一直处于被锁状态
	使用引用计数管理方式时，添加的操作对象被保存在队列中，二数组ops则不被保存

3.5使用操作对象的简单例子

代码清单19-1中展示了一个简单的程序例子（使用ARC）该程序中定义了操作对象MyOperation类，任务内容时等待一个随机事件将任务变好添加到MyList数组中，线程执行各任务时没回分别封袋不同的时间，因此MyList中的任务编号理应不会按顺序排列，main函数会常见Tasks个操作对象并将其按顺序添加到队列中
队列保存操作对象，知道任务终止后操作对象才被释放，在dealloc方法中，尝试使用NSLog来输出信息
而且，可以使用waitUntilAllOperationsAreFinished方法来查看是否所有线程都终止了，但此时操作对象会被同时释放，所以很难知道任务终止的顺序，于是，这里设置为了等待2.0秒（在某些环境下着需要等待更长时间，否则所有任务或许就不能都结束）

代码清单19-1 NSOperation的使用示例

#import <Foundation/Foundation.h> //使用ARC
#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>

NSMutableArray *MyList;

@interface MyOperation : NSOperation{
    int number; //各任务号
    NSTimeInterval interval;//时间间隔
}
-(id)initWithNum:(int)sn;
-(void)main;

@end

@implementation MyOperation

-(id)initWithNum:(int)sn{
    if((self =[super init]) !=nil){
        number =sn;
        interval =(double)(random() &0x7f) /256.0;
    }//生成少于0.5秒的随机值
    return self;
}
-(void)dealloc{ //释放时打印信息
    NSLog(@"Release:%d",number);
}
-(void)main{
    @try{
        @autoreleasepool {
            NSNumber *obj =[NSNumber numberWithInt:number];
            [NSThread sleepForTimeInterval:interval];//等待一会
            @synchronized (MyList) {
                [MyList addObject:obj];
            }
        }
    }
    @catch(...){ /*只捕捉异常，不做任何操作*/}
}
@end

int main(void){
    const int Tasks=10;
    srandom((unsigned)getpid());//随机数种子
    
    @autoreleasepool {
        int i;
        NSOperationQueue *queque =[[NSOperationQueue alloc]init];
        MyList =[[NSMutableArray alloc]init];
        
        for(i =0;i<Tasks ;i++){ //创建操作并将其添加到队列中
            NSOperation *opr =[[MyOperation alloc]initWithNum:i];
            [queque addOperation:opr];
        }
        [NSThread sleepForTimeInterval:2.0];//等待终止
        for (id obj in MyList) {
            printf("%d",[obj intValue]);
        }
        printf("\n");
    }
    return 0;
}

运行结果：
￼

该程序每次运行时结果都不一样，例如，可以得到上面的结果（包括NSLog（）打印的开始部分）

最后一行为main函数的输出结果，可以看出，基本上是按照任务在数组中加入号的顺序来释放的操作对象，另外，在NSLog的输出中，括号内的数组为进程id和线程号，可见，不仅有多个线程被创建，有些线程还承担着多个任务的处理

3.6NSInvocationOperation的使用方法

在Cocoa框架中，NSOperation的子类包括NSInvocationOperation和NSBlockOperation，使用这些类时，即使不定义子类也能创建操作对象
这里先简单介绍一下NSInvocationOperation
NSInvocationOperation使用如下初始化器，返回向目标对象发送消息的任务操作对象，当任务内容已经被作为方法定义时，该方法有效

-(id)initWithTarget:(id)target
		selector:(SEL)sel
		    object:(id)arg
	初始化示例，是参数选择器sel向target发送消息，可以指定包含一个参数的选择器，并指定参数arg，选择器没有包含参数时，向arg传入nil
	使用引用计数管理方式时，target和arg会通过调用初始化器被保存，并在接收器的操作被释放时被release，而且，该操作会在创建自动释放池后执行任务

3.7NSBlockOperation的使用方法

NSBlockOperation使用块对象构造任务，使用下面的类方法可以创建临时示例

+(id)blockOperationWithBlock:(void (^)(void))block
	返回以参数中指定的块对象为任务的临时操作对象，参数块对象被生成复制，并在操作对象内保存，使用引用计数管理方法时，该操作会在创建自动释放池后执行任务

使用该方法，可以将代码清单19-1的程序修正为代码清单19-2的程序，这里只显示了对应的循环部分，如果任务很简单，使用NSBlockOperation和块对象就可以紧凑地书写，另外，虽然在循环中使用了块对象，但由于方法blockOperationWithBlock：会生成参数的复制，因此包含各种不同值的块对象就会被生成

代码清单19-2 NSBlockOperation的使用示例

for(i =0;i<Tasks ;i++){ //创建操作并将其添加到队列中
            NSBlockOperation *opr;
            NSTimeInterval interval =(double)(random()&0x7f)/256.0;
            opr =[NSBlockOperation blockOperationWithBlock:^{
                NSNumber *obj =[NSNumber numberWithInt:i];
                                [NSThread sleepForTimeInterval:interval];
                                @synchronized(MyList){
                                    [MyList addObject:obj];
                                }}];
            [queue addOperation:opr];
        }
        [queue waitUntilAllOperationsAreFinished];//等待终止

由于没有包含类似于代码清单19-1的dealloc方法的部分，因此，执行结果如下所示，只有一行输出
￼
然而，通过使用NSOperationQueue的addOperationWithBlock：方法，就可以在一次调用中完成复制块对象，创建操作对象，并将其追加到队列中这一系列操作

3.8NSBlockOperation中添加多个块对象

NSBlockOperation中包含数组对象，里面保存着多个块对象，而且这些块对象可以被当作任务执行，当有多个块对象时（如果可能的话）这些块对象就会被并行执行，下面是与数组相关的方法

-(void)addExecutionBlock:(void (^)(void))block
	将参数块追加到接收器数组中
-(NSArray *)executionBlocks
	返回接收器包含的块对象数组

NSBlockOperation是NSOperation的子类，可以使用init初始化，初始化后，块对象数组中没有任何元素

3.9设置任务间的依赖

当存在多个任务时，有时我们会需要指定一定的顺序关系，在执行某个任务后继续执行另一个任务，比如，当其他任务需要使用某个任务的处理结果时，或绘图处理的前景和背景有关联时，都需要这样的顺序关系，当然，如果所有任务的处理顺序已经确定，那么也就没有并行处理的必要了。在多任务中某些任务有依赖关系，二其他任务可以并行处理，这也是有效的
对莫哥操作对象A来说，可以设定比A更靠前执行的操作对象B，因此，可以表示为任务A依赖于任务B，在队列中加入的多个操作对象中，可以执行的操作被一个接一个地处理，而有依赖关系的情况下，则在前者处理结束后再执行后面的操作
然而，如果有多个队列，也可以将有依赖关系的操作分别加入多个队列中
NSOperation中定义的设置依赖关系及解除关系的方法如下：

-(void)addDependency:(NSOperation *)operation
	将接收器操作依赖的，也就是比较接收器先执行的操作指定为参数
-(void)removeDependency:(NSOperation *)operation
	从接收器中删除注册的依赖操作
-(NSArray *)dependencies
	创建新数组，接收器保存依赖操作并返回，数组中也包括已经终止的操作，不包含依赖操作时，返回空数组

修改代码清单19-1的程序，将10个操作设定为如图19-4所示的依赖关系
￼
在该图中，例如操作2必须先于操作0执行，这些都使用箭头表示了出来，操作4必须在操作0和操作5都执行完毕后才可以执行，操作1、7、8、9之间没有依赖关系
该依赖关系中，箭头不能形成闭环，也就是说，可以沿箭头执行的方向返回到原点的依赖关系时被禁止的，闭环关系中的所有操作都不能执行，因此处理也不能终止
代码清单19-3展示了代码清单19-1中发生改变的部分代码

代码清单19-3设置操作中的依赖关系并执行的例子

  NSOperation *oprs[Tasks];
        for(i=0;i<Tasks;i++)
            oprs[i] =[[MyOperation alloc]initWithNum:i];
        [oprs[0] addDependency:oprs[2]];//操作0在操作2之后
        [oprs[5] addDependency:oprs[2]];
        [oprs[4] addDependency:oprs[0]];
        [oprs[4] addDependency:oprs[5]];
        [oprs[3] addDependency:oprs[6]];
        for(i=0;i<Tasks;i++)
            [queue addOperation:oprs[i]];
        [NSThread sleepForTimeInterval:3.0];//等待终止

结果：
￼
图19-5中显示了执行结果，因为使用了随机数，所以每次的执行结果都不一样，这里提取了3次执行结果，设置了依赖关系的操作的执行顺序如箭头所示，可以看出，有依赖关系的两个操作间还有其他操作被执行，但无论如何，所执行的执行顺序都没有变
￼


3.10任务的优先级设置

在多个任务中，既有需要比其他任务优先执行的任务，也有非优先执行的任务，很多时候我们都会需要进行这样的设定，此时可以使用NSOperation提供的优先级的设定方法
但是，并不能保证高优先级的任务一定会先于低优先级的任务执行

-(void)setQueuePriority:(NSOperationQueuePriority)priority
	为接收器的操作指定优先级
-(NSOperationQueuePriority)queuePriority
	返回接收器的优先级

这里，表示优先级的NSOperationQueuePriority为整数类型，使用按如下方式定义的常数，即使指定其他整数值，也会被修改为最接近的常数，因此是无效的

enum{
	NSOperationQueuePriorityVeryLow =-8,//最低优先级
	NSOperationQueuePriorityLow =-4,
	NSOperationQueuePriorityNormal =0,//一般优先级
	NSOperationQueuePriorityHigh =4,
	NSOperationQueuePriorityVeyHigh =8 //最高优先级
};
typedef NSInteger NSOperationQueuePriority;

3.11设定最大并行任务数

操作队列可以同时启动多个任务的情况下，可以设定最多可以并行执行的任务数，NSOperationQueue提供了下面的方法

-(void)setMaxConcurrentOperationCount:(NSInteger)count
	设定可以并行执行的最大操作数
-(NSInteger)maxConcurrentOperationCount
	返回可以并行执行

一般情况下，任务的并行执行可以根据系统状况判断，选择该状态时，指定常数值NSOperationQueueDefaultMaxConcurrentOperationCount该值为确定值（实际值为-1）
即使指定了最小值为1.也不一定会按照加入到队列时的顺序来处理任务，而且，指定较大数字也不会使执行更高速

3.12终止任务

下面向大家介绍一下如何取消对了中的操作对象的任务，NSOperation有如下方法：

-(void)cancel
	使下面的方法isCancelled返回YES
-(BOOL)isCancelled
	接收上面的cancel方法后返回YES，否则返回NO，任务正在执行时或执行终止后也可以返回YES

而且，NSOperationQueue类中也有如下方法

-(void)cancelAllOperations
	此时向队列中的所有操作对象发送cancel消息

操作对象即使接收cancel，也并不代表插入或异常这样的特殊处理或悲执行
isCancelled在任务执行前接收cancel并返回YES，操作对象将被解除执行
在任务执行的过程中接收到cancel时，为了转移到中断处理，任务内容必须如下方式编程实现，具体来说，程序在main方法的开头以及在处理途中的各个重要地方检查自己的isCancelled的值，如果返回YES则进行中断处理

3.13设置队列调度为中断状态

也可以临时停止某个操作队列的执行，来停止执行队列中的操作，停止的队列也可以再回复，中断和解除的方法在类NSOperationQueue中定义

-(void)setSuspended:(BOOL)suspend
	将接收器的队列变成中断状态或者解除队列的行为，参数指定为YES时时中断状态，进入中断状态后，停止从新的队列中取出操作并执行
	即使为中断状态，也可以向队列中添加操作，而且即使处于中断状态，也不会停止正在执行的任务

-(BOOL)isSuspended
	接收器队列如果处于中断状态则返回YES，否则返回NO


    """},
  {'title' : '第十九章（3）' , 'message' : """
4、并行处理的示例程序

4.1程序概念

这里将介绍在程序中使用操作对象的例子
我们在第17章中创建了简单的视图图形，其中增加了一览显示指定目录中包含的图像文件的功能。双击一览显示的小图像，就可以显示出普通大小的图像，原来的图像视图的部分保持不变，这里，将新应用的名字定为BrowsingViewer，使用ARC来管理内存
￼
新对象的关系如图19-6所示，这里没有像以往那样放置MyViewerCtrl的实例，而是放置了他的子类BrowsingViewerCtrl，该对象可以指定希望一览显示的目录，并创建BrowsingWinCtrl实例。BrowsingWinCtrl实例会显示一个窗体，来显示图像文件一览，为显示图像，操作对象使用DrawOperation类的实例，其他方面，main函数或信息文件等本地化资源中，有些部分必须改变
下面仅仅展示了其中的部分源码，这是因为有关窗体和图像显示的部分大都涉及尺寸和坐标计算，和本例的并行处理没有直接关系

4.2类BrowsingViewerCtrl
代码清单19-4是类BrowsingViewerCtrl的实例，该类也是MyViewerCtrl的子类，因此只是新增了方法openDirectory：在指定目录时，该方法会显示打开面板

代码清单19-4 BrowsingViewerCtrl的接口部分

#import "MyViewerCtrl.h"

@interface BrowsingViewerCtrl : MyViewerCtrl
-(void)openDirectory:(id)sender;
@end

代码清单19-5为类BrowsingViewerCtrl的实现部分，显示打开面板之前的内容都比较简单，记述关闭面板后的处理的块文法却很长
在块中，使用类NSFileManager将表示指定目录内的文件的URL对象保存在数组files中，由于数组types中加入了系统可处理的图像文件的后缀名，因此，利用这一点，就可以只将数组files内包含图像文件后缀名的URL放入到可变数组images中，最后，创建类BrowsingWinCtrl实例并传入数组，BrowsingWinCtrl是一览显示图像的窗体管理类

代码清单19-5 BrowsingViewerCtrl的实现部分

#import "BrowsingViewerCtrl.h"
#import <Cocoa/Cocoa.h>
#import "BrowsingWinCtrl.h"

@implementation BrowsingViewerCtrl

-(void)openDirectory:(id)sender{
    NSOpenPanel *oPanel =[NSOpenPanel openPanel];//打开面板
    [oPanel setAllowsMultipleSelection:NO];//不能选择多个文件
    [oPanel setCanChooseDirectories:YES];//可以选择目录
    [oPanel beginWithCompletionHandler:^(NSInteger result){
        NSArray *files,*types;
        if(result !=NSModalResponseOK)
            return;
        files =[[NSFileManager defaultManager]
                contentsOfDirectoryAtURL:[oPanel URL] includingPropertiesForKeys:NULL options:NSDirectoryEnumerationSkipsHiddenFiles error:NULL];
        //将选中目录中的文件的URL放入数组中
        types =[NSImage imageTypes];//图像文件后缀名
        NSMutableArray *images = [NSMutableArray array];
        for(NSURL *url in files){
            if([types containsObject:[url pathExtension]])
                [images addObject:url];
        }//只将包含图像文件后缀名的URL保存在数组images中
        if([images count] >0)
            (void)[[BrowsingWinCtrl alloc]initWithURLs:images];
    }];
}

@end

4.3类BrowsingWinCtrl

类BrowsingWInCtrl的接口部分如代码清单19-6所示，只增加初始化器，并指定窗体委托的协议

代码清单19-6 BrowsingWinCtrl的接口部分

#import <Cocoa/Cocoa.h>
@interface BrowsingWinCtrl :NSObject <NSWindowDelegate>
-(id)initWithURLs:(NSArray *)content;
@end

代码清单19-7是实现部分，所有实现变量都在这里，由于图像的显示使用NSOperation因此这里包含了队列实例变量，配置图像的视图使用docView来访问，但由于时window内部包含的组件，因此使用弱引用
类BrowsingWinCtrl在所管理的窗口中配置图像的情形如图19-7所示，图像缩小、横竖大小都需要在PicSize范围内，图像仅以PicMargin为间隔排列，PicSize、PicMargin是在BrowsingWinCtrl.m中定义的宏，hpics为窗体中显示的行数，wpics为每行的图像数据，图像较多的情况下可以使用滚动条来查看全体图像，此时全体行数为rows，从应该显示的图像个数，到横向纵向各排列多少个图像，都由方法fixDimensions：决定
￼
方法showImages创建用于显示各图像的操作对象，然后将其加入到队列中，操作对象被定义为类DrawOperation初始化时传入URL、显示区域（视图）、显示位置的坐标
方法initWithURLs：为初始化器，参数为保存图像文件URL的数组，根据该数组的元素个数决定窗体的尺寸，并设定绘图用的视图后显示窗体，最后使用操作对象显示图像
类定义中的一大部分都被用在了计算窗体尺寸和图像的配置方法

代码清单19-7 BrowsingWinCtrl的实现部分

#import "BrowsingViewerCtrl.h"
#import "BrowsingWinCtrl.h"
#import "DrawOperation.h"

#define PicSize 200
#define PicMargin 6
#define PreviewSize (PicSize + PicMargin)
#define ScreenMargin 48

@implementation BrowsingWinCtrl{
    NSArray  *imageURLs;//文件URL
    NSWindow *window;//用于一览显示的窗体
    __weak NSView * docview;//图像配置视图
    NSOperationQueue *queue;//操作队列
    int wpics,hpics,rows;//横向和c纵向的图像个数
}
/*Local Method:决定横向和纵向的图像个数*/
-(void)fixDimensions:(int)count{
    /*省略详细内容，窗体中纵向的图像数为hpics，横向的图像数为wpics
        使用滚动条，全体行数为rows*/
}
/*Local Method:c创建操作对象来显示图像*/
-(void)showImages{
    int i,count;
    int x,y;
    NSPoint loc;//各个图像左下角的坐标
    CGFloat hgt;//表示域的纵向长度
    DrawOperation *op;
    
    count =[imageURLs count];//图像文件的个数
    hgt = [docview frame].size.height;//表示域的纵向长度
    for(i =0;i<count;i++){
        y=i/wpics;
        x=i-(y*wpics);
        loc.x = (x * PreviewSize);
        loc.y =hgt - (y*PreviewSize) -PicSize;//左下角为原点
        op=[[DrawOperation alloc] initWithURL:[imageURLs objectAtIndex:i] parentView:docview at:loc];
        [queue addOperation:op];
    }
}
-(id)initWithURLs:(NSArray *)content{
    NSScrollView *scview;
    NSClipView *clip;
    NSString *pathname;
    BOOL withScroller;
    NSRect contrect,viewrect;
    NSUInteger wstyle =(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable);
    if((self = [super init]) ==nil)
        return nil;
    [DrawOperation setPictureSize:PicSize];//设置图像大小
    queue=[[NSOperationQueue alloc]init];//初始化队列
    [queue setMaxConcurrentOperationCount:10];//设置最大数
    imageURLs =content; //  保存URL的数组
    [self fixDimensions:[imageURLs count]];//确定纵向的图像数
    /*省略 确定q窗体和绘图区域的大小，初始化设定*/
    [window makeKeyAndOrderFront:self];//显示窗体
    [[BrowsingViewerCtrl sharedController]addWinCtrl:self];
    [self showImages];//c使用操作对象显示图像
    return self;
}
/*Delegate Messages*/
-(BOOL)windowShouldClose:(NSWindow *)sender{
    [window setDelegate:nil];//解除委托
    window=nil; //放弃附属关系
    [queue cancelAllOperations];//停止操作队列
    [[BrowsingViewerCtrl sharedController]removeWinCtrl:self];
    return YES;
    
}
@end

4.4类DrawOperation

代码清单19-8 19-9中的类DrawOperation为操作对象，用于将给定URL的图像缩小，并将其绘制在视图的指定位置，该动作可以并行执行
视图可以进行有层次地重叠配置，某个视图中包含的其他视图称为子视图，该程序中，并不是直接在大的视图中绘图，而是在其他小的子视图中绘图，为此，代码清单19-9中定义了只在该文件内使用的类ClickableImageView该类继承了NSImageView 拥有显示图像的功能，而且可以获得鼠标点击事件，双击时则创建第17章中WInCtrl类实例，将图像显示为普通大小
在类DrawOperation的方法main中，从URL创建图像，将其设定为ClickableImageView的实例，并在指定位置配置子视图，如果图像尺寸太大，则缩小图片，使其不超过绘图范围，这里不在详细说明

代码清单19-8 DrawOperation的接口部分

#import <Cocoa/Cocoa.h>
@interface DrawOperation :NSOperation{
    NSURL *file ;//图像文件的URL
    __weak NSView *view;//没必要保存绘图用的视图
    NSPoint locationp;//绘图区域左下角
}
+(void)setPictureSize:(CGFloat)value;
-(id)initWithURL:(NSURL *)imgurl
      parentView:(NSView *)parent at :(NSPoint)loc;
-(void)main;

@end

代码清单19-9 DrawOperation的实现部分

#import <Cocoa/Cocoa.h>
#import "DrawOperation.h"
#import "WinCtrl.h"

@interface ClickableImageView : NSImageView //定义局部类
@property (retain)NSURL *url;
@end

@implementation ClickableImageView
@synthesize url;

-(void)mouseDown:(NSEvent *)theEvent{
    if([theEvent clickCount] >=2){
        //双击显示图像
        (void)[[WinCtrl alloc]initWithURL:url];
    }
}
@end //ClcikabelImageView的定义到此为止

static CGFloat pictureSize = 200.0;

@implementation DrawOperation //DrawOperation类主体的定义

+(void)setPictureSize:(CGFloat)value{
    pictureSize=value;
}
-(id)initWithURL:(NSURL *)imgurl parentView:(NSView *)parent at:(NSPoint)loc{
    if((self =[super init]) !=nil){
        file = imgurl;//保存url
        view =parent;//弱访问
        location =loc;
    }
    return self;
}
/*Local Methdo*/
//-(NSImage *)imageSized:(NSURL *)url{
//    /*省略 从URL中读取图像，如果图片大于pictureSize则创建缩小版图片*/
//}
-(void)main{
    NSImage *img;
    ClickableImageView *imgview;
    NSRect frame;
    NSSize sz;
    
    @try{
        @autoreleasepool {
            if(view ==nil || [self isCancelled])
                return ;//被取消时程序停止
       //     if((img = [self imageResized:file]) ==nil)
        //        return;
            sz=[img size];
            frame.size =sz;
            location.x +=(pictureSize -sz.width) /2.0;
            frame.origin =location;
            imgview =[[ClickableImageView alloc]initWithFrame:frame];
            [imgview setImage:img];//创建小视图来设定图像
            imgview.url =file;
            [view addSubview:imgview];//子视图
            [imgview setNeedsDisplay:YES];
        }
    }
    @catch(...){ }
}
@end

4.5其他改变

代码清单19-10 中展示了新的main函数，这里只是将第17章的程序中使用MyViewerCtrl类的部分置换为了BrowsingViewerCtrl类

代码清单19-10 新的main函数

#import <Cocoa/Cocoa.h>
#import "BrowsingViewerCtrl.h"

int main(int argc,const char *argv[]){
    @autoreleasepool {
        BrowsingViewerCtrl *cn = [BrowsingViewerCtrl sharedController];
        NSApplication *app =[NSApplication sharedApplication];
        [app setDelegate:cn];
        [app run];
    }
    return 0;
}

因为改变了应用名，所以Info.plist的应用识别名，束名、执行文件名都需要改变，此外，在描述菜单信息的Menu.plist文件中添加“打开目录”菜单项，然后，将新的源码进行编译并添加到链接文件，这样就可以执行了
￼
图19-8为执行示例，显示一览时，显示一次显示可以显示的图像，然后形成最终的一览界面，双击小图标显示的图像，即可将对象的图像显示为普通大小

    """},
];