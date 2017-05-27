//
//  CoachCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoachCell.h"

@interface CoachCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_sexImgView;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation CoachCell


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
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(20), MSW-Width320(32)-_imgView.right, Height320(17))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        [self.contentView addSubview:_titleLabel];
        
        _sexImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(4), _titleLabel.center.y-Height320(6), Width320(12), Height320(12))];
        
        [self.contentView addSubview:_sexImgView];
        
        _sexImgView.hidden = YES;
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(8), MSW-_titleLabel.left-Width320(8), Height320(16))];
        
        _subtitleLabel.font = AllFont(13);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_subtitleLabel];
        
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
    
    [_sexImgView changeLeft:_titleLabel.right+Width320(4)];
    
}

-(void)setSex:(SexType)sex
{
    
    _sex = sex;
    
    _sexImgView.hidden = NO;
    
    if (_sex == SexTypeMan) {
        
        _sexImgView.image = [UIImage imageNamed:@"sex_male"];
        
    }else
    {
        
        _sexImgView.image = [UIImage imageNamed:@"sex_female"];
        
    }
    
    if (!_imgUrl.absoluteString.length) {
        
        _imgView.image = [UIImage imageNamed:_sex == SexTypeMan?@"img_default_teacher_male":@"img_default_teacher_female"];
        
    }
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"手机：%@",_phone.length?_phone:@""];
    
}

-(void)setSelect:(BOOL)select
{
    
    _select = select;
    
    if (_select) {
        
        _titleLabel.textColor = _subtitleLabel.textColor = kMainColor;
        
        _chooseImg.hidden = NO;
        
    }else
    {
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
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
        _imgView.image = [UIImage imageNamed:_sex == SexTypeMan?@"img_default_teacher_male":@"img_default_teacher_female"];
    }
    
}

@end
