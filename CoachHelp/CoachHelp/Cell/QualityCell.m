//
//  QualityCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QualityCell.h"

@interface QualityCell ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *ognLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *validLabel;

@property(nonatomic,strong)UIImageView *verifiedImg;

@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation QualityCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(18), Width320(175), Height320(21))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _ognLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(5), _titleLabel.width, Height320(15))];
        
        _ognLabel.textColor = UIColorFromRGB(0x999999);
        
        _ognLabel.font = AllFont(13);
        
        [self.contentView addSubview:_ognLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), _ognLabel.bottom+Height320(5), Width320(225), Height320(15))];
        
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        
        _timeLabel.font = AllFont(13);
        
        [self.contentView addSubview:_timeLabel];
        
        _validLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), _timeLabel.bottom+Height320(3.5), Width320(225), Height320(15))];
        
        _validLabel.textColor = UIColorFromRGB(0x999999);
        
        _validLabel.font = AllFont(13);
        
        [self.contentView addSubview:_validLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(93), Height320(20), Width320(82), Height320(82))];
        
        _imgView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_imgView];
        
        [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick:)]];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(124)-1, MSW, 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:sep];
        
        _verifiedImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(21), Width320(14), Height320(14))];
        
        _verifiedImg.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        [self.contentView addSubview:_verifiedImg];
        
        _verifiedImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)imgClick:(UITapGestureRecognizer*)tap
{
    
    if ([self.delegate respondsToSelector:@selector(cellClickImg:)]) {
        
        [self.delegate cellClickImg:self];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    [_verifiedImg changeLeft:_titleLabel.right+Width320(8)];
    
}

-(void)setOgn:(NSString *)ogn
{
    
    _ogn = ogn;
    
    _ognLabel.text = [NSString stringWithFormat:@"发证机构：%@",_ogn];
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = [NSString stringWithFormat:@"发证日期：%@",_time];
    
}

-(void)setValidTime:(NSString *)validTime
{
    
    _validTime = validTime;
    
    _validLabel.text = _validTime;
    
    [_validLabel autoWidth];
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    if (!_imgUrl.absoluteString.length) {
        
        self.imgView.hidden = YES;
        
    }else
    {
        
        self.imgView.hidden = NO;
        
        [self.imgView sd_setImageWithURL:_imgUrl];
        
    }
    
}

-(void)setIsVerified:(BOOL)isVerified
{
    
    _isVerified = isVerified;
    
    _verifiedImg.hidden = !_isVerified;
    
}

@end
