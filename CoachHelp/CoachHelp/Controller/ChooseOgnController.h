//
//  ChooseOgnController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Quality.h"

@interface ChooseOgnController : MOViewController

@property(nonatomic,copy)void(^addSuccess)(Quality *quality);

@property(nonatomic,strong)Quality *quality;

@end
