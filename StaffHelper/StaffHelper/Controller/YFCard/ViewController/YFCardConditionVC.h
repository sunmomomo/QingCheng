//
//  YFCardConditionVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "CardListInfo.h"

#define YFDonwnButtonSHeight XFrom5YF(40)

@interface YFCardConditionVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,copy)void(^sureBlock)();

@property(nonatomic, strong)UIButton *clearAllFilterConditionButton;

@property(nonatomic, strong)UIButton *sureButton;

@property(nonatomic, strong)NSDictionary *paramOfCondition;

-(void)setCardListSetting:(CardListInfo *)cardSetInfo;


@end
