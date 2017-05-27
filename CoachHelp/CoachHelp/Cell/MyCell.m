//
//  MyCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
}

@end

@implementation MyCell

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
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, Width320(200), Height320(40))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(14), Width320(7), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrow];
        
    }
    
    return self;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _iconView.image = _image;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

@end
