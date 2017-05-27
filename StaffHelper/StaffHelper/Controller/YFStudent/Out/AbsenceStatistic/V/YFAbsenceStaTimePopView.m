//
//  YFAbsenceStaTimePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAbsenceStaTimePopView.h"

#import "YFAbsenceStaTimeVC.h"

@interface YFAbsenceStaTimePopView ()

@property(nonatomic, strong)YFAbsenceStaTimeVC *timeVC;

@end


@implementation YFAbsenceStaTimePopView



-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    CGRect  chridFrame = CGRectMake(0, 0, superView.width, 46 * 4);
    
    self = [super initWithFrame:frame superView:superView childrenFrame:chridFrame ];
    if (self)
    {
        self.isValidParam = YES;
        self.timeVC = [[YFAbsenceStaTimeVC alloc] init];
        
        self.timeVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height);
        self.timeVC.refreshScrollView.frame = self.timeVC.view.bounds;
        
        
        weakTypesYF
        [self.timeVC setSelectBlock:^(id model){
            if (weakS.selectBlock)
            {
//                if ([weakS.originVC.filterTimeModel.name isEqualToString:@"全部"]) {
//                    weakS.isValidParam = NO;
//                }else
//                {
//                    weakS.isValidParam = YES;
//                }
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        
        [self.childredView addSubview:self.timeVC.view];
        
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);

        self.childredView.clipsToBounds = YES;
        
        self.timeVC.view.clipsToBounds = YES;
     
        self.childredView.backgroundColor = [UIColor clearColor];
    }
    return self;
}



-(NSDictionary *)param
{
   
    return self.timeVC.param;
}



-(NSString *)value
{
        if (self.timeVC.selectTitle)
        {
            return self.timeVC.selectTitle;
        }
    
    
    return @"";
}

- (void)afterSetAllConditionsParam:(NSDictionary *)patamDic
{
    
}
@end
