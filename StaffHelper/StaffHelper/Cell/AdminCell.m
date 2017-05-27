//
//  AdminCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "AdminCell.h"

@interface AdminCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_sexImgView;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation AdminCell

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
        
        UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(2))];
        
        topImg.image = [UIImage imageNamed:@"super_admin_back"];
        
        [self.contentView addSubview:topImg];
        
        UIImageView *adminIcon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(17), Width320(13), Height320(14))];
        
        adminIcon.image = [UIImage imageNamed:@"super_admin_icon"];
        
        [self.contentView addSubview:adminIcon];
        
        UILabel *adminLabel = [[UILabel alloc]initWithFrame:CGRectMake(adminIcon.right+Width320(17), Height320(16), Width320(100), Height320(16))];
        
        adminLabel.text = @"超级管理员";
        
        adminLabel.textColor = UIColorFromRGB(0xF9944E);
        
        adminLabel.font = AllFont(14);
        
        [self.contentView addSubview:adminLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(46), Width320(42), Height320(42))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(50), MSW-Width320(32)-_imgView.right, Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        [self.contentView addSubview:_titleLabel];
        
        _sexImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(4), _titleLabel.center.y-Height320(6), Width320(12), Height320(12))];
        
        [self.contentView addSubview:_sexImgView];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), MSW-_titleLabel.left-Width320(8), Height320(14))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5),Height320(61), Width320(7.5), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrowImg];
        
        UIImageView *bottomArrow = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(103), MSW, Height320(2))];
        
        bottomArrow.image = [UIImage imageNamed:@"super_admin_back"];
        
        [self.contentView addSubview:bottomArrow];
        
    }
    
    return self;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _titleLabel.text = _name;
    
    [_titleLabel autoWidth];
    
    [_sexImgView changeLeft:_titleLabel.right+Width320(4)];
    
}

-(void)setSex:(SexType)sex
{
    
    _sex = sex;
    
    if (_sex == SexTypeMan) {
        
        _sexImgView.image = [UIImage imageNamed:@"sex_male"];
        
    }else
    {
        
        _sexImgView.image = [UIImage imageNamed:@"sex_female"];
        
    }
    
    if (!_iconURL.absoluteString.length) {
        
        _imgView.image = [UIImage imageNamed:_sex == SexTypeMan?@"img_default_staff_male":@"img_default_staff_female"];
        
    }
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"手机：%@",_phone.length?_phone:@""];
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    if (_iconURL.absoluteString.length) {
        
        [_imgView sd_setImageWithURL:_iconURL];
        
    }else{
        
        _imgView.image = [UIImage imageNamed:_sex == SexTypeMan?@"img_default_staff_male":@"img_default_staff_female"];
        
    }
    
}

@end
