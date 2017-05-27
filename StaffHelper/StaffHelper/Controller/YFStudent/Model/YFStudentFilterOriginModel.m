//
//  YFStudentFilterOriginModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterOriginModel.h"
#import "YFStudentFilterOriginCell.h"

#import "YFStudentListRightVC.h"

#import "YFStudnetOriginVC.h"
#import "YFStudentFilterStateCell.h"

static NSString *yFStudentFilterOriginCell = @"YFStudentFilterOriginCell";

@implementation YFStudentFilterOriginModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterOriginCell;
        self.cellClass = [YFStudentFilterOriginCell class];
        self.cellHeight = 39.0;
        self.edgeInsets = UIEdgeInsetsMake(0, 33.0, 0, 0);

        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.o_id = value;
    }else
        [super setValue:value forKey:key];
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([object isKindOfClass:[YFStudentListRightVC class]] == NO)
    {
        YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)baseCell;
        cell.arrowImageView.frame = CGRectMake(MSW - XFrom6YF(14.0) - 12, 15.0, 12, 9);
        cell.nameLabel.frame = CGRectMake(18, 0.0, cell.arrowImageView.left - 5 - 18, 39.0);

    }
    

    
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    NSString *nameStr = self.name;
    
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)baseCell;
    
    cell.nameLabel.text = nameStr;
    
    [self setSelectState];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
   
    
    if ([viewC isKindOfClass:[YFStudnetOriginVC class]]) {
        self.isSelected = YES;
        [self setSelectState];
        
        YFStudnetOriginVC *rightVC = (YFStudnetOriginVC *)self.weakCell.currentVC;
        [rightVC setSelectModel:self];
        
    }else
    {
        self.isSelected = !self.isSelected;
        [self setSelectState];
        YFStudentListRightVC *rightVC = (YFStudentListRightVC *)self.weakCell.currentVC;
        
        if (self.isSelected)
        {
            /// 单选加上的
            [rightVC.allOrigDic removeAllObjects];

            [rightVC.allOrigDic setObject:self forKey:self.o_id];
            // 保证是单选，如果把这个判断去掉 就是多选
            if (rightVC.selectModel && rightVC.selectModel.o_id.integerValue != self.o_id.integerValue)
            {
                rightVC.selectModel.isSelected = NO;
                
                [rightVC.baseTableView reloadData];
            }
            rightVC.selectModel = self;
        }else
        {
            [rightVC.allOrigDic removeObjectForKey:self.o_id];
        }
    }
}


- (void)setSelectState
{
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)self.weakCell;
    
    
    if (!self.isSelected)
    {
        cell.arrowImageView.hidden = YES;
        cell.nameLabel.textColor = YFCellTitleColor;
    }else
    {
        cell.arrowImageView.hidden = NO;
        cell.nameLabel.textColor = YFSelectedButtonColor;
    }
}

@end
