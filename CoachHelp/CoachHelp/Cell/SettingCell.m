//
//  SettingCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_cellArrow;
    
}

@end

@implementation SettingCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(200), Height320(17))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.center = CGPointMake(_titleLabel.center.x, Height320(20));
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(100), 0, Width320(70), Height320(17))];
        
        _subtitleLabel.font = AllFont(13);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subtitleLabel.center = CGPointMake(_subtitleLabel.center.x, Height320(20));
        
        [self.contentView addSubview:_subtitleLabel];
        
        _cellArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), 0, Width320(6), Height320(12))];
        
        _cellArrow.image = [UIImage imageNamed:@"cellarrow"];
        
        _cellArrow.center = CGPointMake(_cellArrow.center.x, Height320(20));
        
        [self.contentView addSubview:_cellArrow];
        
    }
    
    return self;
    
}


-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

@end
