//
//  YFConditionLatestTimePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFConditionLatestTimePopView.h"
#import "YFStudentChooseLatestTimeVC.h"

@interface YFConditionLatestTimePopView ()

@property(nonatomic, strong)YFStudentChooseLatestTimeVC *timeVC;

@end

@implementation YFConditionLatestTimePopView



-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        self.timeVC = [[YFStudentChooseLatestTimeVC alloc] init];
        
        weakTypesYF
        [self.timeVC setSelectBlock:^{
            if (weakS.selectBlock)
            {
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        [self.childredView addSubview:self.timeVC.view];
        
        self.timeVC.view.frame = CGRectMake(0, 0, self.frame.size.width, 93);
        self.timeVC.baseTableView.frame = CGRectMake(0, 0, self.frame.size.width, 93);
        self.isValidParam = YES;
        self.backgroundColor = RGBA_YF(0, 0, 0, 0.5);
        self.childredView.backgroundColor = [UIColor clearColor];
        
        UIView *tapHideView = [[UIView alloc] initWithFrame:CGRectMake(0, 93.0, self.width, self.height - 93.0)];
        tapHideView.backgroundColor = [UIColor clearColor];
        [self addSubview:tapHideView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideControlAction:)];
        
        [tapHideView addGestureRecognizer:tapGes];

    }
    return self;
}



-(void)hide
{
    [self hideAnimate:NO];
}
-(void)show
{
    [self showAnimate:NO];
}




-(NSDictionary *)param
{
    if (self.timeVC.param)
    {
        return self.timeVC.param;
    }
    return @{};
}

-(NSString *)value
{
    return self.timeVC.selectModel.valueStr;;
}

-(void)setTitle:(NSString *)title
{
    self.timeVC.title = title;
    [super setTitle:title];
}



@end
