//
//  YFStudentFollowingModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFollowingModel.h"
#import "YFStudentFollowingCell.h"
#import "YFStudentStateDetailVC.h"
#import "YFStudentFollowingVC.h"
#import "YFConditionSellerPopView.h"
#import "YFConditionOriginPopView.h"
#import "YFConditionRecommPopView.h"
#import "YFConditionTimePopView.h"
#import "YFHttpService.h"

#import "YFConditionGenderPopView.h"

#import "YFSellerFiterViewModel.h"

#import "NSObject+firterModel.h"

static NSString *yFStudentFollowingCell = @"YFStudentFollowingCell";

@implementation YFStudentFollowingModel


- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFollowingCell;
        self.cellClass = [YFStudentFollowingCell class];
        self.cellHeight = 56.0;
        
        self.edgeInsets = UIEdgeInsetsMake(0, 18.0, 0.0, 0.0);
        
    }
    return self;
}



-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentFollowingCell *cell = (YFStudentFollowingCell *)baseCell;
    

    NSUInteger state = self.status.integerValue;
    cell.valueLabel.text = [NSString stringWithFormat:@"%@人",self.valueNum];
    
    
    if (state == YFIsNewRe.integerValue)
    {
        cell.nameLabel.text = @"新注册";
        cell.stateImageView.image = [UIImage imageNamed:@"OvalNew"];
        
    }else if (state == YFIsFollowing.integerValue){
        cell.nameLabel.text = @"已接洽";
        

        cell.stateImageView.image = [UIImage imageNamed:@"Ovaling"];

    }else if (state == YFIsMember.integerValue){
        cell.nameLabel.text = @"会员";
        cell.stateImageView.image = [UIImage imageNamed:@"OvalMe"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YFStudentFollowingVC *followVC = (YFStudentFollowingVC *)viewC;
   

    YFStudentStateDetailVC *stateVC = [[YFStudentStateDetailVC alloc] init];
    
    stateVC.gym = followVC.gym;
    
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

    NSUInteger state = self.status.integerValue;
    if (state == YFIsNewRe.integerValue)
    {
        if (sellerStr.length == 0)
        {
            sellerStr = @"销售";
        }
        stateVC.status = YFIsNewRe;
        stateVC.title = @"新注册";
        stateVC.buttonTitlesArray = @[sellerStr,@"注册日期",@"来源",@"筛选"];
        stateVC.classsArray = @[[YFConditionSellerPopView class],[YFConditionTimePopView class],[YFConditionOriginPopView class]];

        __weak typeof(stateVC)weakStateVC = stateVC;
       UIViewController *fiterVC = [YFSellerFiterViewModel addFilterVCToVC:stateVC gym:followVC.gym sureBlock:^(id model) {
           [weakStateVC refreshTableListDataForFilter];
        }];
        
        
        [stateVC setClickWithIndex:^(NSUInteger index) {
          
            if (index == 3)
            {
                if (weakStateVC.showRightBlockCaYF)
                {
                    weakStateVC.showRightBlockCaYF(nil);
                }
            }
            
        }];
        
        [stateVC.nomalUpImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilter"];
        [stateVC.nomalDownImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilter"];
        [stateVC.selectUpImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilterGreen"];
        [stateVC.selectDownImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilterGreen"];
        
        
        [self.weakCell.currentVC.navigationController pushViewController:fiterVC animated:YES];

        return;
        
    }else if (state == YFIsFollowing.integerValue){
        if (sellerStr.length == 0)
        {
            sellerStr = @"销售";
        }
       stateVC.status = YFIsFollowing;
        stateVC.title = @"已接洽";
        stateVC.buttonTitlesArray = @[sellerStr,@"性别",@"最新跟进时间"];
        stateVC.classsArray = @[[YFConditionSellerPopView class],[YFConditionGenderPopView class],[YFConditionTimePopView class]];

    }else if (state == YFIsMember.integerValue){
        if (sellerStr.length == 0)
        {
            sellerStr = @"销售";
        }
        stateVC.status = YFIsMember;
        stateVC.title = @"会员";
        stateVC.buttonTitlesArray = @[sellerStr,@"性别"];
        stateVC.classsArray = @[[YFConditionSellerPopView class],[YFConditionGenderPopView class]];
    }

    
    
    [self.weakCell.currentVC.navigationController pushViewController:stateVC animated:YES];
}


@end
