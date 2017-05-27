//
//  CardKindGymHeader.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindGymHeader.h"

@interface CardKindGymHeader ()

{
    
    UILabel *_label;
    
    UILabel *_stateLabel;
    
    UIImageView *_arrowImg;
    
}

@end


@implementation CardKindGymHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(200), Height320(40))];
        
        _label.textColor = UIColorFromRGB(0x999999);
        
        _label.font = AllFont(14);
        
        [self addSubview:_label];
        
        UIButton *stateButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(106), 0, Width320(96), Height320(40))];
        
        [stateButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
        stateButton.titleLabel.font = AllFont(14);
        
        [self addSubview:stateButton];
        
        [stateButton addTarget:self.delegate action:@selector(filterCardKindState) forControlEvents:UIControlEventTouchUpInside];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(85), Height320(40))];
        
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

