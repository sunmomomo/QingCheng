//
//  YFAddNewGymCVCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/4.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAddNewGymCVCell.h"

#import "GuideSetGymController.h"
#import "YFAppConfig.h"

@interface YFAddNewGymCVCell()

{
    
    UILabel *_noGymLabel;
    
    UIView *_line;
    
    UIButton *_addButton;
    
}

@end

@implementation YFAddNewGymCVCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _noGymLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(34))];
        
        _noGymLabel.backgroundColor = UIColorFromRGB(0xffffff);
        
        _noGymLabel.text = @"该品牌下暂无场馆";
        
        _noGymLabel.textColor = UIColorFromRGB(0x999999);
        
        _noGymLabel.textAlignment = NSTextAlignmentCenter;
        
        _noGymLabel.font = AllFont(12);
        
        [self addSubview:_noGymLabel];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, _noGymLabel.height-OnePX, MSW, OnePX)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_line];
        
        _noGymLabel.hidden = YES;
        
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, frame.size.height-_noGymLabel.bottom)];
        
        _addButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(117), _addButton.height/2-Height320(8), Width320(16), Height320(16))];
        
        addImg.image = [UIImage imageNamed:@"card_recharge"];
        
        [_addButton addSubview:addImg];
        
        UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(6), 0, Width320(150), _addButton.height)];
        
        addLabel.text = @"新增场馆";
        
        addLabel.textColor = kMainColor;
        
        addLabel.font = AllFont(14);
        
        [_addButton addSubview:addLabel];
        
        [_addButton addTarget:self action:@selector(addGym) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_addButton];
        
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, MSW, OnePX)];
        
        bottomLine.backgroundColor = YFLineViewColor;
        
        [self addSubview:bottomLine];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)addGym
{
    
    if (!self.brand || !self.weakVC)
    {
        return;
    }
    
    if (!self.brand.havePower) {
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"仅品牌创建人%@可新增场馆",self.brand.owner.name.length?self.brand.owner.name:@""] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        return;
    }
    
    GuideSetGymController *svc = [[GuideSetGymController alloc]init];
    
    Course *course = [[Course alloc]initNewCourse];
    
    course.gym.brand = self.brand;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).course = course;
    
    [self.weakVC.navigationController pushViewController:svc animated:YES];
}

-(void)setNoGym:(BOOL)noGym
{
    
    _noGym = noGym;
    
    [_addButton changeTop:_noGym?Height320(34):0];
    
    _noGymLabel.hidden = !_noGym;
    
    _line.hidden = !_noGym;
    
}

@end
