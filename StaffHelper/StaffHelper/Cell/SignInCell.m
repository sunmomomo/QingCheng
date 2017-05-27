//
//  SignInCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SignInCell.h"

@interface SignInCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_gymLabel;
    
    UILabel *_cardLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_staffLabel;
    
}

@end

@implementation SignInCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(28), Height320(28))];
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(8), 0, Width320(150), Height320(53))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(115), 0, Width320(103), Height320(53))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(10),MSW-Width320(10)-_titleLabel.left,Height320(12))];
        
        _gymLabel.textColor = UIColorFromRGB(0x999999);
        
        _gymLabel.font = AllFont(12);
        
        [self.contentView addSubview:_gymLabel];
        
        _cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_gymLabel.left, _gymLabel.bottom+Height320(8), _gymLabel.bottom, _gymLabel.height)];
        
        _cardLabel.textColor = UIColorFromRGB(0x999999);
        
        _cardLabel.font = AllFont(12);
        
        [self.contentView addSubview:_cardLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardLabel.left, _cardLabel.bottom+Height320(8), _cardLabel.width, _cardLabel.height)];
        
        _priceLabel.textColor = UIColorFromRGB(0x999999);
        
        _priceLabel.font = AllFont(12);
        
        [self.contentView addSubview:_priceLabel];
        
        _staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.left, _priceLabel.bottom+Height320(8), _priceLabel.width, _priceLabel.height)];
        
        _staffLabel.textColor = UIColorFromRGB(0x999999);
        
        _staffLabel.font = AllFont(12);
        
        [self.contentView addSubview:_staffLabel];
        
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

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_imgView sd_setImageWithURL:_iconURL]; 
    
}

-(void)setSpread:(BOOL)spread
{
    
    _spread = spread;
    
    _gymLabel.hidden = _cardLabel.hidden = _priceLabel.hidden = _staffLabel.hidden = !_spread;
    
}

@end
