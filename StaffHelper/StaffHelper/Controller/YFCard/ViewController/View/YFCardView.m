//
//  YFCardView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardView.h"

#import "CornerLabel.h"

#import "MORepeatImageView.h"

@interface YFCardView ()
{
    UIImageView *_topView;
    
    UILabel *_titleLabel;
    
    UILabel *_userLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_timeDesLabel;
    
    UILabel *_remainLabel;
    
    UILabel *_remainDesLabel;
    
    UILabel *_numberlabel;
    
    UILabel *_gymLabel;
    
    CornerLabel *_cornerLabel;
    
    UIView *_stateView;
}


@end

@implementation YFCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _topView = [[MORepeatImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(10), frame.size.width - Width320(40), frame.size.height)];
        
        _topView.layer.cornerRadius = Width320(8);
        
        _topView.layer.masksToBounds = YES;
        
        _topView.image = [UIImage imageNamed:@"card_back"];
        
        [self addSubview:_topView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32),Height320(25), Width320(270), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(32),Height320(54), frame.size.width-Width320(64), Height320(2))];
        
        sep.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.4];
        
        [self addSubview:sep];
        
        
        _timeDesLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32), Height320(91), MSW-Width320(44), Height320(11))];
        
        _timeDesLabel.textColor = UIColorFromRGB(0xffffff);
        
        _timeDesLabel.font = AllFont(11);
        
        _timeDesLabel.text = @"有效期";
        
        [self addSubview:_timeDesLabel];
        
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32), Height320(108), MSW-Width320(44), Height320(15))];
        
        _timeLabel.textColor = UIColorFromRGB(0xffffff);
        
        _timeLabel.font = AllFont(12);
        
        [self addSubview:_timeLabel];
        //
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32), _timeLabel.bottom+Height320(6), MSW-Width320(44), Height320(14))];
        
        //        _userLabel.textColor = UIColorFromRGB(0xffffff);
        //
        //        _userLabel.font = AllFont(12);
        //
        //        _userLabel.numberOfLines = 0;
        
        //        [self addSubview:_userLabel];
        
        _numberlabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32), _userLabel.bottom+Height320(6), MSW-Width320(44), Height320(14))];
        
        //        _numberlabel.textColor = UIColorFromRGB(0xffffff);
        //
        //        _numberlabel.font = AllFont(12);
        
        //        [self addSubview:_numberlabel];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32), _numberlabel.bottom+Height320(8), MSW-Width320(44), Height320(14))];
        
        //        _gymLabel.textColor = UIColorFromRGB(0xffffff);
        //
        //        _gymLabel.font = AllFont(12);
        //
        //        _gymLabel.numberOfLines = 0;
        
        //        [self addSubview:_gymLabel];
        
        _remainDesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(Width320(217), _timeDesLabel.top, Width320(200), _timeDesLabel.height)];
        
        _remainDesLabel.textColor = UIColorFromRGB(0xffffff);
        
        _remainDesLabel.font = AllFont(11);
        
        _remainDesLabel.text = @"余额";
        
        [self addSubview:_remainDesLabel];
        
        
        
        _remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(217), _timeLabel.top, Width320(200), Height320(16))];
        
        _remainLabel.textColor = UIColorFromRGB(0xffffff);
        
        _remainLabel.font = AllFont(16);
        
        [self addSubview:_remainLabel];
        
        _stateView = [[UIView alloc]initWithFrame:_topView.frame];
        
        _stateView.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.3];
        
        _stateView.layer.cornerRadius = Width320(8);
        
        _stateView.layer.masksToBounds = YES;
        
        [self addSubview:_stateView];
        
        _stateView.hidden = YES;
        
        
        _cornerLabel = [[CornerLabel alloc]initWithFrame:CGRectMake(_topView.width - Width320(35), -Height320(3), Width320(71), Height320(31))];
        
        _cornerLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _cornerLabel.layer.borderWidth = 1;
        
        _cornerLabel.font = AllFont(9);
        
        _cornerLabel.textColor = UIColorFromRGB(0xffffff);
        
        _cornerLabel.hidden = YES;
        
        _cornerLabel.transform = CGAffineTransformMakeRotation(M_PI*45.0f/180.0f);
        
        [_topView addSubview:_cornerLabel];
        
        
        self.backgroundColor = UIColorFromRGB(0x4e4e4e);
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
        
    }else if (_state == CardStateExpired){
        _cornerLabel.backgroundColor = UIColorFromRGB(0xCCCCCC);
        
        _cornerLabel.text = @"已过期";
        
        _cornerLabel.hidden = NO;
        
        _stateView.hidden = YES;

    }
    else
    {
        
        _cornerLabel.hidden = YES;
        
        _stateView.hidden = YES;
        
    }
    
}

- (void)setTrial_days:(NSInteger)trial_days
{
    _trial_days = trial_days;
    if (_state == CardStateExpired) {
        _timeDesLabel.text = [NSString stringWithFormat:@"有效期  (已过期%@天)",@(-_trial_days)];
    }else
    {
        _timeDesLabel.text = @"有效期";
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
    
}

-(void)setStartTime:(NSString *)startTime
{
    _startTime = startTime;
    
    if (_startTime.length && _endTime.length) {
        
        _startTime = [_startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        _endTime = [_endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        
        _timeLabel.text = [NSString stringWithFormat:@"%@-%@",_startTime,_endTime];
    }
    
}

-(void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    
    if (_startTime.length && _endTime.length) {
        
        _startTime = [_startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        _endTime = [_endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        
        _timeLabel.text = [NSString stringWithFormat:@"%@-%@",_startTime,_endTime];
    }
    
}

-(void)setRemain:(CGFloat)remain
{
    
    _remain = remain;
    
    if (_type == CardKindTypePrepaid) {
        _remainLabel.text = [NSString stringWithFormat:@"%.2f%@",_remain,_type == CardKindTypePrepaid?@"元":_type == CardKindTypeTime?@"天":@"次"];
    }else
    {
        _remainLabel.text = [NSString stringWithFormat:@"%ld%@",(long)_remain,_type == CardKindTypePrepaid?@"元":_type == CardKindTypeTime?@"天":@"次"];

    }
}

-(void)setCheckValid:(BOOL)checkValid
{
    
    _checkValid = checkValid;
    
    if (!_checkValid) {
        
        _timeLabel.text = @"不限";
        
    }
    
}

-(void)changeHeight:(CGFloat)height
{
    
    [super changeHeight:height];
    
    [_topView changeHeight:height];
    
    self.cardBackColor = _cardBackColor;
    
}


@end
