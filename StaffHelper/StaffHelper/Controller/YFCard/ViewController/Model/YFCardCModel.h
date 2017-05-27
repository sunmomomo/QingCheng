//
//  YFCardCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFCardCModel : YFBaseCModel

@property(nonatomic, assign)BOOL isSelected;

@property(nonatomic, copy)NSString *cardId;

@property(nonatomic, copy)NSString *name;

// 1 可用正常，0 停卡
@property(nonatomic, assign)BOOL is_enable;

@property(nonatomic,assign)CardKindType type;

// 1 2 3 储值卡，次卡，期限卡
@property(nonatomic, copy)NSString *card_tpl_type;

- (NSDictionary *)paramOfCard;


@end
