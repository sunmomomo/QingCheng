//
//  YFStudentTodayModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentTodayModel.h"
#import "YFStudentTodayCell.h"
#import "YFStudentStateDetailVC.h"
#import "YFConditionSellerPopView.h"
#import "YFConditionOriginPopView.h"
#import "YFConditionRecommPopView.h"
#import "YFStudentFollowingVC.h"
#import "YFHttpService.h"
#import "YFModuleManager.h"

static NSString *yFStudentTodayCell = @"YFStudentTodayCell";

@implementation YFStudentTodayModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentTodayCell;
        self.cellClass = [YFStudentTodayCell class];
        self.cellHeight = XFrom6YF(157.0);
        
        weakTypesYF
        [self setButtonActionBlock:^(NSUInteger tag) {
            [weakS setButtonAction:tag];
        }];
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentTodayCell *cell = (YFStudentTodayCell *)baseCell;

    
    cell.nameLabel.text = @"今日";
//    cell.neRegisLabel.text = @"88";
//    cell.todayFollowLabel.text = @"188";
//    cell.neMemLabel.text = @"288";
    cell.buttonActionBlock = self.buttonActionBlock;
    
    cell.neRegisLabel.text = self.valueNewRegNum;
    cell.todayFollowLabel.text = self.valueFlowwNum;
    cell.neMemLabel.text = self.valueNewMeNum;;
}

- (void)setButtonAction:(NSUInteger )tag
{
    YFStudentFollowingVC *followVC = (YFStudentFollowingVC *)self.weakCell.currentVC;

    
    weakTypesYF
    [YFModuleManager studentNewMemberWithGym:followVC.gym tag:tag viewController:^(UIViewController *toVC) {
        [weakS.weakCell.currentVC.navigationController pushViewController:toVC animated:YES];

    }];
    
    return;
}

@end
