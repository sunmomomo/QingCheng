//
//  ChatCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _backView = [[UIView alloc]init];
        
        [self.contentView addSubview:_backView];
        
        _layerView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_layerView];
        
        _iconView = [[UIImageView alloc]init];
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]init ];
        
        _nameLabel.textColor = UIColorFromRGB(0x888888);
        
        _nameLabel.font = STFont(12);
        
        [self.contentView addSubview:_nameLabel];
        
    }
    
    return self;
    
}

-(void)layoutSubviews
{
    
    _backView.backgroundColor = self.isMine?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0xeeeeee);
    
    UIImage *image = [UIImage imageNamed:self.isMine?@"chat_cell_mine":@"chat_cell_other"];
    
    _layerView.image =  [image stretchableImageWithLeftCapWidth:20 topCapHeight:6];
    _iconView.frame = CGRectMake(_isMine?MSW-55:15, 5, 40,40);
    
    _iconView.layer.cornerRadius = _iconView.width/2;
    
    _nameLabel.frame = CGRectMake(_isMine?0:_iconView.right+11, 4, MSW-66, 14);
    
    _nameLabel.textAlignment = _isMine?NSTextAlignmentRight:NSTextAlignmentLeft;
    
    if (_iconURL.absoluteString.length) {
        
        [_iconView sd_setImageWithURL:_iconURL placeholderImage:[UIImage imageNamed:@"chat_user_empty"]];
        
    }else{
        
        _iconView.image = [UIImage imageNamed:@"chat_user_empty"];
        
    }
    
    if (_isGroup) {
        
        _nameLabel.text = _userName;
        
        [self.contentView addSubview:_nameLabel];
        
    }else{
        
        _nameLabel.text = nil;
        
        [_nameLabel removeFromSuperview];
        
    }
    
}

@end

@implementation ChatTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.font = STFont(15);
        
        _titleLabel.numberOfLines = 0;
        
        [_backView addSubview:_titleLabel];
        
    }
    
    return self;
    
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    _titleLabel.textColor = self.isMine?UIColorFromRGB(0xffffff):UIColorFromRGB(0x333333);
    
    _titleLabel.text = _content;
    
    CGSize size = [_content boundingRectWithSize:CGSizeMake(219, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:STFont(15)} context:nil].size;
    
    _titleLabel.frame = CGRectMake(self.isMine?13:21, 10, size.width, size.height);
    
    _backView.frame = CGRectMake(self.isMine?MSW-58-24-9-1-size.width:58, self.isGroup?_nameLabel.bottom+4:5, size.width+24+9+1,size.height+20);
    
    _layerView.frame = _backView.frame;
    
}

@end

@implementation ChatImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [[UIImageView alloc]init];
        
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)]];
        
        [self.contentView addSubview:_imageView];
        
    }
    
    return self;
    
}

-(void)imageTap:(UITapGestureRecognizer*)tap
{
    
    if ([self.delegate respondsToSelector:@selector(functionWithCell:)]) {
        
        [self.delegate functionWithCell:self];
        
    }
    
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(self.isMine?MSW-186:58, self.isGroup?_nameLabel.bottom+4:5, 128, self.imageHeight);
    
    [_iconView sd_setImageWithURL:self.iconURL];
    
    _backView.frame = CGRectMake(self.isMine?_imageView.left-1:_imageView.left, _imageView.top, _imageView.width+1, _imageView.height);
    
    _layerView.frame = _backView.frame;
    
    [_imageView sd_setImageWithURL:_imageURL];
    
    [self.contentView bringSubviewToFront:_layerView];
    
}

@end

@implementation ChatVoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(voiceTap:)]];
        
        _voiceImg = [[UIImageView alloc]init];
        
        [_backView addSubview:_voiceImg];
        
        _timeLabel = [[UILabel alloc]init];
        
        _timeLabel.textColor = UIColorFromRGB(0x888888);
        
        _timeLabel.font = STFont(15);
        
        [self.contentView addSubview:_timeLabel];
        
        _unreadView = [[UIView alloc]init];
        
        _unreadView.backgroundColor = UIColorFromRGB(0xEA6161);
        
        _unreadView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_unreadView];
        
    }
    
    return self;
    
}

-(void)voiceTap:(UITapGestureRecognizer*)tap
{
    
    if ([self.delegate respondsToSelector:@selector(functionWithCell:)]) {
        
        [self.delegate functionWithCell:self];
        
    }
    
}

-(void)play
{
    
    _unreadView.hidden = YES;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i =1; i<4; i++) {
        
        NSString *str = self.isMine?[NSString stringWithFormat:@"chat_voice_mine_%ld",(long)i]:[NSString stringWithFormat:@"chat_voice_other_%ld",(long)i];
        
        [array addObject:[UIImage imageNamed:str]];
        
    }
    
    _voiceImg.animationImages = array;
    
    _voiceImg.animationDuration = 1;
    
    _voiceImg.animationRepeatCount = 0;
    
    [_voiceImg startAnimating];
    
}

-(void)stop
{
    
    [_voiceImg stopAnimating];
    
    _voiceImg.image = [UIImage imageNamed:self.isMine?@"chat_voice_mine_3":@"chat_voice_other_3"];
    
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGFloat width = MAX(64,MIN(64+5*(self.voiceLength-3), 220));
    
    _backView.frame = CGRectMake(self.isMine?MSW-58-width-1:58, self.isGroup?_nameLabel.bottom+4:5,width+1, 40);
    
    _layerView.frame = _backView.frame;
    
    _voiceImg.frame = CGRectMake(self.isMine?_backView.width-44:20, 10, 20, 20);
    
    _voiceImg.image = [UIImage imageNamed:self.isMine?@"chat_voice_mine_3":@"chat_voice_other_3"];
    
    _unreadView.frame = CGRectMake(self.isMine?_backView.left-15:_backView.right+8, _backView.top, 7, 7);
    
    _unreadView.layer.cornerRadius = _unreadView.width/2;
    
    _unreadView.hidden = _unread;
    
    if (self.isMine) {
        
        _unreadView.hidden = YES;
        
    }
    
    _timeLabel.frame = CGRectMake(self.isMine?15:_backView.right+8, _backView.top, self.isMine?_backView.left-15-8:MSW-15-8-_backView.right, Height(40));
    
    _timeLabel.text = [NSString stringWithFormat:@"%ld’’",(long)_voiceLength];
    
    _timeLabel.textAlignment = self.isMine?NSTextAlignmentRight:NSTextAlignmentLeft;
    
}

@end

@implementation ChatTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGSize timeSize = [@"时间" boundingRectWithSize:CGSizeMake(MSW,Height(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:STFont(12)} context:nil].size;
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, MSW, timeSize.height)];
        
        _timeLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        _timeLabel.font = STFont(12);
        
        [self.contentView addSubview:_timeLabel];
        
    }
    
    return self;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

@end

@implementation ChatSystemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _contentLabel = [[UILabel alloc]init];
        
        _contentLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _contentLabel.layer.cornerRadius = 4;
        
        _contentLabel.layer.masksToBounds = YES;
        
        _contentLabel.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _contentLabel.font = STFont(12);
        
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_contentLabel];
        
    }
    
    return self;
    
}

-(void)setContent:(NSString *)content
{
    
    _content = content;
    
    CGSize size = [_content boundingRectWithSize:CGSizeMake(MSW-60, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:STFont(12)} context:nil].size;
    
    _contentLabel.frame = CGRectMake(MSW/2-size.width/2-15, 8, size.width+30, size.height+8);
    
    _contentLabel.text = _content;
    
}

@end
