//
//  YFChooseTimeModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFChooseTimeModel.h"
#import "YFStudentChooseTimeVC.h"

#import "YFDateService.h"

static NSString *yFStudentChooseTimeCell = @"YFStudentChooseTimeCell";


@implementation YFChooseTimeModel


- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentChooseTimeCell;
        self.cellClass = [YFStudentChooseTimeCell class];
        self.cellHeight = 43.0;
    }
    return self;
}



- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentChooseTimeCell;
        self.cellClass = [YFStudentChooseTimeCell class];
        self.cellHeight = 46;
    }
    return self;
}

- (void)setScaleHeight
{
    self.cellHeight = Width320(40);
}


-(void)setCell:(YFStudentChooseTimeCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.desColor)
    {
        baseCell.nameLabel.textColor = RGB_YF(153, 153, 153);
    }
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentChooseTimeCell *chooseTimeCell = (YFStudentChooseTimeCell *)baseCell;
    chooseTimeCell.startTimeTF.text = self.timeStr;
    chooseTimeCell.startKV.tag = indexPath.row + 1;
    // 代理 可能 是别的 VC
    chooseTimeCell.startKV.delegate = (YFStudentChooseTimeVC *)self.weakCell.currentVC;
   
    if (self.timeStr.length)
    {
        [chooseTimeCell.startDP setDate:[YFDateService getDateFromDateString:self.timeStr formatString:@"yyyy-MM-dd"]];
    }

    if (self.timeDesStr)
    {
        chooseTimeCell.nameLabel.text = self.timeDesStr;
    }else
    {
        if (indexPath.row == 0)
        {
            chooseTimeCell.nameLabel.text = @"开始日期";
        }else
        {
            chooseTimeCell.nameLabel.text = @"结束日期";
        }
    }
    
    
}

@end
