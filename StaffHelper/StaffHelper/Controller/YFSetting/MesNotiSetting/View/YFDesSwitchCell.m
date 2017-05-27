//
//  YFDesSwitchCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDesSwitchCell.h"

@implementation YFDesSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.switchOfCell];
        
    }
    return self;
}


- (UILabel *)desLabel
{
    if (!_desLabel)
    {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 0, self.switchOfCell.right - 24, Height320(40))];
        
        _desLabel.textColor = RGBCOLOR(51, 51, 51);
        
        _desLabel.font = FontScale320SizeFY(14);
    }
    return _desLabel;
}

- (UISwitch *)switchOfCell
{
    if (!_switchOfCell)
    {
        _switchOfCell = [[UISwitch alloc]initWithFrame:CGRectMake(MSW-Width320(39) - 22, Height320(40)/2-Height320(12), Width320(39), Height320(24))];
        
        _switchOfCell.transform = CGAffineTransformMakeScale(MSW/414, MSW/414);
        
        _switchOfCell.center = CGPointMake(_switchOfCell.center.x, Height320(40)/2);
        
        _switchOfCell.onTintColor = kMainColor;
        
        [_switchOfCell addTarget:self action:@selector(valueChangeFY:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchOfCell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _switchOfCell.frame = CGRectMake(MSW-Width320(39) - 22, XFromWidthYF(self.contentView.height,40,40)/2-XFromWidthYF(self.contentView.height,40, 12), XFromWidthYF(self.contentView.height,40,39), XFromWidthYF(self.contentView.height,40,24));
    
    _desLabel.frame = CGRectMake(19, 0, self.switchOfCell.right - 24, XFromWidthYF(self.contentView.height,40, 40));
    
    _desLabel.font = FontSizeFY(XFromWidthYF(self.contentView.height,40, 14));
    
    
}


-(void)valueChangeFY:(id)sender
{
    if (self.changeValueBlock)
    {
        self.changeValueBlock(self.switchOfCell);
    }
}

@end
