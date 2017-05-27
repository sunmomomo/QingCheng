//
//  GymQRCodeAlert.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/20.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GymQRCodeAlert : UIView

@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,copy)NSString *topTitleName;



+(instancetype)defaultAlert;

-(void)show;

@end
