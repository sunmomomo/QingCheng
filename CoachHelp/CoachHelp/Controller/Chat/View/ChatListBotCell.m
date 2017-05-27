//
//  ChatListBotCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatListBotCell.h"

@interface ChatListBotCell ()

{
    
    UIImageView *_iconView;
    
    UIView *_pointView;
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_contentLabel;
    
    UIView *_topLineView;
    
    UIView *_botLineView;
    
}

@end

@implementation ChatListBotCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(10), Width(48), Height(48))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _pointView = [[UIView alloc]initWithFrame:CGRectMake(Width(52), Height(12), Width(9), Height(9))];
        
        _pointView.layer.cornerRadius = _pointView.width/2;
        
        _pointView.layer.masksToBounds = YES;
        
        _pointView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _pointView.layer.borderWidth = 1;
        
        _pointView.backgroundColor = UIColorFromRGB(0xEA6161);
        
        [self.contentView addSubview:_pointView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width(10), Height(13), Width(200), Height(21))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width(15)-Width(60), Height(15), Width(60), Height(17))];
        
        _timeLabel.textColor = UIColorFromRGB(0xcccccc);
        
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _timeLabel.font = AllFont(11);
        
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height(3), MSW-Width(15)-_titleLabel.left, Height(18))];
        
        _contentLabel.textColor = UIColorFromRGB(0x888888);
        
        _contentLabel.font = AllFont(12);
        
        [self.contentView addSubview:_contentLabel];
        
        _topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, OnePX)];
        
        _topLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        
        [self.contentView addSubview:_topLineView];
        
        _botLineView = [[UIView alloc]initWithFrame:CGRectMake(Width(15), Height(68)-OnePX, MSW-Width(15), OnePX)];
        
        _botLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        
        [self.contentView addSubview:_botLineView];
        
    }
    
    return self;
    
}

-(void)layoutSubviews
{
    
    _titleLabel.text = _title;
    
    _timeLabel.text = _time;
    
    _contentLabel.text = _content;
    
    _pointView.hidden = !_unRead;
    
    _topLineView.hidden = !_topLine;
    
    [_botLineView changeLeft:_botLine?0:Width(15)];
    
    [_botLineView changeWidth:_botLine?MSW:MSW-Width(15)];
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected?UIColorFromRGB(0xf2f2f2):UIColorFromRGB(0xffffff);
    
}

@end
