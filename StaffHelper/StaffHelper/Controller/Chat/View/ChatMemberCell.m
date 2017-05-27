//
//  ChatMemberCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatMemberCell.h"

@interface ChatMemberCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    UIButton *_deleteButton;
    
    UIImageView *_deleteImg;
    
}

@end

@implementation ChatMemberCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(5), Height(5), Width(48), Height(48))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _iconView.bottom+Height(5), frame.size.width, Height(17))];
        
        _nameLabel.textColor = UIColorFromRGB(0x888888);
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = AllFont(11);
        
        [self addSubview:_nameLabel];
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-Width(25), 0, Width(25), Height(25))];
        
        [self addSubview:_deleteButton];
        
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width(5), 0, Width(20), Height(20))];
        
        _deleteImg.image = [UIImage imageNamed:@"cell_delete"];
        
        [_deleteButton addSubview:_deleteImg];
        
        _deleteButton.hidden = YES;
        
    }
    
    return self;
    
}

-(void)deleteClick:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(deleteUserWithCell:)]) {
      
        [self.delegate deleteUserWithCell:self];
        
    }
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
}

-(void)setType:(ChatMemberCellType)type
{
    
    _type = type;
    
    switch (_type) {
        case ChatMemberCellTypeAdd:
            
            _iconView.image = [UIImage imageNamed:@"chat_member_add"];
            
            _nameLabel.text = nil;
            
            break;
        case ChatMemberCellTypeSub:
            
            _iconView.image = [UIImage imageNamed:@"chat_member_sub"];
            
            _nameLabel.text = nil;
            
            break;
            
        case ChatMemberCellTypeNormal:
            
            if (_iconURL.absoluteString.length) {
                
                [_iconView sd_setImageWithURL:_iconURL placeholderImage:[UIImage imageNamed:@"chat_user_empty"]];
                
            }else{
                
                _iconView.image = [UIImage imageNamed:@"chat_user_empty"];
                
            }
            
            _nameLabel.text = _name;
            
            break;
            
        default:
            
            if (_iconURL.absoluteString.length) {
                
                [_iconView sd_setImageWithURL:_iconURL placeholderImage:[UIImage imageNamed:@"chat_user_empty"]];
                
            }else{
                
                _iconView.image = [UIImage imageNamed:@"chat_user_empty"];
                
            }
            
            _nameLabel.text = _name;
            
            break;
    }
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    if (_iconURL.absoluteString.length) {
        
        [_iconView sd_setImageWithURL:_iconURL placeholderImage:[UIImage imageNamed:@"chat_user_empty"]];
        
    }else{
        
        _iconView.image = [UIImage imageNamed:@"chat_user_empty"];
        
    }
    
}

-(void)setEditing:(BOOL)editing
{
    
    _editing = editing;
    
    _deleteButton.hidden = !_editing;
    
    if (!_deleteButton.hidden) {
        
        [self bringSubviewToFront:_deleteButton];
        
    }
    
}

@end
