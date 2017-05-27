//
//  NewsCommentCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "NewsCommentCell.h"

@interface NewsCommentCell ()

{
    
    UILabel *_nameLabel;
    
    UIImageView *_iconView;
    
    UILabel *_timeLabel;
    
    UILabel *_contentLabel;
    
    UIView *_replyView;
    
    UILabel *_replyContentLabel;
    
}

@end

@implementation NewsCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(40), Height(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width(10), Height(16), Width(150), Height(15))];
        
        _nameLabel.textColor = UIColorFromRGB(0x888888);
        
        _nameLabel.font = AllFont(12);
        
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width(135), Height(17), Width(120), Height(13))];
        
        _timeLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _timeLabel.font = AllFont(11);
        
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, Height(38), MSW-_nameLabel.left-Width(15), Height(50))];
        
        _contentLabel.numberOfLines = 0;
        
        _contentLabel.textColor = UIColorFromRGB(0x333333);
        
        _contentLabel.font = AllFont(13);
        
        [self.contentView addSubview:_contentLabel];
        
        _replyView = [[UIView alloc]initWithFrame:CGRectMake(Width(65), 0, MSW-Width(65), Height(38))];
        
        _replyView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        [self.contentView addSubview:_replyView];
        
        _replyView.hidden = YES;
        
        _replyContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(10), Height(12), _replyView.width-Width(25), Height(18))];
        
        _replyContentLabel.textColor = UIColorFromRGB(0x888888);
        
        _replyContentLabel.numberOfLines = 0;
        
        _replyContentLabel.font = AllFont(12);
        
        [_replyView addSubview:_replyContentLabel];
        
    }
    
    return self;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

-(void)setContent:(NSString *)content
{
    
    _content = content;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:Height(4)];
    
    CGSize size = [_content boundingRectWithSize:CGSizeMake(MSW-Width(80), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
    [_contentLabel changeSize:CGSizeMake(size.width, ceil(size.height))];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:_content];

    [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, astr.length)];
    
    _contentLabel.attributedText = astr;
    
}

-(void)setReplyContent:(NSString *)replyContent
{
    
    _replyContent = replyContent;
    
    _replyView.hidden = !replyContent.length;
    
    [_replyView changeTop:_contentLabel.bottom+Height(8)];
    
    NSString *str = [NSString stringWithFormat:@"%@：%@",_replyName,_replyContent];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:Height(4)];
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(MSW-Width(90), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(_replyName.length+1, str.length-_replyName.length-1)];
    
    [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, astr.length)];
    
    _replyContentLabel.attributedText = astr;
    
    [_replyContentLabel changeSize:CGSizeMake(size.width, ceil(size.height))];
    
    [_replyView changeHeight:_replyContentLabel.height+Height(24)];
    
}

@end
