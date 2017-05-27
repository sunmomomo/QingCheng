//
//  CardListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardListInfo.h"

#import "UIColor+Hex.h"

#import "YFCardCModel.h"

#import "YFHttpService.h"

#import "YFRespoDataArrayYYModel.h"

#import "NSMutableDictionary+YFExtension.h"

#define API @"/api/staffs/%ld/cards/all/"

#define CarkCount @"/api/staffs/%ld/balance/cards/count/"

#define SuffientCardList @"/api/staffs/%ld/balance/cards/"


#define CardSuffientConfig @"/api/v2/staffs/%ld/users/configs/"



@interface CardListInfo ()

{
    
    NSInteger _totalPage;
    
    NSInteger _currentPage;
    
    Gym *_gym;
    
    NSInteger _cardKindId;
    
    CardState _state;
    
    NSString *_searchStr;
    
    NSDictionary *_contionParam;// 包括 id 和 type
}

@end

@implementation CardListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cards = [NSMutableArray array];
        
        _currentPage = 0;
        
        _totalPage = 1;
        
    }
    return self;
}

-(void)requestDataWithGym:(Gym *)gym andCardKindId:(NSInteger)cardKindId andState:(CardState)state andSearch:(NSString *)search
{
    
    if (!StaffId) {
        
        if (self.requestFinish) {
            
            self.requestFinish(NO,nil);
            
        }
        
    }else if(_currentPage >= _totalPage){
     
        if (self.requestFinish) {
            self.requestFinish(YES,@"无更多数据");
        }
        
    }else
    {
        
        _gym = gym;
        
        _cardKindId = cardKindId;
        
        _state = state;
        
        _searchStr = search;
        
        [self update];
        
    }
    
}

-(void)requestDataWithGym:(Gym *)gym contionParam:(NSDictionary *)contionParam andState:(CardState)state andSearch:(NSString *)search{
    
    if (!StaffId) {
        
        if (self.requestFinish) {
            
            self.requestFinish(NO,nil);
            
            self.requestFinish = nil;
            
        }
        
    }else if(_currentPage >= _totalPage){
        
        if (self.requestFinish) {
            self.requestFinish(YES,@"无更多数据");
        }
        
    }else
    {
        
        _gym = gym;
        
        _contionParam = contionParam;
        
        _state = state;
        
        _searchStr = search;
        
        [self update];
        
    }
    
}


-(void)createDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Card *card = [[Card alloc]init];
        
        card.cardKind.cardKindId = [obj[@"card_tpl"][@"id"] integerValue];
        
        card.cardId = [obj[@"id"] integerValue];
        
        card.color = [UIColor colorWithHexString:obj[@"color"]];
        
        card.cardNumber = obj[@"card_no"];
        
        card.cardName = obj[@"name"];
        
        card.state = [obj[@"is_locked"] boolValue]?CardStateRest:CardStateNormal;
        
        if (![obj[@"is_active"] boolValue]) {
            
            card.state = CardStateStop;
            
        }
        if ([obj[@"expired"] boolValue]) {
            
            card.state = CardStateExpired;
            
            NSString *trial_daysStr =  [obj[@"trial_days"] guardStringYF];
            
            card.trial_days = trial_daysStr.integerValue;
        }

        
        card.cardKind.type = [obj[@"type"] integerValue];
        
        card.checkValid = [obj[@"check_valid"] boolValue];
        
        card.lockStart = [obj[@"lock_start"] length]?[obj[@"lock_start"] substringToIndex:10]:@"";
        
        card.lockEnd = [obj[@"lock_end"] length]?[obj[@"lock_end"] substringToIndex:10]:@"";
        
        card.start = [obj[@"start"] length]?[obj[@"start"] substringToIndex:10]:@"";
        
        card.end = [obj[@"end"] length]?[obj[@"end"] substringToIndex:10]:@"";
        
        card.validFrom = [obj[@"valid_from"] length]?[obj[@"valid_from"] substringToIndex:10]:@"";
        
        card.validTo = [obj[@"valid_to"] length]?[obj[@"valid_to"] substringToIndex:10]:@"";
        
        card.remain = [obj[@"balance"] floatValue];
        
        NSMutableArray *array = [NSMutableArray array];
        
        [obj[@"users"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Student *stu = [[Student alloc]init];
            
            stu.stuId = [object[@"id"] integerValue];
            
            stu.name = object[@"username"];
            
            stu.phone = object[@"phone"];
            
            [array addObject:stu];
            
        }];
        
        [obj[@"card_tpl"][@"shops"] enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Gym *gym = [[Gym alloc]init];
            
            gym.name = object[@"name"];
            
            gym.shopId = [object[@"id"] integerValue];
            
            gym.brand.brandId = [BRANDID integerValue];
            
            [card.cardKind.gyms addObject:gym];
            
        }];

        card.users = array;
        
        [self.cards addObject:card];
        
    }];
    
}

