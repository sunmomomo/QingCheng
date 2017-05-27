//
//  YFTransPersentModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTransPersentModel.h"

#import "YFTransPersentCell.h"
#import "NSObject+RuntimeYF.h"

static NSString *yFTransPersentCell = @"YFTransPersentCell";


@implementation YFTransPersentModel


- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.dayCount = 7;
        self.cellIdentifier = yFTransPersentCell;
        self.cellClass = [YFTransPersentCell class];
        self.cellHeight = XFrom6YF(327.0f - 74) + 74;
        
        self.create_count = [self.create_count guardStringYF];
        self.following_count = [self.following_count guardStringYF];
        self.member_count = [self.member_count guardStringYF];
        
     
        self.neRegisNum = self.create_count.integerValue;
        self.neFollow = self.following_count.integerValue;
        self.neMem = self.member_count.integerValue;
        
    }
    return self;
}

-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;

}


- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    CGFloat regisNum = self.neRegisNum;
    CGFloat foloowNum = self.neFollow;
    CGFloat memNum = self.neMem;
    
    YFTransPersentCell *cell = (YFTransPersentCell *)baseCell;
    
    if (self.isTwoLevel)
    {
        [cell setTwoLevel];
        
        self.cellHeight = cell.headImageView.bottom + (cell.headImageView.top - cell.lineTwoLevelView.bottom);
    }

    
    cell.nameLabel.text = [NSString stringWithFormat:@"注册日期为%@至%@的会员转化率",self.start,self.end];
    
    NSString *str1 = (regisNum == 0 ? @"0%":[NSString stringWithFormat:@"%0.f%@",foloowNum * 100 / regisNum,@"%"]);
    NSString *str2 = (foloowNum == 0? @"0%":[NSString stringWithFormat:@"%0.f%@",memNum * 100 / foloowNum,@"%"]);
    NSString *str3 = (regisNum == 0? @"0%":[NSString stringWithFormat:@"%0.f%@",memNum * 100 / regisNum,@"%"]);
    
    
    
    cell.persertFirstLabel.text = str1;
    cell.persertSecondLabel.text = str2;
    cell.persertThirdLabel.text = str3;

    cell.persertFirstCountLabel.text = [NSString stringWithFormat:@"注册%@人",@(self.neRegisNum)];
    cell.persertSecondCountLabel.text = [NSString stringWithFormat:@"接洽%@人",@(self.neFollow)];
    cell.persertThirdCountLabel.text = [NSString stringWithFormat:@"会员%@人",@(self.neMem)];
}



@end
