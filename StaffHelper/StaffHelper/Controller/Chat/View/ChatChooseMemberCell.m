//
//  ChatChooseMemberCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseMemberCell.h"

@interface ChatChooseMemberCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_iconView;
    
    UIImageView *_chooseImgView;
    
}

@end

@implementation ChatChooseMemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
        
        self.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        _chooseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(24), Width(20), Height(20))];
        
        _chooseImgView.layer.borderColor = UIColorFromRGB(0xC8C8C8).CGColor;
        
        _chooseImgView.layer.borderWidth = Width(1);
        
        _chooseImgView.layer.cornerRadius = _chooseImgView.width/2;
        
        _chooseImgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_chooseImgView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(_chooseImgView.right+Width(15), Height(10), Width(48), Height(48))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15)+_iconView.right, Height(13), MSW-Width(30)-_iconView.right, Height(21))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height(3), _titleLabel.width, Height(18))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x888888);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width(113), Height(68)-OnePX, MSW-Width(113), OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:line];
        
    }
    
    return self;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _titleLabel.text = _name;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImgView.layer.borderWidth = _choosed?0:Width(1);
    
    _chooseImgView.image = _choosed?[UIImage imageNamed:@"selected"]:nil;
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _subtitleLabel.text = _phone;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

@end
