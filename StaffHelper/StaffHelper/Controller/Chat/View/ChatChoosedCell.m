//
//  ChatChoosedCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChoosedCell.h"

@interface ChatChoosedCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_iconView;
    
}

@end

@implementation ChatChoosedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width(51), Height(78))];
        
        [self.contentView addSubview:deleteButton];
        
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width(16), Height(29), Width(20), Height(20))];
        
        deleteImg.image = [UIImage imageNamed:@"btn_delete"];
        
        [deleteButton addSubview:deleteImg];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(51), Height(15), Width(48), Height(48))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        
        _iconView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width(15), Height(18), MSW-Width(30)-_iconView.right, Height(21))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height(3), _titleLabel.width, Height(18))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x888888);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
    }
    
    return self;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _titleLabel.text = _name;
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _subtitleLabel.text = _phone;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

-(void)deleteClick
{
    
    if ([self.delegate respondsToSelector:@selector(deleteWithChatChoosedCell:)]) {
        
        [self.delegate deleteWithChatChoosedCell:self];
        
    }
    
}

@end
