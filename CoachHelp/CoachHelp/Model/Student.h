//
//  Student.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

#import "CountryChooseTextField.h"

@interface Student : NSObject

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)NSString *gender;

@property(nonatomic,assign)NSInteger shipId;

@property(nonatomic,assign)NSInteger stuId;

@property(nonatomic,copy)NSURL *avatar;

@property(nonatomic,copy)NSURL *photo;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *head;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *birth;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *createDate;

@property(nonatomic,copy)NSString *remarks;

@property(nonatomic,strong)CountryPhone *country;

@end
