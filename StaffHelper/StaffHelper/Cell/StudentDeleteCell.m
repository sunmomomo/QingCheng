//
//  StudentDeleteCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentDeleteCell.h"

@interface StudentDeleteCell ()

{
    
    UIButton *_deleteButton;
    
    UIImageView *_icon;
    
    UILabel *_nameLabel;
    
    UILabel *_phoneLabel;
    
}

@end

@implementation StudentDeleteCell

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
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(13), Height320(26), Width320(24), Height320(24))];
        
        [self.contentView addSubview:_deleteButton];
        
        UIImageView *deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(4), Height320(4), Width320(16), Height320(16))];
        
        deleteImg.image = [UIImage imageNamed:@"cell_delete"];
        
        [_deleteButton addSubview:deleteImg];
        
        [_deleteButton addTarget:self.delegate action:@selector(studentDelete:) forControlEvents:UIControlEventTouchUpInside];
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(44), Height320(16), Width320(40), Height320(40))];
        
        _icon.layer.cornerRadius = _icon.width/2;
        
        _icon.layer.masksToBounds = YES;
        
        _icon.image = [UIImage imageNamed:@"iconplaceholder"];
        
        [self.contentView addSubview:_icon];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+Width320(13),Height320(16), Width320(200), Height320(15))];
        
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

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    if (_iconURL.absoluteString.length) {
        
        [_icon sd_setImageWithURL:_iconURL];
        
    }
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    _deleteButton.tag = tag;
    
}

@end
