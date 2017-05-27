//
//  ReplyReceivedCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/2.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ReplyReceivedCell.h"

@interface ReplyReceivedCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UIButton *_replyButton;
    
    UILabel *_replyLabel;
    
    UIView *_newsView;
    
    UIImageView *_newsIconView;
    
    UILabel *_newsLabel;
    
    UILabel *_contentLabel;
    
}

@end

@implementation ReplyReceivedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.contentView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        
        self.contentView.layer.borderWidth = OnePX;
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(34), Height320(34))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width(10), Height(16), Width320(200), Height(17))];
        
        _titleLabel.textColor = UIColorFromRGB(0x888888);
        
        _titleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height(4), _titleLabel.width, Height(17))];
        
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        
        _timeLabel.font = AllFont(10);
        
        [self.contentView addSubview:_timeLabel];
        
        _replyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width(66), Height(22), Width(51), Height(26))];
        
        _replyButton.layer.cornerRadius = Width(2);
        
        _replyButton.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
        
        _replyButton.layer.borderWidth = OnePX;
        
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        
        [_replyButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        
        _replyButton.titleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_replyButton];
        
        [_replyButton addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
        
        _replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15),  Height(65), MSW-Width(30), Height(100))];
        
        _replyLabel.textColor = UIColorFromRGB(0x333333);
        
        _replyLabel.numberOfLines = 0;
        
        _replyLabel.font = AllFont(13);
        
        [self.contentView addSubview:_replyLabel];
        
        _newsView = [[UIView alloc]initWithFrame:CGRectMake(0, _replyLabel.bottom+Height(10), MSW, Height(90))];
        
        _newsView.backgroundColor = UIColorFromRGB(0xfbfbfb);
        
        _newsView.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
        
        _newsView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:_newsView];
        
        _newsIconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(60), Height(60))];
        
        _newsIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        _newsIconView.layer.masksToBounds = YES;
        
        [_newsView addSubview:_newsIconView];
        
        _newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(_newsIconView.right+Width(10),Height(23) , MSW-Width(25)-_newsIconView.right, Height(22))];
        
        _newsLabel.textColor = UIColorFromRGB(0x333333);
        
        _newsLabel.font = AllFont(15);
        
        [_newsView addSubview:_newsLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_newsLabel.left, _newsLabel.bottom+Height(4), _newsLabel.width, Height(18))];
        
        _contentLabel.textColor = UIColorFromRGB(0x666666);
        
        _contentLabel.font = AllFont(12);
        
        [_newsView addSubview:_contentLabel];
        
    }
    
    return self;
    
}

-(void)setReplyContent:(NSString *)replyContent
{
    
    _replyContent = replyContent;
    
    CGSize size = [_replyContent boundingRectWithSize:CGSizeMake(MSW-Width(30), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    _replyLabel.text = _replyContent;
    
    [_replyLabel changeHeight:(long)size.height];
    
    [_newsView changeTop:_replyLabel.bottom+Height(10)];
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

-(void)setReplyForName:(NSString *)replyForName
{
    
    _replyForName = replyForName;
    
    NSString *str = [NSString stringWithFormat:@"%@ 回复 %@",_name,_replyForName];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xbbbbbb) range:NSMakeRange(_name.length, 4)];
    
    _titleLabel.attributedText = astr;
    
}

-(void)setPressIconURL:(NSURL *)pressIconURL
{
    
    _pressIconURL = pressIconURL;
    
    [_newsIconView sd_setImageWithURL:_pressIconURL];
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setPressTitle:(NSString *)pressTitle
{
    
    _pressTitle = pressTitle;
    
    _newsLabel.text = _pressTitle;
    
}

-(void)setPressContent:(NSString *)pressContent
{
    
    _pressContent = pressContent;
    
    _contentLabel.text = _pressContent;
    
}


-(void)reply:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(replyWithReplyCell:)]) {
        
        [self.delegate replyWithReplyCell:self];
        
    }
    
}


@end
