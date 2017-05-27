//
//  MyPlanCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyPlanCell.h"

@interface MyPlanCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subLabel;
    
    UIImageView*_typeImage;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation MyPlanCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(17.7), Width320(200), Height320(18.7))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(3), Height320(20), Width320(15), Height320(15))];
        
        _typeImage.layer.cornerRadius = _typeImage.height/2;
        
        _typeImage.layer.masksToBounds = YES;
        
        _typeImage.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        [self.contentView addSubview:_typeImage];
        
        _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3.5), Width320(200), Height320(16))];
        
        _subLabel.textColor = UIColorFromRGB(0x747474);
        
        _subLabel.font = AllFont(13);
        
        [self.contentView addSubview:_subLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25.3), Height320(22.7), Width320(6.7), Height320(10.7))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        _arrowImg.center = CGPointMake(_arrowImg.center.x, Height320(37.35));
        
        [self.contentView addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    if (_titleLabel.right>MSW-Width320(60)) {
        
        [_titleLabel changeWidth:MSW-Width320(60)-_titleLabel.left];
        
    }
    
    [_typeImage changeLeft:_titleLabel.right+Width320(3)];
    
}

-(void)setTags:(NSArray *)tags
{
    
    _tags = tags;
    
    [self setSubtitle];
    
}

-(void)setSubtitle
{
    
    NSString *tag = @"";
    
    for (NSString* string in _tags) {
        
        tag = [[tag stringByAppendingString:@"，"] stringByAppendingString:string];
        
    }
    
    if (tag.length) {
        
        tag = [tag substringFromIndex:1];
        
    }
    
    NSMutableArray *strArray = [NSMutableArray array];
    
    if (_gymName.length) {
        
        [strArray addObject:_gymName];
        
    }
    
    [strArray addObject:tag];
    
    _subLabel.text = [strArray componentsJoinedByString:@" | "];
    
}

-(void)setGymName:(NSString *)gymName
{
    
    _gymName = gymName;
    
    [self setSubtitle];
    
}

-(void)setType:(PlanType)type
{
    
    _type = type;
    
    _typeImage.hidden = _type == PlanTypePersonal;
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    if (highlighted) {
        
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
    }else
    {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
    }
    
}

@end
