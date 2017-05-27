//
//  SpecCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SpecCell.h"

@interface SpecCell ()

{
    
    UIView *_cornerView;
    
    UILabel *_priceLabel;
    
    UILabel *_costLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_otherLabel;
    
    UIImageView *_staffImg;
    
}

@end

@implementation SpecCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.cornerRadius = Width320(2);
        
        self.layer.masksToBounds = YES;
        
        self.layer.borderColor = kMainColor.CGColor;
        
        self.layer.borderWidth = 1;
        
        _cornerView = [[UIView alloc]initWithFrame:CGRectMake(Width320(64), 0, Width320(24), Height320(24))];
        
        [self.contentView addSubview:_cornerView];
        
        _cornerView.hidden = YES;
        
        UIView *cornerBack = [[UIView alloc]initWithFrame:CGRectMake(Width320(7), -Height320(17), Width320(34), Height320(34))];
        
        cornerBack.backgroundColor = kMainColor;
        
        [_cornerView addSubview:cornerBack];
        
        cornerBack.transform = CGAffineTransformMakeRotation(45.0f/180.0f*M_PI);
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(11), Height320(3), Width320(12), Height320(9))];
        
        image.image = [UIImage imageNamed:@"white_check"];
        
        [_cornerView addSubview:image];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(1), Height320(11), Width320(86), Height320(16))];
        
        _priceLabel.textColor = kMainColor;
        
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        _priceLabel.font = AllFont(14);
        
        [self.contentView addSubview:_priceLabel];
        
        _costLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _priceLabel.bottom+Height320(6), Width320(88), Height320(13))];
        
        _costLabel.textColor = kMainColor;
        
        _costLabel.textAlignment = NSTextAlignmentCenter;
        
        _costLabel.font = AllFont(11);
        
        [self.contentView addSubview:_costLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _costLabel.bottom+Height320(4), Width320(88), Height320(13))];
        
        _timeLabel.textColor = kMainColor;
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        _timeLabel.font = AllFont(11);
        
        [self.contentView addSubview:_timeLabel];
        
        _otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height/2-Height320(8), Width320(88), Height320(16))];
        
        _otherLabel.text = @"其他";
        
        _otherLabel.textColor = kMainColor;
        
        _otherLabel.textAlignment = NSTextAlignmentCenter;
        
        _otherLabel.font = AllFont(14);
        
        [self.contentView addSubview:_otherLabel];
        
        _otherLabel.hidden = YES;
        
        _staffImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(5), Height320(5), Width320(16), Height320(16))];
        
        _staffImg.image = [UIImage imageNamed:@"card_kind_spec_staff"];
        
        _staffImg.hidden = YES;
        
        [self.contentView addSubview:_staffImg];
        
    }
    return self;
}

-(void)setType:(SpecType)type
{
    
    _type = type;
    
    if (type == SpecTypeOther) {
        
        _otherLabel.hidden = NO;
        
        _priceLabel.hidden = YES;
        
        _costLabel.hidden = YES;
        
        _timeLabel.hidden = YES;
        
    }else
    {
        
        _otherLabel.hidden = YES;
        
        _priceLabel.hidden = NO;
        
        _costLabel.hidden = NO;
        
        _timeLabel.hidden = _cardKindType == CardKindTypeTime;
        
    }
    
}

-(void)setCardKindType:(CardKindType)cardKindType
{
    
    _cardKindType = cardKindType;
    
    _timeLabel.hidden = _cardKindType == CardKindTypeTime;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _cornerView.hidden = !_choosed;
    
}

-(void)setPrice:(NSString *)price
{
    
    _price = price;
    
    _priceLabel.text = [NSString stringWithFormat:@"%@%@",_price,_cardKindType == CardKindTypeTime?@"天":_cardKindType == CardKindTypePrepaid?@"元":@"次"];
    
}

-(void)setOnlyStaffCanSee:(BOOL)onlyStaffCanSee
{
    
    _onlyStaffCanSee = onlyStaffCanSee;
    
    _staffImg.hidden = !_onlyStaffCanSee;
    
}

-(void)setCost:(NSString *)cost
{
    
    _cost = cost;
    
    _costLabel.text = [NSString stringWithFormat:@"（售价%@元）",_cost];
    
}

-(void)setValidTime:(NSInteger)validTime
{
    
    _validTime = validTime;
    
    _timeLabel.text = _checkValid?[NSString stringWithFormat:@"有效期：%ld天",(long)_validTime]:@"有效期：不限";
    
}

-(void)setCheckValid:(BOOL)checkValid
{
    
    _checkValid = checkValid;
    
    _timeLabel.text = _checkValid?[NSString stringWithFormat:@"有效期：%ld天",(long)_validTime]:@"有效期：不限";
    
}

@end
