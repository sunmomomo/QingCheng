//
//  YFStudentFilterStateModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterStateModel.h"

static NSString *yFStudentFilterStateCell = @"YFStudentFilterStateCell";

@interface YFStudentFilterStateModel()

@property(nonatomic, strong)UIButton *selectButton;

@end

@implementation YFStudentFilterStateModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterStateCell;
        self.cellClass = [YFStudentFilterStateCell class];
        self.cellHeight = XFrom6YF(120.0);
        
    }
    return self;
}

-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)baseCell;
    
    [cell.nRegisterButton addTarget:self action:@selector(registerCondiAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.followIngButton addTarget:self action:@selector(followingCondiAction:) forControlEvents:UIControlEventTouchUpInside];

    [cell.memberButton addTarget:self action:@selector(memCondiCondiAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}


-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)baseCell;
    cell.nRegisterButton.selected = self.isNewReg;
    cell.followIngButton.selected = self.isFollowing;
    cell.memberButton.selected = self.isMember;
    
    
    
    
    [self setButtonStateSetting:cell.nRegisterButton];
    [self setButtonStateSetting:cell.followIngButton];
    [self setButtonStateSetting:cell.memberButton];
}

- (void)registerCondiAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)self.weakCell;
    cell.followIngButton.selected = NO;
    cell.memberButton.selected = NO;

    
    self.selectButton = button;
    
    [self checkState];
}
- (void)followingCondiAction:(UIButton *)button
{
    button.selected = !button.selected;

    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)self.weakCell;
    cell.nRegisterButton.selected = NO;
    cell.memberButton.selected = NO;
    
    self.selectButton = button;

    [self checkState];
}
- (void)memCondiCondiAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)self.weakCell;
    cell.followIngButton.selected = NO;
    cell.nRegisterButton.selected = NO;
    
    self.selectButton = button;
    
    [self checkState];
}

- (void)checkState
{
    YFStudentFilterStateCell *cell = (YFStudentFilterStateCell *)self.weakCell;

    self.isMember = cell.memberButton.selected;
    self.isNewReg = cell.nRegisterButton.selected;
    self.isFollowing = cell.followIngButton.selected;

    [self setButtonStateSetting:cell.nRegisterButton];
    [self setButtonStateSetting:cell.followIngButton];
    [self setButtonStateSetting:cell.memberButton];
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

-(NSString *)statusString
{
    NSMutableString *string = [NSMutableString string];
    
    if (self.isNewReg)
    {
        [string appendString:YFIsNewRe];
        [string appendString:@","];

    }
    
    if (self.isFollowing)
    {
        [string appendString:YFIsFollowing];
        [string appendString:@","];
    }
    
    if (self.isMember)
    {
        [string appendString:YFIsMember];
    }
    return string;
}

- (void)setSelectButton:(UIButton *)selectButton
{
    _selectButton = selectButton;
}



@end
