//
//  IntegralBasicSettingCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralBasicSettingCell.h"

@interface IntegralBasicSettingCell ()

{
    
    UILabel *_titleLabel;
    
    UIButton *_deleteButton;
    
    UIView *_line;
    
}

@end

@implementation IntegralBasicSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(10), Height320(20), Width320(28), Height320(28))];
        
        [self.contentView addSubview:_deleteButton];
        
        UIImageView *deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(6), Height320(6), Width320(16), Height320(16))];
        
        deleteImg.image = [UIImage imageNamed:@"cell_delete"];
        
        [_deleteButton addSubview:deleteImg];
        
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_deleteButton.right+Width320(8), Height320(12), Width320(258), Height320(64))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), OnePX)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:_line];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(Width320(258), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [_titleLabel changeHeight:size.height];
    
    [_line changeTop:_titleLabel.bottom+Height320(12)-OnePX];
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    _line.hidden = _noLine;
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    _deleteButton.tag = tag;
    
}

-(void)deleteClick:(UIButton*)button
{
    
    [self.delegate deleteCell:self];
    
}

@end
