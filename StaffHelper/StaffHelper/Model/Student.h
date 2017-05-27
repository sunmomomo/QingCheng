//
//  Student.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

#import "Card.h"

#import "Seller.h"

#import "CountryChooseTextField.h"

#import "YFBaseCModel.h"

static NSString *yFTagColloectionViewCell = @"YFTagColloectionViewCell";


@interface Student : YFBaseCModel

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,assign)NSInteger stuId;

@property(nonatomic,copy)NSURL *photo;

@property(nonatomic,copy)NSURL *avatar;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,strong)CountryPhone *country;

@property(nonatomic,copy)NSString *head;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *birth;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *createDate;

@property(nonatomic,strong)NSMutableArray *cards;

@property(nonatomic,assign)UserType type;

@property(nonatomic,strong)NSArray *sellers;

@property(nonatomic,strong)NSArray *coaches;

// 以 id 为 Key的字典，value 是 sellers
@property(nonatomic,strong)NSMutableDictionary *sellersDic;

@property(nonatomic,strong)NSMutableDictionary *coachesDic;

@property(nonatomic,copy)NSString *stuStrId;


// 备注
@property(nonatomic,copy)NSString *remarks;
// 来源 Name
@property(nonatomic,copy)NSString *origin;
// 推荐者id ，会员详情 暂无此字段， 不传 此字段，后台不处理
@property(nonatomic,copy)NSString *recommend_by_id;
// 推荐人 名字
@property(nonatomic,copy)NSString *recommend_by;
@property(nonatomic,assign)float integral;

// 创建短信 删除 标签要用
@property(nonatomic, copy)void(^deleteBlock)(id);


@end
