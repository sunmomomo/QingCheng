//
//  SellerListCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerListCell.h"

@interface SellerListCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_countLabel;
    
    UILabel *_subtitleLabel;

    
}

@end

@implementation SellerListCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectedBackgroundView = [[UIView alloc]init];
        
        self.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(40), Height320(40))];
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];

        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right + 12, _imgView.top, Width320(120), _imgView.height)];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.right, _titleLabel.top, MSW-Width320(29)-_titleLabel.right, _titleLabel.height)];
        
        _countLabel.textColor = UIColorFromRGB(0x333333);
        
        _countLabel.textAlignment = NSTextAlignmentRight;
        
        _countLabel.font = AllFont(12);
        
        [self.contentView addSubview:_countLabel];
        
//        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(37), MSW-Width320(32), Height320(14))];
//        
//        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
//        
//        _subtitleLabel.font = AllFont(12);
//        
//        [self.contentView addSubview:_subtitleLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), _titleLabel.center.y - Height320(12) / 2.0, Width320(7), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrow];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(64)-OnePX, MSW, OnePX)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:sep];
        
    }
    
    return self;
    
}

-(void)setSellerName:(NSString *)sellerName
{
    
    _sellerName = sellerName;
    
    _titleLabel.text = _sellerName;
    
}

-(void)setCount:(NSString *)count
{
    
    _count = count;
    
    _countLabel.text = _count;
    
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    _imgView.image = nil;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setUsers:(NSString *)users
{
    _users = users;
    
    _subtitleLabel.text = _users;
}

@end
