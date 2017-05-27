//
//  YFStudentFilterOriginCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterOriginCell.h"
#import "YFAppConfig.h"

@implementation YFStudentFilterOriginCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (void)fitHeight:(CGFloat)height
{
    self.nameLabel.frame = CGRectMake(16, 0.0, self.arrowImageView.left - 5 - 16, height);
    self.arrowImageView.frame = CGRectMake(MSW - XFrom6YF(14.0) - 12, (height - 9) / 2.0, 12, 9);
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(33.0, 0.0, self.arrowImageView.left - 5 - 33, 39.0)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(14.0);
    }
    return _nameLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW * StudentRightShowScale - XFrom6YF(14.0) - 12, 15.0, 12, 9)];
        _arrowImageView.image = [UIImage imageNamed:@"FillSelected"];
    }
    return _arrowImageView;
}

@end
