//
//  BrandCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandCell.h"

#import "UIImage+Category.h"

@interface BrandCell ()

{
    
    UIImageView *_backImgView;
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_arrowImgView;
    
    UIView *_backBlackView;
    
}

@end

@implementation BrandCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(144))];
        
        _backImgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _backImgView.layer.masksToBounds = YES;
        
        _backImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_backImgView];
        
        _backBlackView = [[UIView alloc]initWithFrame:_backImgView.frame];
        
        _backBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.38];
        
        [self.contentView addSubview:_backBlackView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(30), Height320(20), Width320(60), Height320(60))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.layer.borderWidth = 1;
        
        _iconView.layer.borderColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6].CGColor;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), _iconView.bottom+Height320(12), MSW-Width320(32), Height320(18))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), _titleLabel.bottom+Height320(3), MSW-Width320(32), Height320(14))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(44), Width320(7.5), Height320(12))];
        
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _arrowImgView.image = [[UIImage imageNamed:@"gray_arrow"] imageWithTintColor:UIColorFromRGB(0xffffff)];
        
        [self.contentView addSubview:_arrowImgView];
        
    }
    
    return self;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
     
    if (_iconURL.absoluteString.length) {
        
        [_iconView sd_setImageWithURL:_iconURL placeholderImage:[UIImage imageNamed:@"gymplaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.width && image.size.height) {
                
                _backBlackView.hidden = NO;
                
            }else{
                
                _backBlackView.hidden = YES;
                
            }
            
        }];
        
        [_backImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!gaussblur",_iconURL.absoluteString]] placeholderImage:[UIImage imageNamed:@"bg_brand"]];
        
    }else{
        
        _iconView.image = [UIImage imageNamed:@"gymempty"];
        
        _backImgView.image = [UIImage imageNamed:@"bg_brand"];
        
        _backBlackView.hidden = YES;
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title =  title;
    
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
    
    _arrowImgView.hidden = !havePower;
    
}

@end
