//
//  ChatNameController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface ChatNameController : MOViewController

@property(nonatomic,strong)void(^nameChange)(NSString *name);

-(instancetype)initWithName:(NSString *)name andNameFinishBlock:(void(^)(NSString *name))finishBlock;

@end
