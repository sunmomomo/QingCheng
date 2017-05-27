//
//  ChestAreaCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestAreaCell.h"

@interface ChestAreaCell ()

{
    
    UILabel *_titleLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation ChestAreaCell

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
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(250), Height320(40))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(29), Height320(11), Width320(20), Height320(20))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
        _chooseImg.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_chooseImg];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(40)-OnePX, MSW-Width320(32), OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:line];
        
    }
    
    return self;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _titleLabel.text = _name;
    
}

@end
