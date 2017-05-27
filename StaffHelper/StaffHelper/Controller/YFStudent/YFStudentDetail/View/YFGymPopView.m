//
//  YFGymPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGymPopView.h"

#import "YFStuDetailGymPopVC.h"

@interface YFGymPopView ()

@property(nonatomic, strong)YFStuDetailGymPopVC *gymPopVC;

@end

@implementation YFGymPopView

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame
{
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame ];
    if (self)
    {
        self.gymPopVC = [[YFStuDetailGymPopVC alloc] init];
        
        
        self.gymPopVC.view.frame = CGRectMake(5, 9, self.originFrame.size.width - 10, self.originFrame.size.height - 14);
        self.gymPopVC.refreshScrollView.frame = self.gymPopVC.view.bounds;
        
//        self.childredView.layer.borderColor = YFGrayViewColor.CGColor;
//        self.childredView.layer.borderWidth = OnePX;
//        self.childredView.layer.shadowColor = YFGrayViewColor.CGColor;
//        self.childredView.layer.shadowOffset = CGSizeMake(2, 10);
//        self.childredView.layer.shadowOpacity = 0.7;
        weakTypesYF
        [self.gymPopVC setSelectBlock:^{
            if (weakS.selectBlock)
            {
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        [self.childredView addSubview:self.gymPopVC.view];
        
        self.isValidParam = YES;
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        
        self.childredView.clipsToBounds = YES;
        
        self.gymPopVC.view.clipsToBounds = YES;
        
        self.childredView.backgroundColor = [UIColor clearColor];
        
        self.gymPopVC.view.backgroundColor = [UIColor clearColor];
        
        self.gymPopVC.refreshScrollView.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *shadowIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height)];
        
        [shadowIamgeView setImage:[UIImage imageNamed:@"shadowPopView"]];
        
        [self.childredView addSubview:shadowIamgeView];
        [self.childredView sendSubviewToBack:shadowIamgeView];
    }
    return self;

}

-(NSString *)value
{
    return self.gymPopVC.title;
}


-(void)setTitle:(NSString *)title
{
    self.gymPopVC.title = title;
    [super setTitle:title];
}

- (void)setGymArray:(NSMutableArray *)gymArray
{
    self.gymPopVC.gym = self.gym;
    if (_gymArray.count > 0) {
        return;
    }
    _gymArray = gymArray;
    
    [self.gymPopVC resultGyms:gymArray];
}

- (NSDictionary *)param
{
// 当前可以不传
    if (self.gymPopVC.selelcModel.isAll) {
        return @{@"shop_ids":@"0"};
    }else if (self.gymPopVC.selelcModel.gym.shopId > 0)
    {
        return @{@"shop_ids":[NSString stringWithFormat:@"%@",@(self.gymPopVC.selelcModel.gym.shopId)]};
    }
    // 默认不传 shop_ids, 接口处理为 当前场馆
    return @{};;
}

- (void)initChildrenViewWithFrame:(CGRect)frame
{
    self.originFrame = frame;
    
    self.hiddenFrame = CGRectMake(frame.origin.x, - frame.size.height, frame.size.width,frame.size.height);
    
    self.childredView = [[UIView alloc] initWithFrame:self.hiddenFrame];
    
    self.childredView .backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.childredView ];
}

@end
