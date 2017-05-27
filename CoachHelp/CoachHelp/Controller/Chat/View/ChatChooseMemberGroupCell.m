//
//  ChatChooseMemberGroupCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseMemberGroupCell.h"

@interface ChatChooseMemberGroupCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_chooseImgView;
    
    UIImageView *_iconView;
    
    UIView *_line;
    
}

@end

@implementation ChatChooseMemberGroupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chooseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(50), Height(24), Width(20), Height(20))];
        
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
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(Width(148), Height(68)-OnePX, MSW-Width(148), OnePX)];
        
        _line.backgroundColor = UIColorFromRGB(0xe5e5e5);
        
        [self.contentView addSubview:_line];
        
    }
    
    return self;
    
}

-(void)layoutSubviews
{
    
    _titleLabel.text = [NSString stringWithFormat:@"%@(%@)",_name,_phone];
    
    [_iconView sd_setImageWithURL:_iconURL];
    
    _subtitleLabel.text = _position;
    
    _chooseImgView.layer.borderWidth = _choosed?0:Width(1);
    
    _chooseImgView.image = _choosed?[UIImage imageNamed:@"selected"]:nil;
    
    _line.hidden = _noline;
    
}

@end
