//
//  GymCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GymCell.h"

@interface GymCell ()

{
    
    UIImageView *_imageView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation GymCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(40), Height320(40))];
        
        _imageView.layer.cornerRadius = _imageView.width/2;
        
        _imageView.layer.masksToBounds = YES;
        
        _imageView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
        
        _imageView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.right+Width320(8), Height320(20), MSW-Width320(32)-_imageView.right, Height320(13))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(13);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), _titleLabel.width, Height320(12))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5),Height320(30), Width320(7.5), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrowImg];
        
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
