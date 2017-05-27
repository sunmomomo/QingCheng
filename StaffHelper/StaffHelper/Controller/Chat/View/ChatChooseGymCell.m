//
//  ChatChooseGymCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseGymCell.h"

@interface ChatChooseGymCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
}

@end

@implementation ChatChooseGymCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(48), Height(48))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        
        _iconView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width(15), Height(18), Width(240), Height(21))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height(3), _titleLabel.width, Height(18))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x888888);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width(27), Height(33), Width(7), Height(12))];
        
        arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrowImg];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width(78), Height(78)-OnePX, MSW-Width(78), OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:line];
        
    }
    
    return self;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
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

@end
