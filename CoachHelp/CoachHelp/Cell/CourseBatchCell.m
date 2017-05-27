//
//  CourseBatchCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseBatchCell.h"

@interface CourseBatchCell ()

{
    
    UILabel *_titleLabel;
    
    UIButton *_editButton;
    
}

@end

@implementation CourseBatchCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(260), Height320(42))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(13);
        
        [self.contentView addSubview:_titleLabel];
        
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _editButton.frame = CGRectMake(MSW-Width320(53), 0, Width320(53), Height320(42));
        
        [_editButton addTarget:self.delegate action:@selector(cellEditClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_editButton];
        
        UIImageView *editImage = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(21), Height320(15))];
        
        editImage.image = [UIImage imageNamed:@"cellmore"];
        
        [_editButton addSubview:editImage];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    _editButton.tag = tag;
    
}

@end
