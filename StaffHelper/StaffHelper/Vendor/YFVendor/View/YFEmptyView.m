//
//  YFEmptyView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFEmptyView.h"

@implementation YFEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
        
        _emptyImg = emptyImg;
        
        emptyImg.image = [UIImage imageNamed:@"stuempty"];
        
        [self addSubview:emptyImg];
        
        UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, emptyImg.bottom+Height320(19.5), MSW-40, Height320(39))];
        
        emptyLabel.numberOfLines = 0;
        
        emptyLabel.textColor = UIColorFromRGB(0x747474);
        
        emptyLabel.font = AllFont(14);
        
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:emptyLabel];
        
        _emptyLabel = emptyLabel;
        
        UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        addbutton.frame = CGRectMake(Width320(75.5), emptyLabel.bottom+Height320(19.5), MSW-Width320(151), Height320(42.7));
        
        addbutton.backgroundColor = kMainColor;
        
        [addbutton setTitle:@"添加会员" forState:UIControlStateNormal];
        
        addbutton.layer.cornerRadius = 2.0;
        
        addbutton.layer.masksToBounds = YES;
        
        [addbutton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        addbutton.titleLabel.font = AllFont(17);
        
        addbutton.tag = 201;
        
        
        [self addSubview:addbutton];
        
        _addbutton = addbutton;
        
       
    }
    return self;
}
@end
