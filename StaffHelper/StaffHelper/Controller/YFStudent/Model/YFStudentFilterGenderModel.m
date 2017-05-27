//
//  YFStudentFilterGenderModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterGenderModel.h"

#import "YFStudentFilterStateCell.h"

static NSString *yFStudentFilterGenderCell = @"YFStudentFilterGenderCell";


@implementation YFStudentFilterGenderModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterGenderCell;
        self.cellClass = [YFStudentFilterStateCell class];
        self.cellHeight = XFrom6YF(120.0);
        
    }
    return self;
}

-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)baseCell;
    
    [cell.meStateDesLabel changeTop:XFrom6YF(23.0)];
    cell.meStateDesLabel.text = @"性别";
    
    [cell.nRegisterButton changeTop:cell.meStateDesLabel.bottom + 8];
    [cell.followIngButton changeTop:cell.meStateDesLabel.bottom + 8];

    self.cellHeight = cell.followIngButton.bottom + 22.0;
    
    
    [cell.nRegisterButton addTarget:self action:@selector(maleCondiAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nRegisterButton setTitle:@"男" forState:UIControlStateNormal];
    
    [cell.followIngButton addTarget:self action:@selector(femaleCondiAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.followIngButton setTitle:@"女" forState:UIControlStateNormal];

    [cell.memberButton setHidden:YES];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)bindCell:(YFStudentFilterStateCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if (self.gender.length)
    {
        if (self.gender.integerValue == 0)
        {
            baseCell.nRegisterButton.selected = YES;
        }else
        {
            baseCell.followIngButton.selected = YES;
        }
    }else
    {
        baseCell.nRegisterButton.selected = NO;
        baseCell.followIngButton.selected = NO;
    }
    [self setButtonStateSetting:baseCell.nRegisterButton];
    [self setButtonStateSetting:baseCell.followIngButton];

}

- (void)maleCondiAction:(UIButton *)button
{
    button.selected = !button.selected;
    self.gender = @"0";
    [self setButtonStateSetting:button];
    
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)self.weakCell;
    cell.followIngButton.selected = NO;
    [self setButtonStateSetting:cell.followIngButton];

}
- (void)femaleCondiAction:(UIButton *)button
{
    button.selected = !button.selected;
    [self setButtonStateSetting:button];
    self.gender = @"1";
    
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)self.weakCell;
    cell.nRegisterButton.selected = NO;
    [self setButtonStateSetting:cell.nRegisterButton];

}


- (void)setButtonStateSetting:(UIButton *)button
{
    if (button.selected)
    {
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = YFSelectedButtonColor.CGColor;
        button.layer.borderWidth = 1.0;
    }else
    {
        button.backgroundColor = YFCellButtonBaColor;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.layer.borderWidth = 0.0;
    }
}


@end