-(void)update
{
    
    if (_currentPage >= _totalPage) {
        
        if (self.requestFinish) {
            
            self.requestFinish(YES,@"无更多数据");
            
            self.requestFinish = nil;
            
        }
        
        return;
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (_gym.gymId && _gym.type.length){
        
        [para setParameter:_gym.type forKey:@"model"];
        
        [para setInteger:_gym.gymId forKey:@"id"];
        
    }else if(_gym.shopId && _gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:_gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:_gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:[NSNumber numberWithInteger:_currentPage+1] forKey:@"page"];
    
    
    if (_contionParam)
    {
        NSNumber *stateNum = [_contionParam objectForKey:@"state"];
        if (stateNum) {
        _state = [stateNum integerValue];
        }
        [para.data addEntriesFromDictionary:_contionParam];

        [para.data removeObjectForKey:@"state"];
        
    }else if (_cardKindId) {
        [para setParameter:[NSNumber numberWithInteger:_cardKindId] forKey:@"card_tpl_id"];
    }
    
    if (_state == CardStateStop) {
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_active"];
        
    }else if(_state == CardStateRest)
    {
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_locked"];
        
    }else if (_state == CardStateNormal)
    {
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_locked"];
        
        [para setParameter:@"0" forKey:@"is_expired"];
        
        [para setParameter:@"1" forKey:@"is_active"];


    }
    else if (_state == CardStateExpired)
    {
        [para setParameter:@"1" forKey:@"is_expired"];
    }

    
    if (_searchStr.length) {
        
        [para setParameter:_searchStr forKey:@"q"];
        
    }
    
    [para setParameter:@"-id" forKey:@"order_by"];
    
    NSString *urlString;
    if (self.isNotSuffient) {
        urlString = SuffientCardList;
    }else
    {
        urlString = API;
    }
    DebugLogParamYF(@"%@",para.data);
    DebugLogParamYF(@"urlString:%@",urlString);

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:urlString,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"cards"]];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            self.totalCount = [responseDic[@"data"][@"total_count"] integerValue];
            
            if (self.requestFinish) {
                
                self.requestFinish(YES,nil);
                
                self.requestFinish = nil;
                
            }
            
        }else
        {
            
            if (self.requestFinish) {
                
                self.requestFinish(YES,responseDic[@"msg"]);
                
                self.requestFinish = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            
            self.requestFinish(NO,error);
            
            self.requestFinish = nil;
            
        }
        
    }];
}


- (void)getCardConutshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CarkCount,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            weakS.suffinetCardCount = [reModel.dataModel.dic[@"count"] guardStringYF];
            
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

- (void)getGetSuffientSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
    [para setParameter:@"card_balance_remind_days,card_balance_remind_times,card_balance_remind_value" forKey:@"keys"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CardSuffientConfig,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        
        if (reModel.isSuccess)
        {
//            weakS.suffinetCardCount = [reModel.dataModel.dic[@"count"] guardStringYF];
        YFRespoDataModel *dataModel = baseModel.dataModel;
        
            weakS.remindDaysModel = nil;
            weakS.remandTimesModel = nil;
            weakS.balancePayModel = nil;

            NSArray *array = [dataModel.dic[@"configs"] guardArrayYF];
            for (NSDictionary *dic in array) {
                
                NSString *key = dic[@"key"];
                if ([key isEqualToString:@"card_balance_remind_days"])
                {
                    weakS.remindDaysModel = [YFCardSuffientModel defaultWithYYModelDic:dic];
                }else if([key isEqualToString:@"card_balance_remind_times"])
                {
                    weakS.remandTimesModel = [YFCardSuffientModel defaultWithYYModelDic:dic];
                }else if ([key isEqualToString:@"card_balance_remind_value"])
                {
                    weakS.balancePayModel = [YFCardSuffientModel defaultWithYYModelDic:dic];
                }
            }
            
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

- (void)getPutSuffientSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym param:(NSDictionary *)dicParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
    NSString *payStr = [[dicParam objectForKey:@"pay"] guardStringYF];// 储值
    NSString *countStr = [[dicParam objectForKey:@"count"] guardStringYF];// 次数
    NSString *timeStr = [[dicParam objectForKey:@"time"] guardStringYF];// 有效期
    
    
    NSMutableArray *configsArray = [NSMutableArray array];
    
    if (payStr) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObje_FY:self.balancePayModel.cardSet_Id toKey:@"id"];
        [dic setObje_FY:payStr toKey:@"value"];
        
        [configsArray addObject:dic];
    }
    
    if (countStr) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObje_FY:self.remandTimesModel.cardSet_Id toKey:@"id"];
        [dic setObje_FY:countStr toKey:@"value"];
        
        [configsArray addObject:dic];
    }

    if (timeStr) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObje_FY:self.remindDaysModel.cardSet_Id toKey:@"id"];
        [dic setObje_FY:timeStr toKey:@"value"];
        
        [configsArray addObject:dic];
    }
    
    [para setParameter:configsArray forKey:@"configs"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CardSuffientConfig,StaffId]];
    

    [[YFHttpService instance] PUT:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        
        if (reModel.isSuccess)
        {
            
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



@end
