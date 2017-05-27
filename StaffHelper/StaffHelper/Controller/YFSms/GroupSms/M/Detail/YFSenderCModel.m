//
//  YFSenderCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSenderCModel.h"

#import "YFSenderCell.h"

static NSString *yFSenderCell = @"YFSenderCell";


@implementation YFSenderCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFSenderCell;
        self.cellClass = [YFSenderCell class];
        self.cellHeight = 68.0;
        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

- (void)bindCell:(YFSenderCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.nameDesLabel.text = @"发件人:";
    baseCell.nameLabel.text = self.name;
    baseCell.phoneLabel.text = self.phone;
    [baseCell.headImageView sd_setImageWithURL:self.avator];
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
