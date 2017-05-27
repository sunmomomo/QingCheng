//
//  CardCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardCell.h"

#import "MORepeatImageView.h"

#import "CornerLabel.h"

@interface CardCell ()

{
    
    UIImageView *_cardView;
    
    UILabel *_titleLabel;
    
    UILabel *_userLabel;
    
    UILabel *_remainLabel;
    
    CornerLabel *_cornerLabel;
    
}

@end

@implementation CardCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _cardView = [[MORepeatImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(8), MSW-Width320(20), Height320(58))];
        
        _cardView.image = [UIImage imageNamed:@"card_back"];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_cardView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _cardView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        _cardView.layer.mask = maskLayer;
        
        [self.contentView addSubview:_cardView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardView.left+Width320(12), _cardView.top+Height320(11), Width320(275), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), Width320(150), Height320(14))];
        
        _userLabel.textColor = UIColorFromRGB(0xffffff);
        
        _userLabel.font = AllFont(12);
        
        [self.contentView addSubview:_userLabel];
        
        _remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(_userLabel.right+Width320(5), _userLabel.top, _cardView.right-Width320(17)-_userLabel.right, Height320(14))];
        
        _remainLabel.textColor = UIColorFromRGB(0xffffff);
        
        _remainLabel.textAlignment = NSTextAlignmentRight;
        
        _remainLabel.font = AllFont(12);
        
        [self.contentView addSubview:_remainLabel];
        
        _cornerLabel = [[CornerLabel alloc]initWithFrame:CGRectMake( _cardView.width-Width320(31),-Height320(7), Width320(70), Height320(36))];
        
        _cornerLabel.textColor = UIColorFromRGB(0xffffff);
        
        _cornerLabel.font = AllFont(9);
        
        _cornerLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _cornerLabel.layer.borderWidth = 1;
        
        _cornerLabel.transform = CGAffineTransformMakeRotation(M_PI*45.0f/180.0f);
        
        [_cardView addSubview:_cornerLabel];
        
    }
    
    return self;
    
}

-(void)setCardBackColor:(UIColor *)cardBackColor
{
        
    _cardBackColor = cardBackColor;
    
    CALayer *layer = [CALayer layer];

    layer.bounds = _cardView.bounds;
    
    layer.borderWidth = 0;
    
    layer.frame = _cardView.bounds;
    
    layer.backgroundColor = [cardBackColor colorWithAlphaComponent:0.86].CGColor;
    
    if (_cardView.layer.sublayers.count>1) {
        
        CALayer *oldLayer = [_cardView.layer.sublayers firstObject];
        
        [_cardView.layer replaceSublayer:oldLayer with:layer];
        
    }else
    {
        
        [_cardView.layer insertSublayer:layer atIndex:0];
        
    }
    
    [_cardView bringSubviewToFront:_cornerLabel];
    
}

-(void)setCardState:(CardState)cardState
{
    
    _cardState = cardState;
    
    switch (_cardState) {
        case CardStateNormal:
            _cornerLabel.hidden = YES;
            break;
        case CardStateRest:
        {
            _cornerLabel.hidden = NO;
            
            _cornerLabel.backgroundColor = UIColorFromRGB(0xf9944e);
            
            _cornerLabel.text = @"请假中";
        }
            break;
        case CardStateStop:
        {
            _cornerLabel.hidden = NO;
            
            _cornerLabel.backgroundColor = UIColorFromRGB(0xEA6161);
            
            _cornerLabel.text = @"已停卡";
        }
            break;
        case CardStateExpired:
        {
            _cornerLabel.hidden = NO;
            
            _cornerLabel.backgroundColor = UIColorFromRGB(0xCCCCCC);
            
            _cornerLabel.text = @"已过期";
        }
            break;
        default:
            break;
    }
    
}

-(void)setCardName:(NSString *)cardName
{
    
    _cardName = cardName;
    
    _titleLabel.text = _cardName;
    
}

-(void)setCardNumber:(NSInteger)cardNumber
{
    
    _cardNumber = cardNumber;
    
    if (_cardNumber) {
        
        _titleLabel.text = [_titleLabel.text stringByAppendingString:[NSString stringWithFormat:@"（%ld）",(long)_cardNumber]];
        
    }
    
}

-(void)setUsers:(NSArray *)users
{
    
    _users = users;
    
    NSString *str = @"";
    
    for (NSInteger i = 0; i<_users.count; i++) {
        
        Student *stu = _users[i];
        
        str = [str stringByAppendingString:stu.name];
        
        if (i<_users.count-1) {
            
            str = [str stringByAppendingString:@"、"];
            
        }
        
    }
    
    _userLabel.text = str;
    
}

-(void)setRemain:(CGFloat)remain
{
    
    _remain = remain;
    
    if (_cardType == CardKindTypeCount) {
        
        _remainLabel.text = [NSString stringWithFormat:@"余额：%ld次",(long)_remain];
        
    }else if (_cardType == CardKindTypePrepaid){

        _remainLabel.text = [NSString stringWithFormat:@"余额：%.2f元",_remain];
    }
    else
    {
        _remainLabel.text = [NSString stringWithFormat:@"余额：%ld天",(long)_remain];
    }
}

@end
