//
//  ProgrammeCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeCell.h"

@interface ProgrammeCell ()

{
    
    UILabel *_timeLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_gymLabel;
    
    UILabel *_coachLabel;
    
    UILabel *_totalLabel;
    
    UIImageView *_completeImgView;
    
    UIImageView *_loactionImg;
    
    UIImageView *_userImg;
    
    UIImageView *_coachImg;
    
    UIImageView *_imgView;
    
    UIImageView *_backView;
    
    UILabel *_completeLabel;
    
    UIImageView *_restImgView;
    
}

@end

@implementation ProgrammeCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(8.5), Height320(22), Width320(44), Height320(17))];
        
        _timeLabel.font = AllFont(14);
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_timeLabel];
        
        _completeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(14), _timeLabel.bottom+Height320(2), Width320(36), Height320(14))];
        
        _completeLabel.textColor = UIColorFromRGB(0Xaaaaaa);
        
        _completeLabel.textAlignment = NSTextAlignmentCenter;
        
        _completeLabel.text = @"已完成";
        
        _completeLabel.font = AllFont(9);
        
        _completeLabel.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _completeLabel.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _completeLabel.center = CGPointMake(_timeLabel.center.x, _completeLabel.center.y);
        
        _completeLabel.hidden = YES;
        
        [self.contentView addSubview:_completeLabel];
        
        _completeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(66)+1-Width320(5.3), Height320(24.8), Width320(10.6), Height320(10.6))];
        
        _completeImgView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _completeImgView.layer.cornerRadius = _completeImgView.width/2;
        
        _completeImgView.layer.borderWidth = Width320(2);
        
        [self.contentView addSubview:_completeImgView];
        
        _backView = [[UIImageView alloc]initWithFrame:CGRectMake(_completeImgView.right+Width320(3), Height320(10), MSW-_completeImgView.right-Width320(8), Height320(85.3))];
        
        _backView.image = [[UIImage imageNamed:IPhone4_5_6_6P(@"bg_timeline_block5.png", @"bg_timeline_block5.png", @"bg_timeline_block6.png", @"bg_timeline_block6p.png")]stretchableImageWithLeftCapWidth:15 topCapHeight:30];
        
        _backView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_backView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_completeImgView.right+Width320(25), Height320(21), Width320(155), Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _loactionImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(8), Width320(8.4), Height320(12))];
        
        _loactionImg.image = [UIImage imageNamed:@"comlocation"];
        
        [self.contentView addSubview:_loactionImg];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(_loactionImg.right+Width320(8), _titleLabel.bottom+Height320(6), Width320(142), Height320(14))];
        
        _gymLabel.font = AllFont(12);
        
        [self.contentView addSubview:_gymLabel];
        
        _coachImg = [[UIImageView alloc]initWithFrame:CGRectMake(_loactionImg.left, _loactionImg.bottom+Height320(7), Width320(11), Height320(11))];
        
        _coachImg.image = [UIImage imageNamed:@"comuser"];
        
        [self.contentView addSubview:_coachImg];
        
        _coachLabel = [[UILabel alloc]initWithFrame:CGRectMake(_gymLabel.left, _gymLabel.bottom+Height320(6), _gymLabel.width, _gymLabel.height)];
        
        _coachLabel.font = AllFont(12);
        
        [self.contentView addSubview:_coachLabel];
        
        _userImg = [[UIImageView alloc]initWithFrame:CGRectMake(_loactionImg.left, _coachLabel.bottom+Height320(7), Width320(11), Height320(12))];
        
        _userImg.image = [UIImage imageNamed:@"programme_time"];
        
        [self.contentView addSubview:_userImg];
        
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(_gymLabel.left, _coachLabel.bottom+Height320(6), _gymLabel.width, _gymLabel.height)];
        
        _totalLabel.font = AllFont(12);
        
        [self.contentView addSubview:_totalLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(73), _completeImgView.top, Width320(57), Height320(57))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imgView];
        
        _restImgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(57.3), _backView.top+Height320(16), Width320(32), Height320(30))];
        
        _restImgView.image = [UIImage imageNamed:@"rest"];
        
        [self.contentView addSubview:_restImgView];
        
    }
    
    return self;
    
}

