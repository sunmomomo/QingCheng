
//
//  YFSignUpGroupCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupCModel.h"

#import "YFSignUpListGroupDetailVC.h"

#import "YFSignUpListGroupVC.h"

@implementation YFSignUpGroupCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0,15, 0, 0);
    }
    return self;
}

- (NSString *)des
{
    return self.name;
}

- (NSString *)desValue
{
    return [NSString stringWithFormat:@"%@%@人",self.username,self.count];
}

#pragma mark Data
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"gr_Id":@"id"
             };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YFSignUpListGroupVC *groupVC = (YFSignUpListGroupVC *)self.weakCell.currentVC;
    
    YFSignUpListGroupDetailVC *groupDetailVC = [[YFSignUpListGroupDetailVC alloc] init];
    
    groupDetailVC.title = self.des;
    
    groupDetailVC.gym_id = groupVC.gym_id;
    
    groupDetailVC.teams_id = self.gr_Id;
    
    groupDetailVC.comeptition_id = groupVC.competition_id;
    
    [self.weakCell.currentVC.navigationController pushViewController:groupDetailVC animated:YES];
}

@end
