//
//  YFTagModel.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagModel.h"

#import "YFTagColloectionViewCell.h"


@implementation YFTagModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
    
        self.cellClass = [YFTagColloectionViewCell class];
        
    
    }
    
    return self;
}

- (void)bindCollVCell:(YFTagColloectionViewCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.tagNameLabel.text = self.tagString;
    baseCell.deleteBlock = self.deleteBlock;
//    baseCell.tagModel = self;
    self.indexPath = indexPath;
}

- (void)setTagString:(NSString *)tagString
{
    _tagString = tagString;
    
    CGFloat width = ceil( [tagString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width);

    if (width > [[UIScreen mainScreen] bounds].size.width - 30) {
        width = [[UIScreen mainScreen] bounds].size.width - 30;
    }
    
    self.cellSize = CGSizeMake(width + 14 + 26, 26);
}

@end
