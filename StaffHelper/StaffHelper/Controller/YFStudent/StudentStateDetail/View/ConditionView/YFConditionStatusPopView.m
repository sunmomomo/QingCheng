//
//  YFConditionStatusPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFConditionStatusPopView.h"

#import "YFStudnetChooseStatusVC.h"

@interface YFConditionStatusPopView()

@property(nonatomic, strong)YFStudnetChooseStatusVC *chooseStatusVC;

@end

@implementation YFConditionStatusPopView


- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    CGRect  childrenFrame = CGRectMake(0, 0, superView.width, XFrom5To6YF(40) * 4);
    
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame sufient:NO];
    
    if (self)
    {
        self.chooseStatusVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, childrenFrame.size.height);
        
        self.chooseStatusVC.refreshScrollView.frame = CGRectMake(0, 0, MSW , self.chooseStatusVC.view.height);
        
        self.chirdrenHeight = childrenFrame.size.height;
        
        [self.childredView addSubview:self.chooseStatusVC.view];
        
        self.childredView.clipsToBounds = YES;
        self.chooseStatusVC.view.clipsToBounds = YES;
        
        self.childredView.backgroundColor = [UIColor clearColor];
        
        self.chirderViewSuperView.backgroundColor =  [UIColor clearColor];
    }
    return self;
}


-(YFStudnetChooseStatusVC *)chooseStatusVC
{
    if (!_chooseStatusVC) {
        _chooseStatusVC = [[YFStudnetChooseStatusVC alloc] init];
        self.popSubVC = _chooseStatusVC;
        
        weakTypesYF
        [_chooseStatusVC setSureBlock:^{
            if (weakS.selectBlock) {
                weakS.param = weakS.chooseStatusVC.selectModel.paramOfStatus;
                DebugLogParamYF(@"-----param:%@",weakS.param);
                weakS.value = weakS.chooseStatusVC.selectModel.name;
                DebugLogParamYF(@"-----value:%@",weakS.value);

                weakS.selectBlock(@"",weakS.chooseStatusVC.selectModel.paramOfStatus);
            }
        }];
    }
    return _chooseStatusVC;
}

- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic
{
    NSString *status = patamDic[@"status_ids"];
    
    status = [status stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    [self.chooseStatusVC setSelectStatus:status];
    
    self.param = self.chooseStatusVC.selectModel.paramOfStatus;

    self.value = self.chooseStatusVC.selectModel.name;

    
}


@end
