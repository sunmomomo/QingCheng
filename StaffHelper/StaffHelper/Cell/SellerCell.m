//
//  SellerCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerCell.h"

@interface SellerCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation SellerCell

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
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(18), Width320(44), Height320(44))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(31.5), MSW-Width320(32)-_imgView.right, Height320(17))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        [self.contentView addSubview:_titleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(36), Height320(30), Width320(20), Height320(20))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_chooseImg];
        
        _chooseImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _titleLabel.text = _name;
    
    [_titleLabel autoWidth];
    
}

-(void)setSelect:(BOOL)select
{
    
    _select = select;
    
    if (_select) {
        
        _titleLabel.textColor = kMainColor;
        
        _chooseImg.hidden = NO;
        
    }else
    {
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _chooseImg.hidden = YES;
        
    }
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    if (_imgUrl.absoluteString.length) {
        
        [_imgView sd_setImageWithURL:_imgUrl];
        
    }else
    {
        _imgView.image = [UIImage imageNamed:@"img_default_staff_male"];
    }
    
}

@end
