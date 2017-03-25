//
//  ViewController.m
//  NumberFormatterDemo
//
//  Created by 121 on 2017/3/25.
//  Copyright © 2017年 121. All rights reserved.
//

#import "ViewController.h"
#import "showCell.h"
@interface ViewController () {
    NSNumber *_number;
}


@property (nonatomic, strong) NSArray *numberStyleArray;
@property (nonatomic, strong) NSArray *formattersArray;

@property (nonatomic, strong) NSMutableArray *changeFormattersArray;

@end



@implementation ViewController

- (NSArray *)numberStyleArray {
    if(!_numberStyleArray) {
        _numberStyleArray = @[@"No", @"Decimal", @"Currency", @"Percent", @"Scientific", @"SpellOut",@"Decimal",@"Decimal",@"Decimal",@"Decimal"];
    }
    return _numberStyleArray;
}


- (NSArray *)formattersArray {
    if (!_formattersArray) {
        NSNumberFormatter *noStyleFormatter = [[NSNumberFormatter alloc] init];
        NSNumberFormatter *decimalFormatter = [[NSNumberFormatter alloc] init];
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        NSNumberFormatter *percentFormatter = [[NSNumberFormatter alloc] init];
        NSNumberFormatter *scientificFormatter = [[NSNumberFormatter alloc] init];
        NSNumberFormatter *spellOutFormatter = [[NSNumberFormatter alloc] init];
        
        NSNumberFormatter *noStyleFormatter2 = [[NSNumberFormatter alloc] init];
        
        NSNumberFormatter *noStyleFormatter3 = [[NSNumberFormatter alloc] init];
        
        NSNumberFormatter *noStyleFormatter4 = [[NSNumberFormatter alloc] init];
        
        NSNumberFormatter *noStyleFormatter5 = [[NSNumberFormatter alloc] init];
        
        
        
        //设置样式
        noStyleFormatter.numberStyle = kCFNumberFormatterNoStyle;
        decimalFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        percentFormatter.numberStyle = NSNumberFormatterPercentStyle;
        scientificFormatter.numberStyle = NSNumberFormatterScientificStyle;
        spellOutFormatter.numberStyle = NSNumberFormatterSpellOutStyle;
        
        noStyleFormatter2.numberStyle = NSNumberFormatterDecimalStyle;
        noStyleFormatter3.numberStyle = NSNumberFormatterDecimalStyle;
        noStyleFormatter4.numberStyle = NSNumberFormatterDecimalStyle;
        noStyleFormatter5.numberStyle = NSNumberFormatterDecimalStyle;
        
        
        
          _formattersArray   = @[noStyleFormatter,
                             decimalFormatter,
                             currencyFormatter,
                             percentFormatter,
                             scientificFormatter,
                             spellOutFormatter,
                             noStyleFormatter2,
                             noStyleFormatter3,
                             noStyleFormatter4,
                             noStyleFormatter5];
        
    }
    return _formattersArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _number = @(-12345.709123);
    self.changeFormattersArray = [[NSMutableArray alloc] initWithArray:self.formattersArray copyItems:YES];
    UINib *nib = [UINib nibWithNibName:@"showCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"121"];
    self.tableView.rowHeight = 110;
    self.tableView.tableFooterView = [UIView new];
    
}


#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.numberStyleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSInteger row = indexPath.row;
       showCell *cell = [tableView dequeueReusableCellWithIdentifier:@"121"];
    //获取样式
    NSString *showStyle = [NSString stringWithFormat:@"NSNumberFormatter%@Style",self.numberStyleArray[indexPath.row]];
    
    NSNumberFormatter *formatter = self.formattersArray[row];
    NSNumberFormatter *changeFormatter = self.changeFormattersArray[row];
    
    
    
    NSString *originStrig = [formatter stringFromNumber:_number];
    NSString *formaterTitle;
    NSString *changeString;
    //根据不同的cell,设置样式
    if (row == 0) {
        //小数位最少保留10位小数
        formaterTitle = @"小数位最少保留10位小数";
        changeFormatter.minimumFractionDigits = 10;
         changeString = [changeFormatter stringFromNumber:_number];
    }else if (row == 1) {
       //如果是负数的时候的前缀 用这个字符串代替默认的"-"号
        formaterTitle = @"负数时更改- 前缀";
        changeFormatter.negativePrefix = @"负数";
        changeString = [changeFormatter stringFromNumber:_number];
    }else if (row == 2) {
    //接收的货币分组分隔符 只有currencyFormatter下才有用(默认是,改成//)
        formaterTitle = @"更改货币分组分隔符";
        changeFormatter.currencyGroupingSeparator = @"//";
        changeString = [changeFormatter stringFromNumber:_number];
    }else if (row == 3) {
       //将12.3生成12.3%
        formaterTitle = @"将12.3变成成12.3%并更改百分比符号";
        //缩放因子,你可以将一个数缩放指定比例,然后给其添加后缀
        changeFormatter.multiplier = @1.0f;
        //接收器用来表示百分比符号的字符串。(默认是%,改成%%)
        changeFormatter.percentSymbol = @"百分之";
        //最少保留2位小数点
        changeFormatter.minimumFractionDigits = 2;
        changeString = [changeFormatter stringFromNumber:@(12.3)];
    }else if (row == 4) {
        //接收器用来表示指数符号的字符串 (默认是E)。
        formaterTitle = @"改变指数符号E的样式";
        changeFormatter.exponentSymbol = @"ee";
       changeString = [changeFormatter stringFromNumber:_number];
    }else if (row == 5) {
        //将数值0改成零
        formaterTitle = @"更改数值0的样式";
         changeFormatter.zeroSymbol = @"零";
       changeString = [changeFormatter stringFromNumber:@(0)];
    }else if (row == 6) {
        //更改小数点样式
       formaterTitle = @"更改小数点样式";
      changeFormatter.decimalSeparator = @"。";
       changeString = [changeFormatter stringFromNumber:_number];
    }else if (row == 7) {
       formaterTitle = @"更改数字分割";
       //数字分割的尺寸 就比如数字越多1234 为了方便就分割开 1,234(这个分割的大小是3) 从后往前数
           changeFormatter.groupingSize = 2;
        //一些区域允许较大的数字的另一个分组大小的规范。例如，有些地方可能代表一个数字如61，242，378.46（在美国）作为6,12, 42378.46。在这种情况下，二次分组大小（覆盖小数点最远的数字组）为2
        //小数点前的(大于零的部分)，先从右往左分割groupSize的，如果剩余的在按照secondaryGroupingSize的大小来分
        changeFormatter.secondaryGroupingSize = 1;
        changeString = [changeFormatter stringFromNumber:_number];
    }else if (row == 8) {
        formaterTitle = @"更改数字宽度";
        // 格式宽度 出来的数据占位是15个 例如是 123,45.6 格式宽度就是 8
        changeFormatter.formatWidth = 15;
        //填充符 有时候格式宽度够宽，不够就用填充符*填充
            changeFormatter.paddingCharacter = @"*";
        //填充符的位置
        changeFormatter.paddingPosition = kCFNumberFormatterPadAfterSuffix;
        changeString = [changeFormatter stringFromNumber:_number];
    }else if ( row == 9) {
        formaterTitle = @"更改数字舍入方式";
        // 舍入方式
        changeFormatter.roundingMode = NSNumberFormatterRoundHalfUp;
        // 舍入值 比如以1为进位值   123456.58 变为 123457
        changeFormatter.roundingIncrement = @1;
        changeString = [changeFormatter stringFromNumber:_number];
    }
    [cell setCell:showStyle originValue:originStrig formaterTitle:formaterTitle changeFormater:changeString];
    if (row %2 == 0) {
        cell.backgroundColor = [UIColor greenColor];
    }else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
    
}


@end
