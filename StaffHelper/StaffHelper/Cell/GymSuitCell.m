//
//  GymSuitCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GymSuitCell.h"

@interface GymSuitCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_chooseImg;
    
    UIView *_chooseBack;
        
}

@end

@implementation GymSuitCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(20), Width320(276)-_iconView.right, Height320(21))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(18))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _chooseBack = [[UIView alloc]initWithFrame:CGRectMake(MSW-Width320(30), Height320(30), Width320(14), Height320(14))];
        
        _chooseBack.layer.cornerRadius = _chooseBack.width/2;
        
        _chooseBack.layer.masksToBounds = YES;
        
        _chooseBack.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _chooseBack.layer.borderWidth = 1;
        
        _chooseBack.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        [self.contentView addSubview:_chooseBack];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(30), Height320(30), Width320(14), Height320(14))];
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
        _chooseImg.image = [UIImage imageNamed:@"selected"];
        
        [self.contentView addSubview:_chooseImg];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

-(void)setIsChoosed:(BOOL)isChoosed
{
    
    _isChoosed = isChoosed;
 
    _chooseImg.hidden = !_isChoosed;
    
    _chooseBack.hidden = _isChoosed;
    
}


-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    [_iconView sd_setImageWithURL:_imgUrl];
    
}

-(void)setHavePower:(BOOL)havePower
{
    
    _havePower = havePower;
    
    _titleLabel.textColor = _havePower?UIColorFromRGB(0x333333):UIColorFromRGB(0x999999);
    
    _subtitleLabel.textColor = _havePower?UIColorFromRGB(0x666666):UIColorFromRGB(0x999999);
    
    self.contentView.backgroundColor = _havePower?UIColorFromRGB(0xffffff):UIColorFromRGB(0xfbfbfb);
    
    _chooseImg.alpha = _havePower?1:0.4;
    
}

@end
