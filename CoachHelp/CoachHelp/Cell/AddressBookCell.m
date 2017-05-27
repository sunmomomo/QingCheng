//
//  AddressBookCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/29.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AddressBookCell.h"

@interface AddressBookCell ()

{
    
    UIImageView *_selectImgView;
    
    UIImageView *_icon;
    
    UILabel *_nameLabel;
    
    UILabel *_phoneLabel;
    
}

@end

@implementation AddressBookCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _selectImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(29.3), Height320(30.2), Width320(14.2), Height320(14.2))];
        
        _selectImgView.layer.cornerRadius = _selectImgView.width/2;
        
        _selectImgView.layer.masksToBounds = YES;
        
        _selectImgView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        [self.contentView addSubview:_selectImgView];
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(56.9), Height320(14.2), Width320(40), Height320(40))];
        
        _icon.layer.cornerRadius = _icon.width/2;
        
        _icon.layer.masksToBounds = YES;
        
        _icon.image = [UIImage imageNamed:@"iconplaceholder"];
        
        [self.contentView addSubview:_icon];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(110), Height320(16), Width320(200), Height320(15))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.font = AllFont(12);
        
        [self.contentView addSubview:_nameLabel];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(4), _nameLabel.width, _nameLabel.height)];
        
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        
        _phoneLabel.font = AllFont(11);
        
        [self.contentView addSubview:_phoneLabel];
        
    }
    
    return self;
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _phoneLabel.text = [NSString stringWithFormat:@"手机：%@",_phone.length?_phone:@""];
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
}

-(void)setSelect:(BOOL)select
{
    
    _select = select;
    
    if (_select) {
        
        _selectImgView.image = [UIImage imageNamed:@"selected"];
        
        _selectImgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _selectImgView.layer.borderWidth = 0;
        
    }else
    {
        
        _selectImgView.image = nil;
        
        _selectImgView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        _selectImgView.layer.borderWidth = 1;
        
    }
    
}

@end
