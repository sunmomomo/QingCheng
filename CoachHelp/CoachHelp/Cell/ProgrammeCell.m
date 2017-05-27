//
//  ProgrammeCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeCell.h"

@implementation NoPrivateProgrammeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(40))];
        
        view.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.contentView addSubview:view];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(14), Height320(14))];
        
        img.image = [UIImage imageNamed:@"programme_no_private"];
        
        [view addSubview:img];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(img.right+Width320(8), 0, Width320(200), Height320(40))];
        
        label.text = @"本日暂无会员预约私教课";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(13);
        
        [view addSubview:label];
        
    }
    
    return self;
    
}

@end

@interface ProgrammeCell ()

{
    
    UILabel *_timeLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_gymLabel;
    
    UILabel *_totalLabel;
    
    UIImageView *_userImg;
    
    UIImageView *_imgView;
    
    UILabel *_completeLabel;
    
    UIImageView *_restImgView;
    
    UILabel *_clashLabel;
    
    UIView *_lineView;
    
    UIView *_backView;
    
}

@end

@implementation ProgrammeCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(50))];
        
        _backView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.contentView addSubview:_backView];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(3), _backView.height)];
        
        [_backView addSubview:_lineView];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(8.5), Height320(10), Width320(44), Height320(21))];
        
        _timeLabel.font = AllBFont(16);
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        [_backView addSubview:_timeLabel];
        
        _completeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(14), _timeLabel.bottom+Height320(2), Width320(36), Height320(14))];
        
        _completeLabel.textColor = UIColorFromRGB(0Xaaaaaa);
        
        _completeLabel.textAlignment = NSTextAlignmentCenter;
        
        _completeLabel.text = @"已完成";
        
        _completeLabel.font = AllFont(9);
        
        _completeLabel.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _completeLabel.layer.borderWidth = OnePX;
        
        _completeLabel.center = CGPointMake(_timeLabel.center.x, _completeLabel.center.y);
        
        _completeLabel.hidden = YES;
        
        [_backView addSubview:_completeLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(80), Height320(10), Width320(155), Height320(20))];
        
        _titleLabel.font = AllFont(16);
        
        [_backView addSubview:_titleLabel];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), Width320(150), Height320(15))];
        
        _gymLabel.font = AllFont(12);
        
        [_backView addSubview:_gymLabel];
        
        _userImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.left, _gymLabel.bottom+Height320(4), Width320(12), Height320(12))];
        
        _userImg.image = [UIImage imageNamed:@"programme_user_count"];
        
        [_backView addSubview:_userImg];
        
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(_userImg.left, _gymLabel.bottom+Height320(2), _gymLabel.width, _gymLabel.height)];
        
        _totalLabel.font = AllFont(12);
        
        [_backView addSubview:_totalLabel];
        
        _clashLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), _totalLabel.bottom+Height320(10), MSW-Width320(28), Height320(18))];
        
        _clashLabel.backgroundColor = [UIColorFromRGB(0xea6161) colorWithAlphaComponent:0.1];
        
        _clashLabel.textColor = UIColorFromRGB(0xff5252);
        
        _clashLabel.font = STFont(12);
        
        [_backView addSubview:_clashLabel];
        
        _clashLabel.hidden = YES;
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(73), Height320(10), Width320(57), Height320(57))];
        
        [_backView addSubview:_imgView];
        
        _restImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(24), Height320(16), Width320(32), Height320(30))];
        
        _restImgView.image = [UIImage imageNamed:@"rest"];
        
        [_backView addSubview:_restImgView];
        
    }
    
    return self;
    
}

-(void)setTotal:(NSString *)total
{
    
    _total = total;
    
    _totalLabel.text = _total;
    
    if (_style == ProgrammeStyleNormal) {
        
        [_backView changeHeight:_clash.length?Height320(102):Height320(78)];
        
        [_lineView changeHeight:_backView.height];
        
        _lineView.backgroundColor = _completed?UIColorFromRGB(0xdddddd):_orderCount?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0x999999);
        
        _titleLabel.textColor = _completed?UIColorFromRGB(0xB2B2B2):UIColorFromRGB(0x333333);
        
        _timeLabel.textColor = _completed?UIColorFromRGB(0xB2B2B2):_orderCount>0?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0x333333);
        
        _gymLabel.textColor = _totalLabel.textColor = UIColorFromRGB(0xb2b2b2);
        
        _timeLabel.hidden = NO;
        
        _userImg.hidden = !_orderCount||_completed;
        
        [_totalLabel changeLeft:_userImg.hidden?_userImg.left:_userImg.right+Width320(3)];
        
        _totalLabel.hidden = NO;
        
        _completeLabel.hidden = !_completed;
        
        _restImgView.hidden = YES;
        
        _imgView.hidden = NO;
        
    }else
    {
        
        [_backView changeHeight:Height320(60)];
        
        [_lineView changeHeight:_backView.height];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _titleLabel.textColor = _completed?UIColorFromRGB(0xB2B2B2):UIColorFromRGB(0x333333);
        
        _gymLabel.textColor = _totalLabel.textColor = UIColorFromRGB(0xb2b2b2);
        
        _timeLabel.hidden = YES;
        
        _userImg.hidden = YES;
        
        _totalLabel.hidden = YES;
        
        _completeLabel.hidden = YES;
        
        _restImgView.hidden = NO;
        
        _imgView.hidden = YES;
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
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


-(void)setClash:(NSString *)clash
{
    
    _clash = clash;
    
    if (clash) {
        
        _clashLabel.hidden = NO;
        
        _clashLabel.text = [NSString stringWithFormat:@"    时间冲突：%@",_clash.length?_clash:@""];
        
    }else
    {
        
        _clashLabel.hidden = YES;
        
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
    
}


@end
