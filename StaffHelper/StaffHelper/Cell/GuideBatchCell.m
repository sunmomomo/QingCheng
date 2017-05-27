//
//  GuideBatchCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideBatchCell.h"

@interface GuideBatchCell ()

{
    
    UIButton *_deleteButton;
    
    UILabel *_timeLabel;
    
    UILabel *_weekLabel;
    
}

@end

@implementation GuideBatchCell

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
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(15), Height320(20), Width320(16), Height320(16))];
        
        [_deleteButton setImage:[UIImage imageNamed:@"cell_delete"] forState:UIControlStateNormal];
        
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_deleteButton];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(44), Height320(11), MSW-Width320(60), Height320(16))];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(14);
        
        [self.contentView addSubview:_timeLabel];
        
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, _timeLabel.bottom+Height320(4), _timeLabel.width, _timeLabel.height)];
        
        _weekLabel.textColor = UIColorFromRGB(0x666666);
        
        _weekLabel.font = AllFont(14);
        
        [self.contentView addSubview:_weekLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(56)-OnePX, MSW-Width320(32), OnePX)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:sep];
        
    }
    
    return self;
    
}

-(void)deleteClick:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(batchCellDelete:)]) {
        
        [self.delegate batchCellDelete:self];
        
    }
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setWeeks:(NSString *)weeks
{
    
    _weeks = weeks;
    
    _weekLabel.text = weeks;
    
}

@end
