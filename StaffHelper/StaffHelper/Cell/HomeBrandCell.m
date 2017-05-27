//
//  HomeBrandCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "HomeBrandCell.h"

@interface HomeBrandCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation HomeBrandCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _iconView.layer.borderWidth = OnePX;
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(12), Height320(15), Width320(210), Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(2), _titleLabel.width, Height320(16))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(29), Height320(64)/2-Height320(17)/2, Width320(17), Height320(17))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        _chooseImg.layer.masksToBounds = YES;
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_chooseImg];
        
    }
    
    return self;
    
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

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_iconView sd_setImageWithURL:_imgURL];
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
}

@end
