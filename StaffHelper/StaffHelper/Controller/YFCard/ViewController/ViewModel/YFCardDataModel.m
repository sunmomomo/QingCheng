//
//  YFCardDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardDataModel.h"

#import "YFRespoDataArrayYYModel.h"
#import "YFAppConfig.h"


#import "YFHttpService.h"

#import "YFCardCModel.h"

//#define API @"/api/v2/staffs/%ld/cardtpls/all/"

#define API @"/api/staffs/%ld/filter/cardtpls/"

#define BindCardList @"/api/staffs/%ld/cards/bind/users/"


@implementation YFCardDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        DebugLogYF(@"9999999999999999&&&&&&&");
    }
    return self;
}
- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    if (self.isNotSuffient) {
        [para setParameter:@"1" forKey:@"is_active"];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];

    
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayYYModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {            
            [self createDataWithArray:reModel.allDataDic[@"data"][@"card_tpls"]];

            
            if (successBlock) {
                successBlock();
            }
            
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock();
        }
        //        [YFAppService showAlertMessageWithError:error];
    }];
    
}

-(void)createDataWithArray:(NSArray *)array
{
    self.dataArray = [NSMutableArray array];
 
    NSMutableArray *allTypeArray = [[NSMutableArray alloc] init];
    NSMutableArray *prepaidMoArray = [[NSMutableArray alloc] init];
    self.prepaidMoArray = prepaidMoArray;
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    self.countArray = countArray;
    NSMutableArray *timeMoArray = [[NSMutableArray alloc] init];
    self.timeMoArray = timeMoArray;
    
    YFCardCModel *model0 = [[YFCardCModel alloc] initWithYYModelDictionary:nil];
    model0.name = @"全部会员卡种类";
    model0.isSelected = YES;
    
    YFCardCModel *model1 = [[YFCardCModel alloc] initWithYYModelDictionary:nil];
    model1.card_tpl_type = @"1";
    model1.name = @"全部储值类型";
    
    YFCardCModel *model2 = [[YFCardCModel alloc] initWithYYModelDictionary:nil];
    model2.card_tpl_type = @"2";
    model2.name = @"全部次卡类型";
    
    YFCardCModel *model3 = [[YFCardCModel alloc] initWithYYModelDictionary:nil];
    model3.card_tpl_type = @"3";
    model3.name = @"全部期限类型";
   
   
    
    if ([array isKindOfClass:[NSArray class]] == NO)
    {
        [allTypeArray addObject:model0];
        [self.dataArray addObject:allTypeArray];
        return;
    }
    NSLog(@"%@",array);
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        YFCardCModel *model = [[YFCardCModel alloc] initWithYYModelDictionary:obj];
        
        // 储值卡
        if (model.type == CardKindTypePrepaid)
        {
            [prepaidMoArray addObject:model];
        }// 次卡
        else if (model.type == CardKindTypeCount)
        {
            [countArray addObject:model];
        }else // 期限卡
        {
            [timeMoArray addObject:model];
        }
        
//        NSLog(@"type:%ld",model.type);
    }];
//    945  545
    NSLog(@"%@%@%@",@(prepaidMoArray.count),@(countArray.count),@(timeMoArray.count));
    
    [allTypeArray addObject:model0];
    [self.dataArray addObject:allTypeArray];
    
    if (prepaidMoArray.count)
    {
    [prepaidMoArray insertObject:model1 atIndex:0];
    [self.dataArray addObject:prepaidMoArray];
    }
    
    if (countArray.count)
    {
        [countArray insertObject:model2 atIndex:0];
        [self.dataArray addObject:countArray];
    }
    
    if (timeMoArray.count)
    {
        [timeMoArray insertObject:model3 atIndex:0];
        [self.dataArray addObject:timeMoArray];
    }
}

- (void)getBindCardStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym card_id:(NSString *)card_id successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
     [para setParameter:card_id forKey:@"card_id"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:BindCardList,StaffId]];

    
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        weakTypesYF
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        YFRespoDataArrayModel *arrayModel = (YFRespoDataArrayModel *)reModel.dataModel;
        if (reModel.isSuccess)
        {
            [weakS resultDic:arrayModel.listArray];

                if (successBlock) {
                    successBlock();
                }
        
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock();
        }
        //        [YFAppService showAlertMessageWithError:error];
    }];

    
}
-(void)resultDic:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]] == NO)
    {
        array = @[];
    }
    
    self.bindCardStuArray = [NSMutableArray array];
    
    for (NSDictionary *object in array) {
        Student *stu = [[Student alloc]init];
        
        stu.stuId = [object[@"id"] integerValue];
        
        stu.name = object[@"username"];
        
        stu.phone = object[@"phone"];
        
        stu.avatar = [NSURL URLWithString:object[@"avatar"]];
        
        stu.sex = [[object[@"gender"] guardStringYF] integerValue];

        
        [self.bindCardStuArray addObject:stu];
    }
}



@end
