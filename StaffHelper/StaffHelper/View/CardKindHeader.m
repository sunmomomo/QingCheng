//
//  CardKindHeader.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindHeader.h"

@interface CardKindFilterButton : UIButton

{
    
    UILabel *_textLabel;
    
    UIImageView *_arrowImg;
    
}

@property(nonatomic,assign)CardKindType type;

@end

@implementation CardKindFilterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(8), 0, Width320(66), frame.size.height)];
        
        _textLabel.textAlignment = NSTextAlignmentRight;
        
        _textLabel.font = AllFont(14);
        
        [self addSubview:_textLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_textLabel.right+Width320(4), Height320(18), Width320(8), Height320(4))];
        
        _arrowImg.image = [[UIImage imageNamed:@"navi_pull_image"] imageWithTintColor:UIColorFromRGB(0x999999)];
        
        [self addSubview:_arrowImg];
        
        self.type = CardKindTypeNone;
        
    }
    
    return self;
    
}

-(void)setType:(CardKindType)type
{
    
    switch (type) {
            
        case CardKindTypePrepaid:
            
            _textLabel.text = @"储值类型";
            
            break;
            
        case CardKindTypeTime:
            
            _textLabel.text = @"期限类型";
            
            break;
            
        case CardKindTypeCount:
            
            _textLabel.text = @"次卡类型";
            
            break;
            
        default:
            
            _textLabel.text = @"全部类型";
            
            break;
            
    }
    
    if (type) {
        
        _arrowImg.image = [[UIImage imageNamed:@"navi_pull_image"] imageWithTintColor:kMainColor];
        
        _textLabel.textColor = kMainColor;
        
    }else{
        
        _arrowImg.image = [[UIImage imageNamed:@"navi_pull_image"] imageWithTintColor:UIColorFromRGB(0x999999)];
        
        _textLabel.textColor = UIColorFromRGB(0x999999);
        
    }
    
}

@end

@interface CardKindHeader()

{
    
    UILabel *_label;
    
    CardKindFilterButton *_filterButton;
    
    UILabel *_stateLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation CardKindHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(200), Height320(40))];
        
        _label.textColor = UIColorFromRGB(0x999999);
        
        _label.font = AllFont(14);
        
        [self addSubview:_label];
        
        _filterButton = [[CardKindFilterButton alloc]initWithFrame:CGRectMake(MSW-Width320(94), 0, Width320(94), Height320(40))];
        
        [self addSubview:_filterButton];
        
        [_filterButton addTarget:self.delegate action:@selector(filterCardKindType) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *stateButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(190), 0, Width320(96), Height320(40))];
        
        [stateButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
        stateButton.titleLabel.font = AllFont(14);
        
        [self addSubview:stateButton];
        
        [stateButton addTarget:self.delegate action:@selector(filterCardKindState) forControlEvents:UIControlEventTouchUpInside];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(84), Height320(40))];
        
        _stateLabel.textColor = UIColorFromRGB(0x999999);
        
        _stateLabel.font = AllFont(14);
        
        _stateLabel.textAlignment = NSTextAlignmentRight;
        
        [stateButton addSubview:_stateLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_stateLabel.right+Width320(4), Height320(18), Width320(8), Height320(4))];
        
        _arrowImg.image = [[UIImage imageNamed:@"navi_pull_image"] imageWithTintColor:UIColorFromRGB(0x999999)];
        
        [stateButton addSubview:_arrowImg];
        
        _arrowImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setType:(CardKindType)type
{
    
    _type = type;
    
    _filterButton.type = _type;
    
}

-(void)setCount:(NSInteger)count
{
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"会员卡种类：%ld",(long)count]];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(6, astr.length-6)];
    
    _label.attributedText = astr;
    
}

-(void)setState:(CardKindState)state
{
    
    _state = state;
    
    _stateLabel.text = _state == CardKindStateStop?@"状态:已停用":@"状态:正常";
    
    _arrowImg.hidden = !_stateLabel.text.length;
    
}

@end
