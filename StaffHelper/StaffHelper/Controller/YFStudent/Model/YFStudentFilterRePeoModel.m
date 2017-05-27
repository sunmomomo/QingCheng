//
//  YFStudentFilterRePeoModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterRePeoModel.h"
#import "YFStudentFilterRePeoCell.h"
#import "YFStudentListRightVC.h"
#import "YFStudentRecommendVC.h"
#import "YFChooseRecoVC.h"
#import "YFStudentFilterStateCell.h"

static NSString *yFStudentFilterRePeoCell = @"YFStudentFilterRePeoCell";


@implementation YFStudentFilterRePeoModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterRePeoCell;
        self.cellClass = [YFStudentFilterRePeoCell class];
        self.cellHeight = 66.0;
        
        self.count = [self.count guardStringYF];
        self.phone = [self.phone guardStringYF];
        self.r_id = [self.r_id guardStringYF];
        
        self.edgeInsets = UIEdgeInsetsMake(0, 86.0, 0, 0);

    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
   
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.r_id = value;
    }else
        [super setValue:value forKey:key];
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    NSString *nameStr = self.username;
    NSUInteger recoCount = self.count.integerValue;
    
    
    YFStudentFilterRePeoCell *cell = (YFStudentFilterRePeoCell *)baseCell;
  
    if (self.isAll)
    {
        cell.nameLabel.hidden = YES;
        cell.phoneLabel.hidden = YES;
        cell.nameReDesLabel.hidden = YES;
        cell.allNameLabel.hidden = NO;
        cell.allNameLabel.text = self.username;
    }else
    {
    
        
        cell.nameLabel.hidden = NO;
        cell.phoneLabel.hidden = NO;
        cell.nameReDesLabel.hidden = NO;
        cell.allNameLabel.hidden = YES;
        cell.nameLabel.text = nameStr;
        CGSize size = YF_MULTILINE_TEXTSIZE(nameStr, cell.nameLabel.font, CGSizeMake(150, cell.nameLabel.height), 0);
        [cell.nameLabel changeWidth:size.width + 1];
        cell.phoneLabel.text = self.phone;
        cell.nameReDesLabel.text = [NSString stringWithFormat:@"已推荐%@人",@(recoCount)];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar]];

    }
    [self setSelectState];
    
    if (self.isAll && self.isSelected)
    {
        [cell.headImageView setImage:[UIImage imageNamed:@"AllSellerSe"]];
    }else if(self.isAll && !self.isSelected)
    {
        [cell.headImageView setImage:[UIImage imageNamed:@"AllSeller"]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
    
    if ([viewC isKindOfClass:[YFStudentRecommendVC class]])
    {
        self.isSelected = YES;
        [self setSelectState];

        YFStudentRecommendVC *rightVC = (YFStudentRecommendVC *)viewC;
        
        [rightVC setSelectModel:self];
    }else if([viewC isKindOfClass:[YFStudentListRightVC class]])
    {
        self.isSelected = !self.isSelected;
        [self setSelectState];

        YFStudentListRightVC *rightVC = (YFStudentListRightVC *)self.weakCell.currentVC;
        
        if (self.isSelected)
        {
            [rightVC.allRecoDic setObject:self forKey:self.r_id];
            
            // 保证是单选，如果把这个判断去掉 就是多选
            if (rightVC.selectReModel && [rightVC.selectReModel isEqual:self] == NO)
            {
                rightVC.selectReModel.isSelected = NO;
                [rightVC.baseTableView reloadData];
                
                [rightVC.allRecoDic removeObjectForKey:rightVC.selectReModel.r_id];
                
            }
            rightVC.selectReModel = self;
        }else
        {
            [rightVC.allRecoDic removeObjectForKey:self.r_id];
        }
    }else if ([viewC isKindOfClass:[YFChooseRecoVC class]]){
        YFChooseRecoVC *rightVC = (YFChooseRecoVC *)viewC;
        
        [rightVC setSelectModel:self];

    }
}

- (void)setIsAll:(BOOL)isAll
{
    _isAll = isAll;
    self.r_id = @"";
    self.username = @"全部";
}

- (void)setSelectState
{
    YFStudentFilterRePeoCell *cell = (YFStudentFilterRePeoCell *)self.weakCell;

    
    if (!self.isSelected)
    {
        cell.nameLabel.textColor = YFCellTitleColor;
        cell.phoneLabel.textColor = YFCellSubTitleColor;
        cell.arrowImageView.hidden = YES;
        cell.allNameLabel.textColor = YFCellTitleColor;
    }else
    {
        cell.arrowImageView.hidden = NO;
        cell.nameLabel.textColor = YFSelectedButtonColor;
        cell.phoneLabel.textColor = YFSelectedButtonColor;
        cell.allNameLabel.textColor = YFSelectedButtonColor;
    }
}
@end
