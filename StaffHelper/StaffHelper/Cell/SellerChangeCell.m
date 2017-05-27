//
//  SellerChangeCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerChangeCell.h"

@interface SellerChangeCell ()

{
    
    UIImageView *_imageView;
    
    UILabel *_nameLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation SellerChangeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(16), Width320(54), Height320(54))];
        
        _imageView.layer.masksToBounds = YES;
        
        _imageView.layer.cornerRadius = _imageView.width/2;
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imageView.layer.borderColor = kMainColor.CGColor;
        
        _imageView.layer.borderWidth = 0;
        
        [self addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom+Height320(6), Width320(80), Height320(16))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = AllFont(12);
        
        [self addSubview:_nameLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(_imageView.right-Width320(16), _imageView.bottom-Height320(16), Width320(16), Height320(16))];
        
        _chooseImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chooseImg.layer.cornerRadius = _chooseImg.width/2;
        
        _chooseImg.layer.masksToBounds = YES;
        
        _chooseImg.image = [UIImage imageNamed:@"selected"];
        
        [self addSubview:_chooseImg];
        
    }
    
    return self;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
    _imageView.layer.borderWidth = _choosed?OnePX*2:0;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_imageView sd_setImageWithURL:_iconURL];
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
}

@end
