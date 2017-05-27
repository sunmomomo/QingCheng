//
//  ChooseYardCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChooseYardCell.h"

@interface ChooseYardCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_chooseImg;
    
    UIView *_chooseBack;
    
    UIImageView *_checkImg;
    
}

@end

@implementation ChooseYardCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(20), MSW-Width320(32), Height320(17))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(8), MSW-_titleLabel.left-Width320(8), Height320(16))];
        
        _subtitleLabel.font = AllFont(13);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _chooseBack = [[UIView alloc]initWithFrame:CGRectMake(MSW-Width320(30), Height320(30), Width320(14), Height320(14))];
        
        _chooseBack.layer.cornerRadius = _chooseBack.width/2;
        
        _chooseBack.layer.masksToBounds = YES;
        
        _chooseBack.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _chooseBack.layer.borderWidth = 1;
        
        _chooseBack.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        [self.contentView addSubview:_chooseBack];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(30), Height320(30), Width320(14), Height320(14))];
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
        _chooseImg.image = [UIImage imageNamed:@"selected"];
        
        [self.contentView addSubview:_chooseImg];
        
        _checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(36), Height320(27), Width320(20), Height320(20))];
        
        _checkImg.image = [UIImage imageNamed:@"main_choose"];
        
        _checkImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_checkImg];
        
        _checkImg.hidden = YES;
        
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

-(void)setCourseType:(CourseType)courseType
{
    
    _courseType = courseType;
    
    if (_courseType == CourseTypeGroup) {
        
        _chooseImg.hidden = YES;
        
        _chooseBack.hidden = YES;
        
    }else{
        
        _checkImg.hidden = YES;
        
    }
    
}

-(void)setSelect:(BOOL)select
{
    
    _select = select;
    
    if (_select) {
        
        if (_courseType == CourseTypeGroup) {
            
            _checkImg.hidden = NO;
            
        }else{
            
            _chooseImg.hidden = NO;
            
            _chooseBack.hidden = YES;
            
        }
        
    }else
    {
        
        if (_courseType == CourseTypeGroup) {
            
            _checkImg.hidden = YES;
            
        }else{
            
            _chooseImg.hidden = YES;
            
            _chooseBack.hidden = NO;
            
        }
        
    }
    
}


@end
