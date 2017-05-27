//
//  ChestBorrowDetailView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestBorrowDetailView.h"

@interface ChestBorrowDetailView ()

{
    
    UIView *_mainView;
    
}

@end

@implementation ChestBorrowDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [self addSubview:backView];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
    }
    return self;
}

+(instancetype)defaultView
{
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
}

-(void)show
{
    
    self.hidden = NO;
    
    [self.superview bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_mainView changeTop:_chest.longTermUse?Height320(170):Height320(219)];
        
    }];
    
}

-(void)setChest:(Chest *)chest
{
    
    _chest = chest;
    
    if (_chest.longTermUse) {
        
        [self loadLongView];
        
    }else{
        
        [self loadTempView];
        
    }
    
}

-(void)loadLongView
{
    
    self.hidden = YES;
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), MSH, MSW-Width320(40), Height320(288))];
    
    _mainView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _mainView.layer.cornerRadius = Width320(2);
    
    _mainView.layer.masksToBounds = YES;
    
    [self addSubview:_mainView];
    
    UILabel *chestNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(5), _mainView.width, Height320(27))];
    
    chestNameLabel.text = _chest.name;
    
    chestNameLabel.textColor = kMainColor;
    
    chestNameLabel.textAlignment = NSTextAlignmentCenter;
    
    chestNameLabel.font = AllFont(24);
    
    [_mainView addSubview:chestNameLabel];
    
    UILabel *areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, chestNameLabel.bottom, chestNameLabel.width, Height320(14))];
    
    areaLabel.text = _chest.area.areaName;
    
    areaLabel.textColor = kMainColor;
    
    areaLabel.textAlignment = NSTextAlignmentCenter;
    
    areaLabel.font = AllFont(12);
    
    [_mainView addSubview:areaLabel];
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(_mainView.width-Width320(30), Height320(7), Width320(25), Height320(25))];
    
    UIImageView *closeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(5), Height320(5), Width320(15), Height320(15))];
    
    closeImg.layer.masksToBounds = YES;
    
    closeImg.image = [UIImage imageNamed:@"chest_close"];
    
    [closeButton addSubview:closeImg];
    
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainView addSubview:closeButton];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(50), _mainView.width, Height320(1))];
    
    line.backgroundColor = kMainColor;
    
    [_mainView addSubview:line];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), line.bottom+Height320(20), Width320(64), Height320(16))];
    
    firstLabel.text = @"状 态";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = AllFont(14);
    
    [_mainView addSubview:firstLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), firstLabel.top, Width320(180), Height320(16))];
    
    stateLabel.text = @"长期租用";
    
    stateLabel.textColor = UIColorFromRGB(0xf9944e);
    
    stateLabel.font = AllFont(14);
    
    [_mainView addSubview:stateLabel];
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, firstLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    secondLabel.text = @"期 限";
    
    secondLabel.textColor = UIColorFromRGB(0x999999);
    
    secondLabel.font = AllFont(14);
    
    [_mainView addSubview:secondLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), secondLabel.top, Width320(180), Height320(16))];
    
    timeLabel.text = [NSString stringWithFormat:@"%@至%@",_chest.start,_chest.end];
    
    timeLabel.textColor = UIColorFromRGB(0x333333);
    
    timeLabel.font = AllFont(14);
    
    [_mainView addSubview:timeLabel];
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, secondLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    thirdLabel.text = @"会 员";
    
    thirdLabel.textColor = UIColorFromRGB(0x999999);
    
    thirdLabel.font = AllFont(14);
    
    [_mainView addSubview:thirdLabel];
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), thirdLabel.top, Width320(180), Height320(16))];
    
    userLabel.text = [NSString stringWithFormat:@"%@（%@）",_chest.borrowUser.name,_chest.borrowUser.phone];
    
    userLabel.textColor = UIColorFromRGB(0x333333);
    
    userLabel.font = AllFont(14);
    
    [_mainView addSubview:userLabel];
    
    UILabel *forthLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, thirdLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    forthLabel.text = @"剩余天数";
    
    forthLabel.textColor = UIColorFromRGB(0x999999);
    
    forthLabel.font = AllFont(14);
    
    [_mainView addSubview:forthLabel];
    
    UILabel *remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), forthLabel.top, Width320(180), Height320(16))];
    
    remainLabel.textColor = UIColorFromRGB(0x333333);
    
    NSString *remain = [NSString stringWithFormat:@"%ld 天",(long)_chest.remain];
    
    if (_chest.remain<=0) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:remain];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xEA6161) range:NSMakeRange(0, astr.length-2)];
        
        remainLabel.attributedText = astr;
        
    }else{
        
        remainLabel.text = remain;
        
    }
    
    remainLabel.font = AllFont(14);
    
    [_mainView addSubview:remainLabel];
    
    UIButton *returnButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), remainLabel.bottom+Height320(28), _mainView.width-Width320(24), Height320(36))];
    
    returnButton.backgroundColor = kMainColor;
    
    returnButton.layer.cornerRadius = Width320(2);
    
    [returnButton setTitle:@"归还更衣柜" forState:UIControlStateNormal];
    
    [returnButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    returnButton.titleLabel.font = AllFont(14);
    
    [_mainView addSubview:returnButton];
    
    [returnButton addTarget:self action:@selector(returnChest:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *continueButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), returnButton.bottom+Height320(10), returnButton.width, returnButton.height)];
    
    continueButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    continueButton.layer.cornerRadius = Width320(2);
    
    continueButton.layer.borderColor = kMainColor.CGColor;
    
    continueButton.layer.borderWidth = OnePX;
    
    [continueButton setTitle:@"续 租" forState:UIControlStateNormal];
    
    [continueButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    continueButton.titleLabel.font = AllFont(14);
    
    [_mainView addSubview:continueButton];
    
    [continueButton addTarget:self action:@selector(continueBorrow:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)returnChest:(UIButton*)button
{
    
    [self close];
    
    [self.delegate returnChest];
    
}

-(void)continueBorrow:(UIButton*)button
{
    
    [self close];
    
    [self.delegate continueBorrowChest];
    
}

-(void)loadTempView
{
    
    self.hidden = YES;
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), MSH, MSW-Width320(40), Height320(190))];
    
    _mainView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _mainView.layer.cornerRadius = Width320(2);
    
    _mainView.layer.masksToBounds = YES;
    
    [self addSubview:_mainView];
    
    UILabel *chestNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(5), _mainView.width, Height320(27))];
    
    chestNameLabel.text = _chest.name;
    
    chestNameLabel.textColor = kMainColor;
    
    chestNameLabel.textAlignment = NSTextAlignmentCenter;
    
    chestNameLabel.font = AllFont(24);
    
    [_mainView addSubview:chestNameLabel];
    
    UILabel *areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, chestNameLabel.bottom, chestNameLabel.width, Height320(14))];
    
    areaLabel.text = _chest.area.areaName;
    
    areaLabel.textColor = kMainColor;
    
    areaLabel.textAlignment = NSTextAlignmentCenter;
    
    areaLabel.font = AllFont(12);
    
    [_mainView addSubview:areaLabel];
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(_mainView.width-Width320(30), Height320(7), Width320(25), Height320(25))];
    
    UIImageView *closeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(5), Height320(5), Width320(15), Height320(15))];
    
    closeImg.layer.masksToBounds = YES;
    
    closeImg.image = [UIImage imageNamed:@"chest_close"];
    
    [closeButton addSubview:closeImg];
    
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainView addSubview:closeButton];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(50), _mainView.width, Height320(1))];
    
    line.backgroundColor = kMainColor;
    
    [_mainView addSubview:line];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), line.bottom+Height320(20), Width320(64), Height320(16))];
    
    firstLabel.text = @"状 态";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = AllFont(14);
    
    [_mainView addSubview:firstLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), firstLabel.top, Width320(180), Height320(16))];
    
    stateLabel.text = @"临时租用";
    
    stateLabel.textColor = UIColorFromRGB(0xf9944e);
    
    stateLabel.font = AllFont(14);
    
    [_mainView addSubview:stateLabel];
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, firstLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    secondLabel.text = @"会 员";
    
    secondLabel.textColor = UIColorFromRGB(0x999999);
    
    secondLabel.font = AllFont(14);
    
    [_mainView addSubview:secondLabel];
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), secondLabel.top, Width320(180), Height320(16))];
    
    userLabel.text = [NSString stringWithFormat:@"%@（%@）",_chest.borrowUser.name,_chest.borrowUser.phone];
    
    userLabel.textColor = UIColorFromRGB(0x333333);
    
    userLabel.font = AllFont(14);
    
    [_mainView addSubview:userLabel];
    
    UIButton *returnButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), userLabel.bottom+Height320(28), _mainView.width-Width320(24), Height320(36))];
    
    returnButton.backgroundColor = kMainColor;
    
    returnButton.layer.cornerRadius = Width320(2);
    
    [returnButton setTitle:@"归还更衣柜" forState:UIControlStateNormal];
    
    [returnButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    returnButton.titleLabel.font = AllFont(14);
    
    [_mainView addSubview:returnButton];
    
    [returnButton addTarget:self action:@selector(returnChest:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)close
{
    
    [self removeFromSuperview];
    
}

@end
