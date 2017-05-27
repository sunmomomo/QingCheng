//
//  YFSignUpListDeletePerVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFSignUpListDeletePerVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, copy)NSNumber *competition_id;

@property(nonatomic ,strong)Gym *gym;

@property(nonatomic, copy)void(^deletidArraySuccessBlock)(NSMutableArray *);

@property(nonatomic, strong)NSMutableArray *allUsersDicArray;

@property(nonatomic, strong)NSNumber *team_id;

@end
