//
//  CardKindSpecCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindSpecCell.h"

@interface CardKindSpecCell ()

{
    
    UILabel *_chargeLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_validLabel;
    
    UILabel *_typeLabel;
    
    UIImageView *_addImg;
    
    UIImageView *_staffImg;
    
}

@end

@implementation CardKindSpecCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = 1;
        
        self.layer.borderColor = kMainColor.CGColor;
        
        self.layer.cornerRadius = 2;
        
        _chargeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(2), Height320(10), frame.size.width-Width320(4), Height320(18))];
        
        _chargeLabel.textColor = kMainColor;
        
        _chargeLabel.font = AllFont(14);
        
        _chargeLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_chargeLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chargeLabel.left, _chargeLabel.bottom+Height320(6), _chargeLabel.width, Height320(15))];
        
        _priceLabel.textColor = kMainColor;
        
        _priceLabel.font = AllFont(11);
        
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_priceLabel];
        
        _validLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chargeLabel.left, _priceLabel.bottom+Height320(4), _chargeLabel.width, _priceLabel.height)];
        
        _validLabel.textColor = kMainColor;
        
        _validLabel.font = AllFont(11);
        
        _validLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_validLabel];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chargeLabel.left, _priceLabel.bottom+Height320(4), _chargeLabel.width, _priceLabel.height)];
        
        _typeLabel.textColor = kMainColor;
        
        _typeLabel.font = AllFont(11);
        
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_typeLabel];
        
        _addImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(15), frame.size.height/2-Height320(15), Width320(30), Height320(30))];
        
        _addImg.image = [UIImage imageNamed:@"spec_add"];
        
        [self.contentView addSubview:_addImg];
        
        _staffImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(5), Height320(5), Width320(16), Height320(16))];
        
        _staffImg.image = [UIImage imageNamed:@"card_kind_spec_staff"];
        
        _staffImg.hidden = YES;
        
        [self.contentView addSubview:_staffImg];
        
    }
    
    return self;
    
}

-(void)setOnlyStaffCanSee:(BOOL)onlyStaffCanSee
{
    
    _onlyStaffCanSee = onlyStaffCanSee;
    
    _staffImg.hidden = !_onlyStaffCanSee;
    
}

-(void)setCardKindType:(CardKindType)cardKindType
{
    
    _cardKindType = cardKindType;
    
    _validLabel.hidden = _cardKindType == CardKindTypeTime;
    
}

-(void)setCharge:(NSString *)charge
{
    
    _charge = charge;
    
    _chargeLabel.text = [NSString stringWithFormat:@"%@%@",_charge,_cardKindType == CardKindTypePrepaid?@"元":_cardKindType == CardKindTypeTime?@"天":@"次"];
    
}

-(void)setPrice:(NSString *)price
{
    
    _price = price;
    
    _priceLabel.text = [NSString stringWithFormat:@"（售价%@元）",_price];
    
}

-(void)setValidDays:(NSInteger)validDays
{
    
    _validDays = validDays;
    
    _validLabel.text = [NSString stringWithFormat:@"有效期：%ld天",(long)_validDays];
    
    if (!_checkValid) {
        
        _validLabel.text = [NSString stringWithFormat:@"有效期：不限"];
        
    }else
    {
        
        _validLabel.text = [NSString stringWithFormat:@"有效期：%ld天",(long)_validDays];
        
    }
    
    [_typeLabel changeTop:_validLabel.bottom+Height320(4)];
    
}

-(void)setCheckValid:(BOOL)checkValid
{
    
    _checkValid = checkValid;
    
    if (!_checkValid) {
        
        _validLabel.text = [NSString stringWithFormat:@"有效期：不限"];
        
    }else
    {
        
        _validLabel.text = [NSString stringWithFormat:@"有效期：%ld天",(long)_validDays];
        
    }
    
    [_typeLabel changeTop:_validLabel.bottom+Height320(4)];
    
}

-(void)setTypes:(NSString *)types
{
    
    _types = types;
    
    _typeLabel.text = [@"适用于：" stringByAppendingString:_types];
    
}

-(void)setIsAdd:(BOOL)isAdd
{
    
    _isAdd = isAdd;
    
    if (_isAdd) {
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _addImg.hidden = NO;
        
        _priceLabel.hidden = YES;
        
        _validLabel.hidden = YES;
        
        _typeLabel.hidden = YES;
        
        _chargeLabel.hidden = YES;
        
    }else
    {
        
        self.layer.borderColor = kMainColor.CGColor;
        
        _addImg.hidden = YES;
        
        _priceLabel.hidden = NO;
        
        _validLabel.hidden = _cardKindType == CardKindTypeTime;
        
        _typeLabel.hidden = NO;
        
        _chargeLabel.hidden = NO;
        
    }
    
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    _chargeLabel.textColor = _priceLabel.textColor = _validLabel.textColor = _typeLabel.textColor = userInteractionEnabled?kMainColor:UIColorFromRGB(0xcccccc);
    
    self.layer.borderColor = userInteractionEnabled?kMainColor.CGColor:UIColorFromRGB(0xcccccc).CGColor;
    
    _staffImg.alpha = userInteractionEnabled?1:0.4;
    
}

@end
