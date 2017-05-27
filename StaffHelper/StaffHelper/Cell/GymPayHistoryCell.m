//
//  GymPayHistoryCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymPayHistoryCell.h"

@interface GymPayHistoryCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_validLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_summaryLabel;
    
    UILabel *_stateLabel;
    
}

@end

@implementation GymPayHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(112))];
        
        backView.backgroundColor = UIColorFromRGB(0xffffff);
        
        backView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        backView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:backView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(160), Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllBFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _validLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _titleLabel.bottom+Height320(6), MSW-Width320(24), Height320(15))];
        
        _validLabel.textColor = UIColorFromRGB(0x333333);
        
        _validLabel.font = AllFont(12);
        
        [self.contentView addSubview:_validLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_validLabel.left, _validLabel.bottom+Height320(2), _validLabel.width, _validLabel.height)];
        
        _priceLabel.textColor = UIColorFromRGB(0x333333);
        
        _priceLabel.font = AllFont(12);
        
        [self.contentView addSubview:_priceLabel];
        
        _summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _priceLabel.bottom+Height320(12), MSW-Width320(24), Height320(15))];
        
        _summaryLabel.textColor = UIColorFromRGB(0x999999);
        
        _summaryLabel.font = AllFont(12);
        
        [self.contentView addSubview:_summaryLabel];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(48), Height320(15), Width320(48), Height320(15))];
        
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        
        _stateLabel.font = AllFont(12);
        
        [self.contentView addSubview:_stateLabel];
        
    }
    
    return self;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _titleLabel.text = _time;
    
}

-(void)setValid:(NSString *)valid
{
    
    _valid = valid;
    
    _validLabel.text = _valid;
    
}

-(void)setPrice:(NSString *)price
{
    
    _price = price;
    
    _priceLabel.text = _price;
    
}

-(void)setSummary:(NSString *)summary
{
    
    _summary = summary;
    
    _summaryLabel.text = _summary;
    
}

-(void)setSuccess:(BOOL)success
{
    
    _success = success;
    
    _stateLabel.text = _success?@"成功":@"失败";
    
    _stateLabel.textColor = _success?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0xEA6161);
    
}

@end
