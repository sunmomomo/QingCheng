//
//  CardView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardView.h"

#import "CornerLabel.h"

#import "MORepeatImageView.h"

@interface CardView ()

{
    
    UIImageView *_topView;
    
    UILabel *_titleLabel;
    
    UILabel *_userLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_remainLabel;
    
    UILabel *_numberlabel;
    
    UILabel *_gymLabel;
    
    CornerLabel *_cornerLabel;
    
    UIView *_stateView;
    
}

@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _topView = [[MORepeatImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _topView.layer.cornerRadius = Width320(8);
        
        _topView.layer.masksToBounds = YES;
        
        _topView.image = [UIImage imageNamed:@"card_back"];
        
        [self addSubview:_topView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12),Height320(16), Width320(270), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(12),Height320(44), frame.size.width-Width320(24), Height320(2))];
        
        sep.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.4];
        
        [self addSubview:sep];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), sep.bottom+Height320(9), MSW-Width320(44), Height320(14))];
        
        _timeLabel.textColor = UIColorFromRGB(0xffffff);
        
        _timeLabel.font = AllFont(12);
        
        [self addSubview:_timeLabel];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _timeLabel.bottom+Height320(6), MSW-Width320(44), Height320(14))];
        
        _userLabel.textColor = UIColorFromRGB(0xffffff);
        
        _userLabel.font = AllFont(12);
        
        _userLabel.numberOfLines = 0;
        
        [self addSubview:_userLabel];
        
        _numberlabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _userLabel.bottom+Height320(6), MSW-Width320(44), Height320(14))];
        
        _numberlabel.textColor = UIColorFromRGB(0xffffff);
        
        _numberlabel.font = AllFont(12);
        
        [self addSubview:_numberlabel];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _numberlabel.bottom+Height320(8), MSW-Width320(44), Height320(14))];
        
        _gymLabel.textColor = UIColorFromRGB(0xffffff);
        
        _gymLabel.font = AllFont(12);
        
        _gymLabel.numberOfLines = 0;
        
        [self addSubview:_gymLabel];
        
        _remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _userLabel.bottom+Height320(26), Width320(200), Height320(14))];
        
        _remainLabel.textColor = UIColorFromRGB(0xffffff);
        
        _remainLabel.font = AllFont(12);
        
        [self addSubview:_remainLabel];
        
        _stateView = [[UIView alloc]initWithFrame:_topView.frame];
        
        _stateView.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.3];
        
        [self addSubview:_stateView];
        
        _stateView.hidden = YES;
        
        _cornerLabel = [[CornerLabel alloc]initWithFrame:CGRectMake(frame.size.width-Width320(35), -Height320(3), Width320(71), Height320(31))];
        
        _cornerLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _cornerLabel.layer.borderWidth = 1;
        
        _cornerLabel.font = AllFont(9);
        
        _cornerLabel.textColor = UIColorFromRGB(0xffffff);
        
        _cornerLabel.hidden = YES;
        
        _cornerLabel.transform = CGAffineTransformMakeRotation(M_PI*45.0f/180.0f);
        
        [_topView addSubview:_cornerLabel];
        
    }
    return self;
}

-(void)setCardBackColor:(UIColor *)cardBackColor
{
    
    _cardBackColor = cardBackColor;
    
    CALayer *layer = [CALayer layer];
    
    layer.bounds = _topView.bounds;
    
    layer.borderWidth = 0;
    
    layer.frame = _topView.bounds;
    
    layer.backgroundColor = [_cardBackColor colorWithAlphaComponent:0.8].CGColor;
    
    if (_topView.layer.sublayers.count>1) {
        
        CALayer *oldLayer = [_topView.layer.sublayers firstObject];
        
        [_topView.layer replaceSublayer:oldLayer with:layer];
        
    }else
    {
        
        [_topView.layer insertSublayer:layer atIndex:0];
        
    }
    
}

-(void)setState:(CardState)state
{
    
    _state = state;
    
    if (_state == CardStateStop) {
    
        _cornerLabel.backgroundColor = UIColorFromRGB(0xEA6161);
        
        _cornerLabel.text = @"已停卡";
        
        _cornerLabel.hidden = NO;
        
        _stateView.hidden = NO;
        
    }else if (_state == CardStateRest){
        
        _cornerLabel.backgroundColor = UIColorFromRGB(0xF9944E);
        
        _cornerLabel.text = @"请假中";
     
        _cornerLabel.hidden = NO;
        
        _stateView.hidden = YES;
        
    }else
    {
        
        _cornerLabel.hidden = YES;
        
        _stateView.hidden = YES;
        
    }
    
}

-(void)setCardName:(NSString *)cardName
{
    
    _cardName = cardName;
    
    _titleLabel.text = _cardName;
    
}

-(void)setCardId:(NSInteger)cardId
{
    
    _cardId = cardId;
    
    if (_cardId) {
        
        _titleLabel.text = [_titleLabel.text stringByAppendingString:[NSString stringWithFormat:@"（%ld）",(long)_cardId]];
        
    }
    
}

-(void)setCardNumber:(NSString*)cardNumber
{
    
    _cardNumber = cardNumber;
    
    _numberlabel.text = _cardNumber.length?[NSString stringWithFormat:@"实体卡号：%@",_cardNumber]:@"实体卡号：未填写";
    
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
    
    _userLabel.text = [@"绑定会员：" stringByAppendingString:str];
    
    [_userLabel autoHeight];
    
    [_numberlabel changeTop:_userLabel.bottom+Height320(6)];
    
    [_remainLabel changeTop:_numberlabel.bottom+Height320(26)];
    
}

-(void)setGyms:(NSArray *)gyms
{
    
    _gyms = gyms;
    
    NSString *gymStr = @"适用场馆：";
    
    for (NSInteger i = 0; i<_gyms.count; i++) {
        
        Gym *gym = _gyms[i];
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if (i<_gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    
    CGSize gymSize = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    _gymLabel.text = gymStr;
    
    [_gymLabel changeSize:gymSize];
    
    [_gymLabel changeTop:_numberlabel.bottom+Height320(6)];
    
    [_remainLabel changeTop:_gymLabel.bottom+Height320(26)];
    
}

-(void)setStartTime:(NSString *)startTime
{
    
    _startTime = startTime;
    
    if (_startTime.length && _endTime.length) {
        
        _timeLabel.text = [NSString stringWithFormat:@"有效期：%@ 至 %@",_startTime,_endTime];
        
    }
    
}

-(void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    
    if (_startTime.length && _endTime.length) {
        
        _timeLabel.text = [NSString stringWithFormat:@"有效期：%@ 至 %@",_startTime,_endTime];
        
    }
    
}

-(void)setRemain:(NSInteger)remain
{
    
    _remain = remain;
    
    _remainLabel.text = [NSString stringWithFormat:@"余额：%ld%@",(long)_remain,_type == CardKindTypePrepaid?@"元":_type == CardKindTypeTime?@"天":@"次"];
    
}

-(void)setCheckValid:(BOOL)checkValid
{
 
    _checkValid = checkValid;
    
    if (!_checkValid) {
        
        _timeLabel.text = @"有效期：不限";
        
    }
    
}

-(void)changeHeight:(CGFloat)height
{
    
    [super changeHeight:height];
    
    [_topView changeHeight:height];
    
    self.cardBackColor = _cardBackColor;
    
}

@end
