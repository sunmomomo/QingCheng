//
//  CardKindView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindView.h"

#import "MORepeatImageView.h"

#import "CornerLabel.h"

@interface CardKindView ()

{
    
    MORepeatImageView *_topView;
    
    UILabel *_titleLabel;
    
    UILabel *_idLabel;
    
    UILabel *_gymLabel;
    
    UILabel *_astrictLabel;
    
    UILabel *_summaryLabel;
    
    UILabel *_typeLabel;
    
    CornerLabel *_cornerLabel;
    
}

@end

@implementation CardKindView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _topView = [[MORepeatImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        _topView.layer.masksToBounds = YES;
        
        _topView.image = [UIImage imageNamed:@"card_back"];
        
        [self addSubview:_topView];
        
        UIView *view = [[UIView alloc]initWithFrame:_topView.frame];
        
        view.backgroundColor = [UIColor clearColor];
        
        view.layer.cornerRadius = Width320(8);
        
        view.layer.masksToBounds = YES;
        
        [self addSubview:view];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(16), Width320(200), Height320(20))];
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = AllFont(16);
        
        [self addSubview:_titleLabel];
        
        _idLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.right, Height320(18), self.width-Width320(12)-_titleLabel.right, _titleLabel.height)];
        
        _idLabel.textColor = UIColorFromRGB(0xfffffff);
        
        _idLabel.font = AllFont(12);
        
        _idLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_idLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), _titleLabel.bottom+Height320(12), self.width-Width320(24), Height320(4))];
        
        sep.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.4];
        
        [self addSubview:sep];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), sep.bottom+Height320(12), self.width-Width320(24), Height320(16))];
        
        _gymLabel.textColor = UIColorFromRGB(0xffffff);
        
        _gymLabel.font = AllFont(12);
        
        _gymLabel.numberOfLines = 0;
        
        [self addSubview:_gymLabel];
        
        _astrictLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _gymLabel.bottom+Height320(6), self.width-Width320(24), Height320(16))];
        
        _astrictLabel.textColor = UIColorFromRGB(0xffffff);
        
        _astrictLabel.font = AllFont(12);
        
        _astrictLabel.numberOfLines = 0;
        
        [self addSubview:_astrictLabel];
        
        _summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_astrictLabel.left, _astrictLabel.bottom+Height320(6), _astrictLabel.width, Height320(16))];
        
        _summaryLabel.textColor = UIColorFromRGB(0xffffff);
        
        _summaryLabel.font = AllFont(12);
        
        [self addSubview:_summaryLabel];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _summaryLabel.bottom+Height320(6), Width320(70), Height320(24))];
        
        _typeLabel.backgroundColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.4];
        
        _typeLabel.textColor = UIColorFromRGB(0xffffff);
        
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        
        _typeLabel.font = AllFont(12);
        
        [self addSubview:_typeLabel];
        
        _cornerLabel = [[CornerLabel alloc]initWithFrame:CGRectMake(frame.size.width-Width320(35), -Height320(3), Width320(71), Height320(31))];
        
        _cornerLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _cornerLabel.layer.borderWidth = 1;
        
        _cornerLabel.font = AllFont(9);
        
        _cornerLabel.textColor = UIColorFromRGB(0xffffff);
        
        _cornerLabel.transform = CGAffineTransformMakeRotation(M_PI*45.0f/180.0f);
        
        [view addSubview:_cornerLabel];
        
        _cornerLabel.hidden = YES;
        
    }
    return self;
}


-(void)setState:(CardKindState)state
{
    
    _state = state;
    
    if (_state == CardKindStateStop) {
        
        _cornerLabel.backgroundColor = UIColorFromRGB(0xEA6161);
        
        _cornerLabel.text = @"已停用";
        
        _cornerLabel.hidden = NO;
        
    }else
    {
        
        _cornerLabel.hidden = YES;
        
    }
    
}

-(void)setCardBackColor:(UIColor *)cardBackColor
{
    
    _cardBackColor = cardBackColor;
    
    CALayer *layer = [CALayer layer];
    
    layer.bounds = _topView.bounds;
    
    layer.borderWidth = 0;
    
    layer.frame = _topView.bounds;
    
    layer.backgroundColor = [_cardBackColor colorWithAlphaComponent:0.8].CGColor;
    
    if (_topView.layer.sublayers.count>=1) {
        
        CALayer *oldLayer = [_topView.layer.sublayers firstObject];
        
        [_topView.layer replaceSublayer:oldLayer with:layer];
        
    }else
    {
        
        [_topView.layer insertSublayer:layer atIndex:0];
        
    }
    
}

-(void)setCardKindName:(NSString *)cardKindName
{
    
    _cardKindName = cardKindName;
    
    _titleLabel.text = _cardKindName;
    
}

-(void)setCardId:(NSInteger)cardId
{
    
    _cardId = cardId;
    
    _idLabel.text = [NSString stringWithFormat:@"ID：%ld",(long)_cardId];
    
}

-(void)setCardKindType:(CardKindType)cardKindType
{
    
    _cardKindType = cardKindType;
    
    _typeLabel.text = _cardKindType == CardKindTypePrepaid?@"储值类型":_cardKindType == CardKindTypeTime?@"期限类型":_cardKindType == CardKindTypeCount?@"次卡类型":@"未知类型";
    
}

-(void)setAstrict:(NSString *)astrict
{
    
    _astrict = astrict;
    
    _astrictLabel.text = [NSString stringWithFormat:@"限制：%@",_astrict.length?_astrict:@"无"];
    
    CGSize size = [_astrictLabel.text boundingRectWithSize:CGSizeMake(self.width-Width320(24), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [_astrictLabel changeSize:size];
    
    [_summaryLabel changeTop:_astrictLabel.bottom+Height320(6)];
    
    [_typeLabel changeTop:_summaryLabel.bottom+Height320(6)];
    
    [self changeHeight:_astrictLabel.bottom+Height320(82)];
    
    [_topView changeHeight:_astrictLabel.top+size.height+Height320(72)];
    
    _topView.layer.cornerRadius = Width320(8);
    
    _topView.layer.masksToBounds = YES;
    
}

-(void)setSummary:(NSString *)summary
{
    
    _summary = summary;
    
    _summaryLabel.text = [NSString stringWithFormat:@"简介：%@",_summary.length?_summary:@"无"];
    
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    
    _cardBackColor = backgroundColor;
    
    CALayer *layer = [CALayer layer];
    
    layer.bounds = self.bounds;
    
    layer.borderWidth = 0;
    
    layer.frame = self.bounds;
    
    layer.backgroundColor = backgroundColor.CGColor;
    
    layer.cornerRadius = 8;
    
    [self.layer insertSublayer:layer atIndex:0];
    
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
    
    CGSize size = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    _gymLabel.text = gymStr;
    
    [_gymLabel changeHeight:size.height];
    
    [_astrictLabel changeTop:_gymLabel.bottom+Height320(6)];
    
    [_summaryLabel changeTop:_astrictLabel.bottom+Height320(6)];
    
    [_typeLabel changeTop:_summaryLabel.bottom+Height320(6)];
    
}

@end
