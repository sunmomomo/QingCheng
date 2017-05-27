//
//  YFSignUpListAddGroupCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListAddGroupCModel.h"

#import "YFSignUpListAddGroupCell.h"

#import "YFTBSectionsModel.h"

#import "YFGrayCellModel.h"

#import "YFSignUpGroupCModel.h"

#import "YFSignUpListAddGroupVC.h"

#import "YFCompetitionModule.h"

#import "UIView+lineViewYF.h"

static NSString *yFSignUpListAddGroupCell = @"YFSignUpListAddGroupCell";

@implementation YFSignUpListAddGroupCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFSignUpListAddGroupCell;
        self.cellClass = [YFSignUpListAddGroupCell class];
        self.cellHeight = 50;

        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell.contentView addLinewViewWithFrame:CGRectMake(0, 0, MSW, OnePX)];
}

- (void)bindCell:(YFSignUpListAddGroupCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if (self.name) {
        baseCell.nameLabel.text = self.name;
    }
}

+ (NSMutableArray *)creatTestArray
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    YFTBSectionsModel *sectionsModel1 = [[YFTBSectionsModel alloc] init];
    [dataArray addObject:sectionsModel1];
    
    YFTBSectionsModel *sectionsModel2 = [[YFTBSectionsModel alloc] init];
    [dataArray addObject:sectionsModel2];
    
    YFSignUpListAddGroupCModel *addGroupModel = [YFSignUpListAddGroupCModel defaultWithYYModelDic:nil];
    
    [sectionsModel1.dataArray addObject:addGroupModel];
    [sectionsModel1.dataArray addObject:[YFGrayCellModel defaultWithCellHeght:12.0]];

//    NSArray *array = @[@"2",@"1",@"1",@"1",@"1",@"1",@"1"];
    
//    for (NSString * in array) {
//        
//        YFSignUpGroupCModel *grMOdel = [YFSignUpGroupCModel defaultWithYYModelDic:nil];
//        
//        grMOdel.des = @"青橙小分队";
//        grMOdel.desValue = @"陈驰远10人";
//        
//        [sectionsModel2.dataArray addObject:grMOdel];
//    }
    
    
    return dataArray;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectBlock)
    {
        self.selectBlock(self);
        return;
    }
    
}


@end
