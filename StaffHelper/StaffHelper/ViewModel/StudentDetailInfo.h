//
//  StudentDetailInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import "Card.h"

#import "Record.h"

#import "FollowRecord.h"

#import "YFStatAbsenModel.h"

@interface StudentDetailInfo : NSObject

@property(nonatomic,strong)NSMutableArray *recordArray;

@property(nonatomic,strong)NSMutableArray *cardArray;

@property(nonatomic,strong)NSMutableArray *followArray;

@property(nonatomic,strong)Student *student;

@property(nonatomic,copy)NSURL *privateURL;

@property(nonatomic,copy)NSURL *groupURL;

@property(nonatomic,copy)void(^cardDataFinish)(BOOL success);

@property(nonatomic,copy)void(^recordFinish)(BOOL success);

@property(nonatomic,copy)void(^followFinish)(BOOL success);

@property(nonatomic,copy)void(^stuFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)void(^addCallBack)(BOOL success,NSString *error,Student *student);

// 出勤记录的统计 信息
@property(nonatomic, strong)YFStatAbsenModel *statModel;
// 出勤记录筛选的场馆列表
@property(nonatomic, strong)NSMutableArray *gymArray;

// 出勤记录 的shopid
@property(nonatomic, strong)NSDictionary *recoShopidParam;

-(instancetype)initWithStudent:(Student *)student;

-(void)request;

-(void)requestStuInfoWithStudent:(Student *)student;

-(void)requestChestCardInfoWithStudent:(Student *)student;

-(void)requestCardInfoWithStudent:(Student*)student;

-(void)createStudent:(Student*)stu result:(void(^)(BOOL success,NSString *error,Student *student))result;

-(void)changeStudent:(Student*)stu result:(void(^)(BOOL success,NSString *error))result;

-(void)changeSellers:(NSArray*)sellers withGym:(Gym*)gym withStudent:(Student*)stu result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteStudent:(Student*)stu withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteStudent:(Student *)stu withGyms:(NSArray *)gyms result:(void(^)(BOOL success,NSString *error))result;

-(void)uploadFollow:(FollowRecord*)follow;

// 请求 出清记录
-(void)requestRecoWithStu:(Student *)stu;
@end
