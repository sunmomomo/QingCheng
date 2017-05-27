//
//  YFSmsDetaiDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//    NSDictionary *dic = @{@"title":@"Kent、方志恒、林雪婷、段光英等30名会员",
//                          @"content":@"亲爱的会员您好，2017春节将至，中美引力阳光上东店春节休息时间为2017-01-24至2017-02-05. 休息期间将",
//                          @"status":@"1",
//                          @"created_by":@{@"id":@"123",
//                                          @"username":@"陈驰远",
//                                          @"phone":@"18311436234",
//                                          @"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png",
//                                          },
//                          @"users":@[@{@"id":@"123",
//                                       @"username":@"陈驰远",
//                                       @"phone":@"18311436234",
//                                       },
//                                     @{@"id":@"123",
//                                       @"username":@"Kent",
//                                       @"phone":@"18311436234",
//                                       },
//                                     @{@"id":@"123",
//                                       @"username":@"陈驰远",
//                                       @"phone":@"18311436234",
//                                       }
//                                     ]
//                          };

//    YFSmsListCModel *model = [YFSmsListCModel defaultWithYYModelDic:dic];
//    self.detailModel = model;
//

#import "YFSmsDetaiDataModel.h"

#define API @"/api/staffs/%ld/group/message/detail/"

#import "YFSmsListCModel.h"

#import "YFTBSmsDetailSectionModel.h"

#import "YFSmsRecipentCModel.h"

#import "YFDesValueCModel.h"

#import "YFSenderCModel.h"

@interface YFSmsDetaiDataModel ()

@property(nonatomic, strong)YFDesValueCModel *desValueCModel;
@property(nonatomic, strong)YFSenderCModel *senderCModel;

@end

@implementation YFSmsDetaiDataModel

- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{

    Parameters *para = [self paraWithGym:gym];
    
    [para setParameter:self.message_id forKey:@"message_id"];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    weakTypesYF
    [YFHttpService getList:urlString parameters:para.data modelClass:[YFSmsListCModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataArrayYYModel * _Nullable arrayModel) {
        
        arrayModel.exDicKey = @"group_message";

        weakS.detailModel = (YFSmsListCModel *)arrayModel.exDicModel;

        YFSmsListCModel *model = weakS.detailModel;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        YFTBSmsDetailSectionModel *sectionsModel1 = [[YFTBSmsDetailSectionModel alloc] init];
        
        NSMutableArray *firsSectArray ;
        
        if (model.users.count > 0) {
            YFSmsRecipentCModel *smsRecipentCModel = [YFSmsRecipentCModel defaultWithYYModelDic:nil];
            smsRecipentCModel.allNameTitle = model.title;
            smsRecipentCModel.weakSectionModel = sectionsModel1;
            YFSmsRecipentSubCModel *firstModel = model.users.firstObject;
            [smsRecipentCModel getInforFrom:firstModel];
            
            [model.users replaceObjectAtIndex:0 withObject:smsRecipentCModel];
            
            if (model.users.count == 1)
            {
                smsRecipentCModel.showEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            }
            
        }else
        {
            // 空数据
            YFSmsRecipentCModel *smsRecipentCModel = [YFSmsRecipentCModel defaultWithYYModelDic:nil];
            smsRecipentCModel.allNameTitle = model.title;
            smsRecipentCModel.weakSectionModel = sectionsModel1;
            YFSmsRecipentSubCModel *firstModel = model.users.firstObject;
            [smsRecipentCModel getInforFrom:firstModel];
            
            firsSectArray = [NSMutableArray array];
            [firsSectArray addObject:smsRecipentCModel];
            
            smsRecipentCModel.showEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        }
        
        
        YFSmsRecipentSubCModel *lastModel;
        if (model.users.count > 1) {
            lastModel = model.users.lastObject;
        }
        
        if (model.users.count > 0)
        {
            // 多少名 非名下会员
            if (model.other_users_count.integerValue > 0)
            {
                YFSmsRecipentSubCModel *otherCountModel = [YFSmsRecipentSubCModel defaultWithYYModelDic:nil];
                
                otherCountModel.notBelongName = [NSString stringWithFormat:@"及%@名非名下会员",model.other_users_count];
                otherCountModel.edgeInsets = UIEdgeInsetsMake(0, 15.0, 0, 0);
                [model.users addObject:otherCountModel];
            }else
            {
                lastModel.edgeInsets = UIEdgeInsetsMake(0, 15.0, 0, 0);
            }
        }
        if (firsSectArray.count)
        {
        sectionsModel1.dataArray = firsSectArray;
        }
        else
        {
        sectionsModel1.dataArray = model.users;
        }
        YFTBSectionsModel *sectionsModel2 = [[YFTBSectionsModel alloc] init];
        [sectionsModel2.dataArray addObject:self.desValueCModel];
        
        [dataArray addObject:sectionsModel1];
        [dataArray addObject:sectionsModel2];
        
        
        if (self.smsType == YFSmsTypeSuccess)
        {
            self.senderCModel.name = model.created_by.name;
            self.senderCModel.phone = model.created_by.phone;
            self.senderCModel.avator = model.created_by.avatar;
            [sectionsModel2.dataArray addObject:self.senderCModel];
        }
        
        self.dataArray = dataArray;
        
        if (successBlock) {
            successBlock();
        }
     } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}


- (void)deleteDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:gym];
    
    [para setParameter:self.message_id forKey:@"message_id"];
    
//    NSString *urlString =  [NSString stringWithFormat:@"%@%@?id=%@&model=%@&message_id=%@",ROOT,[NSString stringWithFormat:API,StaffId],@(AppGym.gymId),AppGym.type,self.message_id];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];

    [YFHttpService deleteSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        if (successBlock) {
            successBlock();
        }

    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

//#warning 测试数据
- (YFDesValueCModel *)desValueCModel
{
    if (_desValueCModel == nil)
    {
        _desValueCModel = [YFDesValueCModel defaultWithYYModelDic:nil];
        
        _desValueCModel.timeStr = self.detailModel.created_at;
        
        if (self.smsType == YFSmsTypeDraft)
        {
            _desValueCModel.des = @"保存时间:";
        }
        else
        {
            _desValueCModel.des = @"发送时间:";
        }
    }
    return _desValueCModel;
}
- (YFSenderCModel *)senderCModel
{
    if (_senderCModel == nil)
    {
        _senderCModel = [YFSenderCModel defaultWithYYModelDic:nil];
    }
    return _senderCModel;
}


@end
