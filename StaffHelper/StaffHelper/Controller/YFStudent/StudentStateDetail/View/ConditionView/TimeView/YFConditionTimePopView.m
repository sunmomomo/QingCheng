//
//  YFConditionTimePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFConditionTimePopView.h"

#import "YFStudentChooseTimeVC.h"

@interface YFConditionTimePopView ()

@property(nonatomic, strong)YFStudentChooseTimeVC *timeVC;

@end

@implementation YFConditionTimePopView


-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        self.timeVC = [[YFStudentChooseTimeVC alloc] init];
        
        weakTypesYF
        [self.timeVC setSelectBlock:^{
            if (weakS.selectBlock)
            {
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        
        [self.childredView addSubview:self.timeVC.view];
        
        self.timeVC.view.frame = self.bounds;
        self.timeVC.baseTableView.frame = self.bounds;
        self.isValidParam = YES;
    }
    return self;
}





-(NSDictionary *)param
{
    if (self.timeVC.startTimeModel.timeStr.length && self.timeVC.endTimeModel.timeStr.length)
    {
        return @{@"start":self.timeVC.startTimeModel.timeStr,@"end":self.timeVC.endTimeModel.timeStr};
    }
    return @{};
}

-(NSString *)value
{
    return @"";
}

-(void)setTitle:(NSString *)title
{
    self.timeVC.title = title;
    [super setTitle:title];
}

- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic
{
    NSString *start = patamDic[@"start"];
    
    NSString *end = patamDic[@"end"];
    
    self.timeVC.start = start;
    self.timeVC.end = start;
    
    self.timeVC.startTimeModel.timeStr = start;
    self.timeVC.endTimeModel.timeStr = end;
    
    [self.timeVC.baseTableView reloadData];
}


@end
