//
//  QCSwitchCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QCSwitchCell.h"

@implementation QCSwitchCell

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
        
        self.aswitch = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(44))];
        
        [self.contentView addSubview:self.aswitch];
        
    }
    
    return self;
    
}

@end
