//
//  YFFailView.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFFailView.h"

#import "StaffHelper.h"

@interface YFFailView ()

@property(nonatomic,copy)void(^loadBlock)();

@end

@implementation YFFailView
{
    UIImageView *_failImg;
    UIButton *_refreshButton;
}
- (instancetype)initWithFrame:(CGRect)frame LoadBlock:(void(^)())loadBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loadBlock = loadBlock;
                
        UIImageView *failImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(80), MSW/3, MSW/3)];
        _failImg = failImg;
        failImg.image = [UIImage imageNamed:@"fail"];
        
        [self addSubview:failImg];
        
        UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(40), failImg.bottom+Height320(30), Width320(80), Height320(30))];
        _refreshButton = refreshButton;
        refreshButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        refreshButton.layer.borderColor = kMainColor.CGColor;
        
        refreshButton.layer.borderWidth = 1;
        
        refreshButton.layer.cornerRadius = 4;
        
        [refreshButton setTitle:@"重试" forState:UIControlStateNormal];
        
        [refreshButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        refreshButton.titleLabel.font = AllFont(14);
        
        [refreshButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:refreshButton];
        
        self.backgroundColor = YFMainBackColor;
    }
    return self;
}


-(void)removeSelfFromView
{
    [self removeFromSuperview];
}

- (void)refresh
{
    if (self.loadBlock)
    {
        self.loadBlock();
    }
    [self removeFromSuperview];
}

@end
