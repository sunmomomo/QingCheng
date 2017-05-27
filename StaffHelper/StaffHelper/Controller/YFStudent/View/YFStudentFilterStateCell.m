//
//  YFStudentFilterStateCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterStateCell.h"
#import "YFAppConfig.h"




@implementation YFStudentFilterStateCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *titleArray = @[@"新注册",@"已接洽",@"会员"];
        
        CGFloat buttonWidth = (MSW * StudentRightShowScale - (YFCellBeginGap + YFCellButtonsGap) *2) / 3.0;
        
        for (NSUInteger i = 0; i < 3; i ++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(YFCellBeginGap + (buttonWidth + YFCellButtonsGap) * i, self.meStateDesLabel.bottom + 8, buttonWidth, XFrom6YF(30));
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:YFCellTitleColor forState:UIControlStateNormal];
        
            [button setTitleColor:YFSelectedButtonColor forState:UIControlStateSelected
             ];
            [button setBackgroundColor:YFCellButtonBaColor];
            button.layer.cornerRadius = 3.0f;
            button.clipsToBounds = YES;
            [button.titleLabel setFont:FontSizeFY(XFrom5YF(12.0))];
            [button setImage:[UIImage imageNamed:@"FillCond"] forState:UIControlStateSelected];

            if (i == 0)
            {
                self.nRegisterButton = button;
            }else if (i == 1){
                self.followIngButton = button;
            }else
            {
                self.memberButton = button;
            }
        }
        
        [self.contentView addSubview:self.meStateDesLabel];
        [self.contentView addSubview:self.nRegisterButton];
        [self.contentView addSubview:self.followIngButton];
        [self.contentView addSubview:self.memberButton];


    }
    return self;
}


-(UILabel *)meStateDesLabel
{
    if (!_meStateDesLabel)
    {
        _meStateDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(YFCellBeginGap, XFrom6YF(45.0), 80, XFrom6YF(15.0))];
        _meStateDesLabel.font = FontSizeFY(XFrom6YF(15.0));
        _meStateDesLabel.textColor = YFCellTitleColor;
        _meStateDesLabel.text = @"会员状态";
    }
    return _meStateDesLabel;
}

@end
