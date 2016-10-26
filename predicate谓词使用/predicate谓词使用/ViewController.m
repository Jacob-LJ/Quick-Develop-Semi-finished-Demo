//
//  ViewController.m
//  predicate谓词使用
//
//  Created by Jacob_Liang on 16/10/20.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray<Car *> *garage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.garage = [NSMutableArray array];
    
    Car *car1 = [Car makeCarByName:@"RHerbie1" brandName:@"Honda1" enginName:@"CRX1" yearNum:1984 doorNum:2 distance:34000 power:58];
    [self.garage addObject:car1];
    
    
    Car *car2 = [Car makeCarByName:@"mHerbie2" brandName:@"Honda2" enginName:@"CRX2" yearNum:1984 doorNum:4 distance:44000 power:158];
    [self.garage addObject:car2];
    
    Car *car3 = [Car makeCarByName:@"BHerbie3" brandName:@"Honda3" enginName:@"CRX3" yearNum:1984 doorNum:6 distance:54000 power:258];
    [self.garage addObject:car3];
    
    Car *car4 = [Car makeCarByName:@"JHerbie4" brandName:@"Honda4" enginName:@"CRX4" yearNum:1984 doorNum:8 distance:64000 power:358];
    [self.garage addObject:car4];
    
    Car *car5 = [Car makeCarByName:@"AHerbie5" brandName:@"Honda5" enginName:@"CRX5" yearNum:1984 doorNum:10 distance:74000 power:458];
    [self.garage addObject:car5];
    
    /******************************************1 谓词使用 *******************************************/
    
    //1 创建谓词
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name == \"Herbie\""];
    /*
     name :是键路径
     == :运算符
     'Herbie' :字符串字面量
     注意: 
        1 如果谓词字符串中的这段文本 Herbie 没有打引号,就会被当做 键路径, 就如 name 那样;
        2 字符串字面量 可以使用单引号'' 也可以使用双引号"", 一般使用单引号,如果使用双引号则需要转义 如:
            [NSPredicate predicateWithFormat:@"name == \"Herbie\""];
     
     */
    //2 计算谓词
    //2.1
    BOOL match1 = [predicate1 evaluateWithObject:car1];
    NSLog(@"1//////%@",(match1)? @"YES":@"NO");
    /*
     原理: 方法 evaluateWithObject: 通知接收对象 car, 使用 name 作为键路径, 让它调用 valueForKeyPath: 方法获取自己属性 name 的值 再与字符串字面量 @"Herbie"作比较
     */
    
    //2.2 使用到了 keyPath !!!!!
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"engine.horsepower > 250"];
    BOOL match2 = [predicate2 evaluateWithObject:car2];
    NSLog(@"2//////%@",(match2)? @"YES":@"NO");
    
    //2.3 数组过滤
    NSArray *cars = [NSArray arrayWithArray:self.garage];
    NSArray *result = [cars filteredArrayUsingPredicate:predicate2];
    NSLog(@"%@",result);
    
    //注意 通过键值编码提取对应键的值
    NSArray *names = [result valueForKey:@"name"];
    NSArray *engineNames = [result valueForKeyPath:@"engine.name"];
    NSLog(@"%@",names);
    NSLog(@"%@",engineNames);
    
    //对于 mutableArray 来说, 使用 filterUsingPredicate 的话会只剩下符合条件的值
    NSMutableArray *copyGarage = [self.garage mutableCopy];
    [copyGarage filterUsingPredicate:predicate2];
    NSLog(@"%@",copyGarage); //只剩 car345了
    
    //对于 mutableArray 来说, 使用 filteredArrayUsingPredicate 的话会返回一个符合结果的 不可变数组
    NSMutableArray *copyGarage2 = [self.garage mutableCopy];
    NSArray *garage = [copyGarage2 filteredArrayUsingPredicate:predicate2];
    NSLog(@"%@",garage); // car345 的NSArray
    
    // NSSet 同样具有上述相似方法
    
    /*************************************************************************************/
    
    /******************************************2 谓词格式化 *******************************************/
    //1
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"engine.horsepower > %d",250];
    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"name == %@",@"Herbie3"];
    //注意, %@ 会当做一个有引号的字符串
    // predicate4 的格式字符串中的 %@ 并没有打 单引号. 如果 @"name == ''%@", 字符串 % 和 @ 就会被当做谓词字符串中的普通字符, 失去格式说明符的作用
    BOOL match3 = [predicate4 evaluateWithObject:car3];
    NSLog(@"3//////%@",(match3)? @"YES":@"NO");
    
    //2 使用 %K 来指定键路径
    NSPredicate *predicate5 = [NSPredicate predicateWithFormat:@"%K == %@",@"name",@"Herbie4"];
    BOOL match4 = [predicate5 evaluateWithObject:car4];
    NSLog(@"4//////%@",(match4)? @"YES":@"NO");//yes
    
    //3 将变量名放入字符串中,类似于环境变量
    NSPredicate *temPredicate6 = [NSPredicate predicateWithFormat:@"name == $NAME"];
    //temPredicate6被称为 含有变量的谓词,待定,需要继续确定值
    NSDictionary *varDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Herbie3",@"NAME", nil];
    NSPredicate *predicate6 = [temPredicate6 predicateWithSubstitutionVariables:varDict];
    BOOL match5 = [predicate6 evaluateWithObject:car3];
    NSLog(@"5//////%@",(match5)? @"YES":@"NO");//yes
    
        //还可以
    NSPredicate *temPredicate7 = [NSPredicate predicateWithFormat:@"engine.horsepower > $POWER"];
    NSDictionary *varDict2 = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:250],@"POWER", nil];
    NSPredicate *predicate7 = [temPredicate7 predicateWithSubstitutionVariables:varDict2];
    BOOL match6 = [predicate7 evaluateWithObject:car3];
    NSLog(@"6//////%@",(match6)? @"YES":@"NO"); //yes
    
    /*
     注意
     1 除了可以使用 NSNumber 和 NSString 之外, 同样可以使用 [NSNull null]来设置 nil 值
     2 甚至可以使用 数组
     */
    
    
    /*************************************************************************************/
    
    /******************************************3 运算符 *******************************************/
    
    /*
         >
         >= 和 =>
         <
         <= 和 =<
         != 和 <>
     */
    //谓词字符串语法支持 括号表达式
    // AND / OR / NOT 逻辑运算符 以及 C语言样式表示具有相同功能的 "&&" / "||" / "!" 符号
    
    NSPredicate *predicate8 = [NSPredicate predicateWithFormat:@"(engine.horsepower > 50) AND (engine.horsepower < 200)"];
    NSArray *result2 = [self.garage filteredArrayUsingPredicate:predicate8];
    NSLog(@"%@",result2); //car12
    
    //注意 谓词字符串不区分大小写 你可以 AnD, ANd, 和 AND
    
    //不等号 "!", 即适用于数字值又适用于字符串值,如果像按字母表顺序从头查看所有汽车,可以
    NSPredicate *predicate9 = [NSPredicate predicateWithFormat:@"name < 'Newton'"];
    NSArray *result3 = [self.garage filteredArrayUsingPredicate:predicate9];
    NSLog(@"%@",[result3 valueForKey:@"name"]);//BHerbie3, JHerbie4, AHerbie5
        //只是通过首字母对比,并未实际排序
    
    /*************************************************************************************/
    
    
    /***************** 4 数组运算符 BETWEEN / IN 的使用 *******************************************/
    
    /*
     BETWEEN
     
     1 一般 (engine.horsepower > 50) OR (engine.horsepower < 200) 这样的筛选条件表达式较为常见
        可使用 关键字 'BETWEEN' 来表达 介于两个数值之间的值 的意思 :
     */
    NSPredicate *predicate_between = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN {58,448}"]; // "{ }"表示数组 BETWEEN将数组第一个元素看做数组下限,第二个元素看做数组上限
    NSArray *result_between = [self.garage filteredArrayUsingPredicate:predicate_between];
    NSLog(@"%@",[result_between valueForKey:@"name"]);//RHerbie1, mHerbie2, BHerbie3, JHerbie4
    
    //注意, 表示数组上下限值并不包括在内,即 "BETWEEN {58,448}" => "(x > 58) OR (x < 448)"
    
    //2.1 使用 %@ 格式说明符,动态表示限制数组
    NSArray *betweenArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:58], [NSNumber numberWithInt:448], nil];
    NSPredicate *predicate_between_array = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN %@",betweenArray];
    NSArray *resulut_between_array = [self.garage filteredArrayUsingPredicate:predicate_between_array];
    NSLog(@"%@",[resulut_between_array valueForKey:@"name"]);//RHerbie1, mHerbie2, BHerbie3, JHerbie4
    
    //2.2 使用变量 动态表示限制数组
    NSPredicate *predicate_Var = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN $POWERS"];
    NSDictionary *VarDict = [NSDictionary dictionaryWithObjectsAndKeys:betweenArray,@"POWERS", nil];
    predicate_Var = [predicate_Var predicateWithSubstitutionVariables:VarDict];
    NSArray *relult_between_VarDict = [self.garage filteredArrayUsingPredicate:predicate_Var];
    NSLog(@"%@",[relult_between_VarDict valueForKey:@"name"]);//RHerbie1, mHerbie2, BHerbie3, JHerbie4
    
    // IN
    NSPredicate *predicate_IN = [NSPredicate predicateWithFormat:@"name IN {'mHerbie2', 'BHerbie3', 'JHerbie4'}"];
    NSArray *result_IN = [self.garage filteredArrayUsingPredicate:predicate_IN];
    NSLog(@"%@",[result_IN valueForKey:@"name"]);//mHerbie2, BHerbie3, JHerbie4
    
    /*************************************************************************************/
    
    
    /********************************5 SELF 的使用 ******************************************/
    /*
     前面的 format predict 在运算符( >, <,!= 等 ),关键词(IN BETWEEN 等)前面使用的都是 key 值名称, 如
        1 NSPredicate *predicate_between_array = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN %@",betweenArray]; 内使用的 engine.horsepower 指car对象内的engine属性的horsepower属性的值
        2 NSPredicate *predicate_IN = [NSPredicate predicateWithFormat:@"name IN {'mHerbie2', 'BHerbie3', 'JHerbie4'}"]; 内使用的 name 指 car对象内的name属性的值
     都是获取对象属性的值然后进行对比操作;
     
     但是,有时候需要对比操作的并不是一个类似 car 这样对象呢? 而是一个字符串这样简单的值呢? 此时在 format predicate 中又用什么来指代该值?
     例如问题: 筛选在字符串数组1 @[@"jam", @"Jack", @"jacob",@"kim"] 中的存在 同时存在于 字符串数组2 @[@"mHerbie2", @"BHerbie@", @"JHerbie4", @"Jack", @"kim"] 的元素 (简单来说就是求两个数组的交集)
     
     此时就需要使用 SELF 来指代被操作的值
     
     */
    
    NSArray *names1 = @[@"jam", @"Jack", @"jacob",@"kim"];
    NSArray *names2 = @[@"mHerbie2", @"BHerbie@", @"JHerbie4", @"Jack", @"kim"];
    NSPredicate *predicate_SELF = [NSPredicate predicateWithFormat:@"SELF IN %@",names2];
    NSArray *result_SELF = [names1 filteredArrayUsingPredicate:predicate_SELF];
    NSLog(@"%@",result_SELF); //Jack, kim
    
    /*************************************************************************************/
    
    
    /******************************** 6 针对 字符串 使用的运算符 **************************************/
    
    /*
     BEGINSWITH 检查某字符串是否以另一个字符串开头
     ENDSWITH   检查某字符串是否以另一个字符串结尾
     CONTAINS   检查某字符是否在另一个字符串的内部
     
     注意, 单单使用上述 字符串运算符是严格区分大小写及是否有重音符的
     
     像区分不区分大小写及重音符等则需要添加额外修饰符
     [c]    不区分大小写 (case insensitive)
     [d]    不区分发音符号 (diacritic insensitive 即忽略重音符)
     [cd]   既不区分大小写,也不区分发音符号
     
     Herbie 与 "name BEGINSWITH[cd] 'HERB'" 相匹配
     
     */
    
    /*************************************************************************************/
    
    /******************************** 7 LIKE 运算符 即通配运算符 **************************************/
    /*
     谓词运算符 "name LIKE '*er*'" 将会与任何含有 er 的名称相匹配, 等效于 CONTAINS
     谓词运算符 "name LIKE '???er*'" 将会与 Paper Car相匹配,因为其中的 er 前面有3个字符,而 er后面有一些字符. 但它与 Badger 不匹配,因为 Badger 的 er 前面有4个字符.
     另外 LIKE 也接受 [cd]等修饰符 用于忽略大小写和发音符 的区分
     */
    /*************************************************************************************/
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
