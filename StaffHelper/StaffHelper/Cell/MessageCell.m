//
//  MessageCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

{
    
    UIView *_point;
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_detailLabel;
    
    UILabel *_timeLabel;
    
    UIImageView *_arrow;
    
}

@end

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _point = [[UIView alloc]initWithFrame:CGRectMake(Width320(7), Height320(35), Width320(6), Height320(6))];
        
        _point.backgroundColor = kDeleteColor;
        
        _point.layer.cornerRadius = _point.width/2;
        
        _point.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_point];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(16), Width320(40), Height320(40))];
//        
//        _iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
//        
//        _iconView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(68), Height320(16), Width320(225), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(5), _titleLabel.width, Height320(50))];
        
        _detailLabel.textColor = UIColorFromRGB(0x666666);
        
        _detailLabel.font = AllFont(12);
        
        _detailLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_detailLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_detailLabel.left, _detailLabel.bottom+Height320(5), _titleLabel.width, Height320(13))];
        
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        
        _timeLabel.font = AllFont(11);
        
        [self.contentView addSubview:_timeLabel];
        
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(19), Height320(18), Width320(7), Height320(12))];
        
        _arrow.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrow];
        
    }
    
    return self;
    
}

-(void)setHaveRead:(BOOL)haveRead
{
    
    _haveRead = haveRead;
    
    _point.hidden = haveRead;
    
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

-(void)setDescriptions:(NSString *)descriptions
{
    
    _descriptions = descriptions;
    
    _detailLabel.text = _descriptions;
    
    CGSize size = [_descriptions boundingRectWithSize:CGSizeMake(Width320(225), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [_detailLabel changeSize:size];
    
    [_timeLabel changeTop:_detailLabel.bottom+Height320(5)];
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _gymName.length?[NSString stringWithFormat:@"%@，%@",_time,_gymName]:_time;
    
}

-(void)setGymName:(NSString *)gymName
{
    
    _gymName = gymName;
    
    _timeLabel.text = _time.length?[NSString stringWithFormat:@"%@，%@",_time,_gymName]:_gymName;
    
}

-(void)setHaveArrow:(BOOL)haveArrow
{
    _haveArrow = haveArrow;
    
    _arrow.hidden = !_haveArrow;
}

@end
