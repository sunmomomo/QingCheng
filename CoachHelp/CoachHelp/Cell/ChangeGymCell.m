//
//  ChangeGymCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChangeGymCell.h"

@interface ChangeGymCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_iconLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation ChangeGymCell

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
        
        _iconLabel = [[UILabel alloc]initWithFrame:_iconView.frame];
        
        _iconLabel.backgroundColor = [kMainColor colorWithAlphaComponent:0.6];
        
        _iconLabel.text = @"All";
        
        _iconLabel.textColor = UIColorFromRGB(0xffffff);
        
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        
        _iconLabel.font = AllFont(16);
        
        _iconLabel.layer.cornerRadius = _iconLabel.width/2;
        
        _iconLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconLabel.right+Width320(8), Height320(18), Width320(276)-_iconLabel.right, Height320(17))];
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(5), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(36), Height320(26), Width320(20), Height320(20))];
        
        _chooseImg.image = [UIImage imageNamed:@"ic_chosen"];
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
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
    
    if (_isChoosed) {
        
        _titleLabel.textColor = kMainColor;
        
        _subtitleLabel.textColor = kMainColor;
        
        _chooseImg.hidden = NO;
        
    }else
    {
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _chooseImg.hidden = YES;
        
    }
    
}

-(void)setIsAll:(BOOL)isAll
{
    
    _isAll = isAll;
    
    if (_isAll) {
        
        [_titleLabel changeTop:Height320(28)];
        
        _subtitleLabel.hidden = YES;
        
        _iconView.hidden = YES;
        
        _iconLabel.hidden = NO;
        
    }else
    {
        
        [_titleLabel changeTop:Height320(20)];
        
        _subtitleLabel.hidden = NO;
        
        _iconView.hidden = NO;
        
        _iconLabel.hidden = YES;
        
    }
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    [_iconView sd_setImageWithURL:_imgUrl];
    
}

-(void)setHavePower:(BOOL)havePower
{
    
    _havePower = havePower;
    
    _iconView.alpha = _havePower?1:0.6;
    
    _subtitleLabel.textColor = _titleLabel.textColor = _havePower?UIColorFromRGB(0x333333):UIColorFromRGB(0x999999);
    
    _chooseImg.alpha = _havePower?1:0.6;
    
    self.contentView.backgroundColor = _havePower?UIColorFromRGB(0xffffff):UIColorFromRGB(0xfbfbfb);
    
}

@end
