//
//  StaffCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StaffCell.h"

@interface StaffCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_positionLabel;
    
    UIImageView *_sexImgView;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation StaffCell

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
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(42), Height320(42))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(15), MSW-Width320(32)-_imgView.right, Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        [self.contentView addSubview:_titleLabel];
        
        _sexImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(4), _titleLabel.center.y-Height320(6), Width320(12), Height320(12))];
        
        [self.contentView addSubview:_sexImgView];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), MSW-_titleLabel.left-Width320(8), Height320(14))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _subtitleLabel.bottom+Height320(6), _titleLabel.width, Height320(14))];
        
        _positionLabel.font = AllFont(12);
        
        _positionLabel.textColor = UIColorFromRGB(0x999999);
        
        [self.contentView addSubview:_positionLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5),Height320(34), Width320(7.5), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrowImg];
        
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

-(void)setPosition:(NSString *)position
{
    
    _position = position;
    
    _positionLabel.text = _position;
//    
//    _positionLabel.textColor = [_position isEqualToString:@"管理员"]?UIColorFromRGB(0xF9944E):UIColorFromRGB(0x999999);
//    
}

@end
