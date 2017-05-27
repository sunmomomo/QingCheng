//
//  YardCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YardCell.h"

@interface YardCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation YardCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(15), MSW-Width320(32), Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), MSW-_titleLabel.left-Width320(8), Height320(14))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(27), Width320(7.5), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"gray_arrow"];

        [self.contentView addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setYardName:(NSString *)yardName
{
    
    _yardName = yardName;
    
    _titleLabel.text = _yardName;
    
}

-(void)setYardCapacity:(NSInteger)yardCapacity
{
    
    _yardCapacity = yardCapacity;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"可容纳%ld人，用于%@",(long)_yardCapacity,_yardType == YardTypeGroup?@"团课":_yardType == YardTypePrivate?@"私教课":@"私教课、团课"];
    
}

-(void)setYardType:(YardType)yardType
{
    
    _yardType = yardType;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"可容纳%ld人，用于%@",(long)_yardCapacity,_yardType == YardTypeGroup?@"团课":_yardType == YardTypePrivate?@"私教课":@"私教课、团课"];
    
}


@end