-(void)setTotal:(NSString *)total
{
    
    _total = total;
    
    _totalLabel.text = _total;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    if (_titleLabel.right+Width320(2)>=_imgView.left) {
        
        [_titleLabel changeWidth:_imgView.left-Width320(2)-_titleLabel.left];
        
    }
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setCoach:(NSString *)coach
{
    
    _coach = coach;
    
    _coachLabel.text = _coach;
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    if (_imgUrl.absoluteString.length) {
        
        [_imgView sd_setImageWithURL:_imgUrl];
        
    }else
    {
        
        _imgView.image = nil;
        
    }
    
    
}


-(void)setGym:(NSString *)gym
{
    
    _gym = gym;
    
    _gymLabel.text = _gym;
    
}

-(void)setStyle:(ProgrammeStyle)style
{
    
    _style = style;
    
    if (style == ProgrammeStyleCompleted) {
        
        _titleLabel.textColor = UIColorFromRGB(0xb0b0b0);
        
        _timeLabel.textColor = _gymLabel.textColor = _totalLabel.textColor = _coachLabel.textColor = UIColorFromRGB(0xb0b0b0);
        
        _userImg.hidden = NO;
        
        _totalLabel.hidden = NO;
        
        [_backView changeHeight:_totalLabel?Height320(103.3):Height320(85.3)];
        
        _completeImgView.layer.borderColor = [UIColor clearColor].CGColor;
        
        _completeImgView.image = [UIImage imageNamed:@"selected"];
        
        _completeLabel.hidden = NO;
        
        _restImgView.hidden = YES;
        
    }else if(style == ProgrammeStyleIncompleted)
    {
        
        _titleLabel.textColor = _timeLabel.textColor = UIColorFromRGB(0x222222);
        
        _totalLabel.textColor = _gymLabel.textColor = _coachLabel.textColor = UIColorFromRGB(0x747474);
        
        _userImg.hidden = NO;
        
        _totalLabel.hidden = NO;
        
        [_backView changeHeight:_totalLabel?Height320(103.3):Height320(65.3)];
        
        [_coachImg changeTop:_loactionImg.bottom+Height320(7)];
        
        [_coachLabel changeTop:_gymLabel.bottom+Height320(6)];
        
        _restImgView.hidden = YES;
        
        _completeImgView.image = nil;
        
        _completeLabel.hidden = YES;
        
        
    }else if (_style == ProgrammeStyleRestandCompleted)
    {
        
        _titleLabel.textColor = UIColorFromRGB(0xb0b0b0);
        
        _timeLabel.textColor = _gymLabel.textColor = _totalLabel.textColor = _coachLabel.textColor = UIColorFromRGB(0xb0b0b0);
        
        _userImg.hidden = YES;
        
        _totalLabel.hidden = YES;
        
        _completeImgView.layer.borderColor = [UIColor clearColor].CGColor;
        
        _completeImgView.image = [UIImage imageNamed:@"selected"];
        
        _completeLabel.hidden = NO;
        
        [_backView changeHeight:Height320(72)];
        
        _restImgView.hidden = NO;
        
    }
    else
    {
        
        _titleLabel.textColor = _timeLabel.textColor = UIColorFromRGB(0x222222);
        
        _totalLabel.textColor = _gymLabel.textColor = _coachLabel.textColor = UIColorFromRGB(0x747474);
        
        _userImg.hidden = YES;
        
        _completeImgView.image = nil;
        
        _completeLabel.hidden = YES;
        
        _totalLabel.hidden = YES;
        
        [_backView changeHeight:Height320(72)];
        
        _restImgView.hidden = NO;
        
    }
    
}

-(void)setCompletedColor:(UIColor *)completedColor
{
    
    _completedColor = completedColor;
    
    if (_style != ProgrammeStyleCompleted && _style != ProgrammeStyleRestandCompleted) {
        
        _completeImgView.layer.borderColor = _completedColor.CGColor;
        
    }
    
    
}


@end
