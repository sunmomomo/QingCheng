//
//  YFOutRankDaysPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFOutRankDaysPopView.h"

#import "YFOutRankDaysVC.h"

@interface YFOutRankDaysPopView ()

@property(nonatomic, strong)YFOutRankDaysVC *timeVC;

@end

@implementation YFOutRankDaysPopView


-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    CGRect  chridFrame = CGRectMake(0, 0, superView.width, 46 * 4);
    
    self = [super initWithFrame:frame superView:superView childrenFrame:chridFrame ];
    if (self)
    {
        self.isToGreenTitle = NO;
        self.timeVC = [[YFOutRankDaysVC alloc] init];
        
        
        self.timeVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height);
        self.timeVC.refreshScrollView.frame = self.timeVC.view.bounds;
        
        
        weakTypesYF
        [self.timeVC setSelectBlock:^(id m){
            if (weakS.selectBlock)
            {
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        [self.childredView addSubview:self.timeVC.view];
        
        self.isValidParam = YES;
        self.backgroundColor = RGBA_YF(0, 0, 0, 0.5);
        
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        
        self.childredView.clipsToBounds = YES;
        
        self.timeVC.view.clipsToBounds = YES;
        
        self.childredView.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}



//-(void)hide
//{
//    [self hideAnimate:NO];
//}
//-(void)show
//{
//    [self showAnimate:NO];
//}




-(NSDictionary *)param
{
    if (self.timeVC.param)
    {
        return self.timeVC.param;
    }
    return @{@"order_by":@"group"};
}

-(NSString *)value
{
    return self.timeVC.title;
}

-(void)setTitle:(NSString *)title
{
    self.timeVC.title = title;
    [super setTitle:title];
}


@end
