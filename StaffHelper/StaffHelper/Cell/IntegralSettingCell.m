//
//  IntegralSettingCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "IntegralSettingCell.h"

@interface IntegralSettingCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_contentLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation IntegralSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), Height320(15), MSW-Width320(36), Height320(20))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), _titleLabel.bottom+Height320(10),Width320(270), Height320(100))];
        
        _contentLabel.textColor = UIColorFromRGB(0x999999);
        
        _contentLabel.font = AllFont(12);
        
        _contentLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_contentLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(48), Width320(7), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setContent:(NSString *)content
{
    
    _content = content;
    
    _contentLabel.text = _content;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:Height320(2)];
    
    CGSize size = [_content boundingRectWithSize:CGSizeMake(Width320(270), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
    [_contentLabel changeHeight:size.height];
    
    [_arrowImg changeTop:(_contentLabel.height+Height320(58))/2-Height320(6)];
    
}

-(void)setIsActive:(BOOL)isActive
{
    
    _isActive = isActive;
    
    _arrowImg.hidden = !_isActive;
    
    _titleLabel.textColor = _isActive?UIColorFromRGB(0x333333):UIColorFromRGB(0x999999);
    
    self.userInteractionEnabled = _isActive;
    
}

@end
