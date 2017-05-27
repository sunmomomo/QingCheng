//
//  YFStudentTransDesModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentTransDesModel.h"
#import "YFStudentTodayTrendDesCell.h"
#import "YFStudentStateDetailVC.h"
#import "YFConditionSellerPopView.h"
#import "YFConditionLatestTimePopView.h"
#import "YFHttpService.h"

static NSString *yFStudentTodayTrendDesCell = @"YFStudentTodayTrendDesCell1";


@implementation YFStudentTransDesModel


- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentTodayTrendDesCell;
        self.cellClass = [YFStudentTodayTrendDesCell class];
        self.cellHeight = 56.0;
        
        
        
    }
    return self;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentTodayTrendDesCell *cell = (YFStudentTodayTrendDesCell *)baseCell;
    cell.nameLabel.text = @"最近7天转化率";
    cell.valueLabel.text = @"详细";
    cell.stateImageView.image = [UIImage imageNamed:@"dataTrans"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
    
    NSString *sellerStr;
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone) {
        
        if ([YFHttpService sharedInstance].info.staff.name)
        {
            sellerStr =[YFHttpService sharedInstance].info.staff.name;
        }else
        {
            weakTypesYF
            __weak typeof(viewC)weakViewc = viewC;
            [YFHttpService getUseNameComplete:^{
                [weakS tableView:tableView didSelectRowAtIndexPath:indexPath onVC:weakViewc];
            }];
            return;
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    YFStudentStateDetailVC *stateVC = [[YFStudentStateDetailVC alloc] init];
    
    stateVC.isTransPersent = YES;
    
    stateVC.title = @"转化率计算";
    
    if (sellerStr.length == 0)
    {
        sellerStr = @"销售";
    }

    stateVC.buttonTitlesArray = @[sellerStr,@"最近7天"];
    
    stateVC.classsArray = @[[YFConditionSellerPopView class],[YFConditionLatestTimePopView class]];
    
    [self.weakCell.currentVC.navigationController pushViewController:stateVC animated:YES];
}


@end
