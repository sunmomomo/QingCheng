//
//  CardKindCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindCell.h"

#import "CardKindView.h"

#import "CornerLabel.h"

@interface CardKindCell ()

{
    
    CardKindView *_cardView;
    
}

@end

@implementation CardKindCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _cardView = [[CardKindView alloc]initWithFrame:CGRectMake(Width320(10), Height320(5), MSW-Width320(20), Height320(164))];
        
        [self.contentView addSubview:_cardView];
        
        _cardView.layer.shadowOffset = CGSizeMake(0, 2);
        
        _cardView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        _cardView.layer.shadowOpacity = 0.2;
        
    }
    
    return self;
    
}

-(void)setState:(CardKindState)state
{
    
    _state = state;
    
    _cardView.state = _state;
    
}

-(void)setBackColor:(UIColor *)backColor
{
    
    _backColor = backColor;
    
    _cardView.cardBackColor = _backColor;
    
}

-(void)setCardId:(NSInteger)cardId
{
    
    _cardId = cardId;
    
    _cardView.cardId = _cardId;
    
}

-(void)setCardKindName:(NSString *)cardKindName
{
    
    _cardKindName = cardKindName;
    
    _cardView.cardKindName = _cardKindName;
    
}

-(void)setCardKindType:(CardKindType)cardKindType
{
    
    _cardKindType = cardKindType;
    
    _cardView.cardKindType = _cardKindType;
    
}

-(void)setAstrict:(NSString *)astrict
{
    
    _astrict = astrict;
    
    _cardView.astrict = _astrict;
    
}

-(void)setSummary:(NSString *)summary
{
    
    _summary = summary;
    
    _cardView.summary = _summary;
    
}

-(void)setGyms:(NSArray *)gyms
{
    
    _gyms = gyms;
    
    _cardView.gyms = gyms;
    
}


@end
