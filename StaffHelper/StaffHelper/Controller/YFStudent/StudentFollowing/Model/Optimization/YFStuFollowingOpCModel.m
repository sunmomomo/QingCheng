//
//  YFStuFollowingOpCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuFollowingOpCModel.h"

#import "YFStuFollowingOpCell.h"

#import "YFStudentFollowingVC.h"

#import "YFModuleManager.h"

static NSString *yFStuFollowingOpCell = @"YFStuFollowingOpCell";


@implementation YFStuFollowingOpCModel



- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStuFollowingOpCell;
        self.cellClass = [YFStuFollowingOpCell class];
        self.cellHeight = Width320(259);
        
    }
    return self;
}


- (void)bindCell:(YFStuFollowingOpCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if ([baseCell.chartView.staticModel isEqual:self.staticModel] == YES) {
        return;
    }
    baseCell.nameLabel.text = self.typeTitle;
    baseCell.chartView.defaultColor = self.defaultColor;
    baseCell.chartView.staticModel = self.staticModel;
    
    baseCell.todayCountLabel.text = [self.staticModel.today_count guardStringYF];
    baseCell.sevenCountLabel.text = [self.staticModel.week_count guardStringYF];
    baseCell.thirtyCountLabel.text = [self.staticModel.month_count guardStringYF];
    
//#warning !!!!!
//    baseCell.todayCountLabel.text = @"222";
//    baseCell.sevenCountLabel.text = @"222";
//    baseCell.thirtyCountLabel.text = @"222";
    
    
    self.cellHeight = baseCell.chartView.bottom + Width320(34);
    
    DebugLogParamYF(@"---- *** --%f",self.cellHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YFStudentFollowingVC *followVC = (YFStudentFollowingVC *)self.weakCell.currentVC;
    
    weakTypesYF
    [YFModuleManager studentNewMemberWithGym:followVC.gym tag:indexPath.section + 1 viewController:^(UIViewController *toVC) {
        [weakS.weakCell.currentVC.navigationController pushViewController:toVC animated:YES];
    }];
}

@end
