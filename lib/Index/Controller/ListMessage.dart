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
];