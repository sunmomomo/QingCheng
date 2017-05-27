//
//  YFHomeBrandGymCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFHomeBrandGymCell.h"
#import "YFAppConfig.h"

@interface YFHomeBrandGymCell ()
{
    
    UIImageView *_imageView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_arrowImg;
    
    UILabel *_proLabel;
    
    UILabel *_positionLabel;
    
}
@end

@implementation YFHomeBrandGymCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(16), Width320(50), Height320(50))];
        
        _imageView.layer.cornerRadius = _imageView.width/2;
        
        _imageView.layer.masksToBounds = YES;
        
        _imageView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
        
        _imageView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(75), Height320(18), MSW-Width320(130), Height320(16))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _proLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(2), Height320(18), Width320(21), Height320(12))];
        
        _proLabel.layer.cornerRadius = _proLabel.height/2;
        
        _proLabel.layer.masksToBounds = YES;
        
        _proLabel.textAlignment = NSTextAlignmentCenter;
        
        _proLabel.textColor = UIColorFromRGB(0xffffff);
        
        _proLabel.font = AllFont(7);
        
        [self addSubview:_proLabel];
        
        _proLabel.center = CGPointMake(_proLabel.center.x, _titleLabel.center.y);
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), _titleLabel.width, Height320(12))];
        
        _subtitleLabel.font = AllFont(11);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5),Height320(35), Width320(7.5), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrowImg];
        
        _positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _subtitleLabel.bottom+Height320(4), _subtitleLabel.width, Height320(12))];
        
        _positionLabel.textColor = UIColorFromRGB(0x999999);
        
        _positionLabel.font = AllFont(11);
        
        [self.contentView addSubview:_positionLabel];
        
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:frame];
        
        self.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(Width320(75), frame.size.height, frame.size.width-Width320(75), OnePX)];
        
        lineView.backgroundColor = YFLineViewColor;
        
        [self addSubview:lineView];
    }
    return self;
}


-(void)setImageUrl:(NSURL *)imageUrl
{
    
    _imageUrl = imageUrl;
    
    [_imageView sd_setImageWithURL:_imageUrl];
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MSW-Width320(130), Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [_titleLabel changeWidth:size.width];
    
    [_proLabel changeLeft:_titleLabel.right+Width320(3)];
    
}

-(void)setPro:(BOOL)pro
{
    
    _pro = pro;
    
    _proLabel.text = _pro?@"PRO":@"FREE";
    
    _proLabel.backgroundColor = _pro?kMainColor:UIColorFromRGB(0xD0D0D0);
    
}

-(void)setPosition:(NSString *)position
{
    
    _position = position;
    
    _positionLabel.text = _position;
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

-(void)setHavePower:(BOOL)havePower
{
    
    _havePower = havePower;
    
    _imageView.alpha = _havePower?1:0.6;
    
    _titleLabel.textColor = _havePower?UIColorFromRGB(0x333333):UIColorFromRGB(0x999999);
    
    if (_havePower) {
        
        [self.contentView addSubview:_arrowImg];
        
    }else{
        
        [_arrowImg removeFromSuperview];
        
    }
    
}


@end
