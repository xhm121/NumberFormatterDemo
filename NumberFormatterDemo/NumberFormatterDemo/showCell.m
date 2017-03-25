//
//  showCell.m
//  NumberFormatterDemo
//
//  Created by 121 on 2017/3/25.
//  Copyright © 2017年 121. All rights reserved.
//

#import "showCell.h"

@interface showCell ()
@property (weak, nonatomic) IBOutlet UILabel *showStyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *originValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeFormaterLabel;
@property (weak, nonatomic) IBOutlet UILabel *changetitleLabel;

@end

@implementation showCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 30;
    self.originValueLabel.preferredMaxLayoutWidth = width;
}

- (void)setCell:(NSString *)showStyle  originValue :(NSString *)originValue  formaterTitle :(NSString *)formaterTitle   changeFormater:(NSString *)changeFormater {
    self.showStyleLabel.text = showStyle;
    self.originValueLabel.text = originValue;
    self.changetitleLabel.text = formaterTitle;
    self.changeFormaterLabel.text = changeFormater;
    
}

@end
