//
//  YFCardDetailCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardDetailCModel.h"

#import "YFCardDetailCell.h"

static NSString *yFCardDetailCell = @"YFCardDetailCell";


@implementation YFCardDetailCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFCardDetailCell;
        self.cellClass = [YFCardDetailCell class];
        self.cellHeight = Height320(72);
        self.isShowArrow = YES;
        self.numLinesOfdesLabel = 1;
    }
    return self;
}

+ (instancetype)defaultWithYYModelDic:(NSDictionary *)dic selectBlock:(void(^)(id))selectBlock
{
    YFCardDetailCModel *model =  [super defaultWithYYModelDic:dic];
    
    model.selectBlock = selectBlock;
    
    return model;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{

}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFCardDetailCell *cell = (YFCardDetailCell *)self.weakCell;

    cell.nameLabel.text = self.name;
    cell.desLabel.text = self.des;
    cell.headImageView.image = [UIImage imageNamed:self.iconImageName];
    cell.arrowImageView.hidden = !self.isShowArrow;
    cell.desLabel.numberOfLines = self.numLinesOfdesLabel;

    if (self.numLinesOfdesLabel == 1)
    {
        [cell.desLabel changeHeight:Height320(12)];
        
        self.cellHeight =  Height320(72);
    }
    else
    {
        CGSize desSize = YF_MULTILINE_TEXTSIZE(self.des, cell.desLabel.font, CGSizeMake(cell.desLabel.width, 1000), 0);
        CGFloat heith = desSize.height + 1;
        
        if (heith < Height320(12))
        {
            heith = Height320(12);
        }
        
        [cell.desLabel changeHeight:heith];
        
        self.cellHeight =  Height320(60) + heith;
    }
}


@end
