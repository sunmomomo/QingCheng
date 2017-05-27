//
//  YFStudentListDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentListDataModel.h"
#import "Parameters.h"
#import "YFHttpService.h"
#import "YFAppConfig.h"
#import "YFAppService.h"
#import "YFStudentListModel.h"
#import "YFTBSectionsTitleModel.h"
#import "YFDateService.h"

#import "YFListCache.h"
#import "YFAppService.h"


#define API @"/api/staffs/%ld/users/"

#define CardAPI @"/api/staffs/%ld/method/users/"

#define SellerAPI @"/api/v2/staffs/%ld/sellers/users/"

#define SellerAddAPI @"/api/v2/staffs/%ld/sellers/users/all/"

@interface YFStudentListDataModel ()
@property(nonatomic,assign)BOOL isSortTime;

@end

@implementation YFStudentListDataModel

-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym filterModel:(YFFilterOtherModel *)filterModel successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    weakTypesYF
    if (!StaffId) {
        if (failBlock) {
        failBlock();
        }
        return;
    }
    NSInteger brandId = [[NSUserDefaults standardUserDefaults]integerForKey:@"stu_brand_id"];

   
    if (brandId != [BRANDID integerValue]|| (gym.gymId && (gym.gymId != self.gym.gymId || ![gym.type isEqualToString:self.gym.type]))||(gym.shopId && gym.shopId != self.gym.shopId)||(self.gym && !gym)||(!self.gym && gym) || [self.fiterOtherModel.paramDicYF isEqualToDictionary:filterModel.paramDicYF] == NO)
    {
        
    
    }else
    {
        NSDictionary *dic = [YFListCache cacheOnDocumentDicForKey:YFCacheKey];
        
        if (dic && dic.count) {
            weakTypesYF
            [self resultDic:dic[@"data"]];
            
            [YFAppService asypath:^{
                [weakS setTimeArraySorted];
                
                    weakS.showLetterFilterdataArray = weakS.allSectionLetterFilterdataArray;
                    weakS.showSortTimeArray = weakS.sortTimeArray;
                    weakS.showLetterKeys = weakS.allLetterKeys.mutableCopy;
                    
                } mainAction:^{
                if (successBlock) {
                    successBlock();
                }
            }];
            return;
        }
    }
    
    self.fiterOtherModel = filterModel;
    
    self.gym = gym;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [self.fiterOtherModel paramWithDictionary:para.data];
    
 
    [[NSUserDefaults standardUserDefaults]setInteger:[BRANDID integerValue] forKey:@"stu_brand_id"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    
    
    [[NSUserDefaults standardUserDefaults]setInteger:[BRANDID integerValue] forKey:@"stu_brand_id"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
        [weakS resultDic:reModel.dataModel.dic];
        [YFListCache setToDocumentObjectOfDic:reModel.allDataDic key:YFCacheKey];
            
            [YFAppService asypath:^{
                [weakS setTimeArraySorted];
                if (weakS.searchStr.length == 0)
                {
                    weakS.showLetterFilterdataArray = weakS.allSectionLetterFilterdataArray;
                    weakS.showSortTimeArray = weakS.sortTimeArray;
                    weakS.showLetterKeys = weakS.allLetterKeys.mutableCopy;

                }else
                {
                    // 根据 搜索字符串 筛选
                    [weakS searchResultYF];
                }
            } mainAction:^{
                if (successBlock) {
                    successBlock();
                }
            }];
        }else
        {
            if (failBlock) {
                failBlock();
            }
            [YFListCache removeCacheOnDocumentStudentArrayFromKey:YFCacheKey];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        if (failBlock) {
        failBlock();
        }
        [YFListCache removeCacheOnDocumentStudentArrayFromKey:YFCacheKey];
//        [YFAppService showAlertMessageWithError:error];
    }];
    
}

- (void)searchResultYF
{
    return;

//    self.showLetterFilterdataArray = [NSMutableArray array];
//    
//    self.showLetterKeys = [NSMutableArray array];
//    
//    for (YFTBSectionsTitleModel *model in self.allSectionLetterFilterdataArray) {
//        
//        YFTBSectionsTitleModel *sectionModel = [[YFTBSectionsTitleModel alloc] init];
//        [sectionModel setStudentFilter];
//        sectionModel.sectionTitle  = model.sectionTitle;
//        
//        for (YFStudentListModel *subModel in model.dataArray)
//        {
//            if ([[subModel.username lowercaseString] rangeOfString:[self.searchStr lowercaseString]].length||[subModel.phone rangeOfString:self.searchStr].length) {
//                
//                [sectionModel.dataArray addObject:subModel];
//            }
//        }
//        
//        if (sectionModel.dataArray.count > 0)
//        {
//            [self.showLetterKeys addObject:sectionModel.sectionTitle];
//            [self.showLetterFilterdataArray addObject:sectionModel];
//        }
//        
//    }
//    
//
//    
//    self.showSortTimeArray = [[NSMutableArray alloc] init];
//    
//    YFTBSectionsTitleModel *sectionModelTimeSort = [[YFTBSectionsTitleModel alloc] init];
//
//    YFTBSectionsTitleModel *sortedTimtModelTimeSort = self.sortTimeArray[0];
//
//    for (YFStudentListModel *model in sortedTimtModelTimeSort.dataArray)
//    {
//        if ([[model.username lowercaseString] rangeOfString:[self.searchStr lowercaseString]].length||[model.phone rangeOfString:self.searchStr].length) {
//            
//            [sectionModelTimeSort.dataArray addObject:model];
//        }
//    }
//    if (sectionModelTimeSort.dataArray.count > 0)
//    {
//        [self.showSortTimeArray addObject:sectionModelTimeSort];
//    }
}

-(void)resultDic:(NSDictionary *)dic
{
    _isSortTime = NO;
    
    // 清除原先的 时间排序数据
    YFTBSectionsTitleModel *sectionModelTimeSort = self.sortTimeArray[0];
    [sectionModelTimeSort.dataArray removeAllObjects];
    
    self.allMemNum = [dic[@"total_count"] guardStringYF];
    
    NSArray *dataArray =  dic[@"users"];
    
    dataArray = [dataArray guardArrayYF];
    
    NSMutableDictionary *allValudDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dic in dataArray) {
        YFStudentListModel *model = [[YFStudentListModel alloc] initWithDictionary:dic];
        
        YFTBSectionsTitleModel *sectionModel = [allValudDic objectForKey:model.head];
        
        if (!sectionModel)
        {
            sectionModel = [self sectionModelWith:model.head];
            [allValudDic setObject:sectionModel forKey:model.head];
            
        }
        [sectionModel.dataArray addObject:model];
        
        
        [sectionModelTimeSort.dataArray addObject:model];

    }
    
    NSArray *allKeys = allValudDic.allKeys;
    
    NSComparator cmptr = ^(NSString *obj1,NSString* obj2){
        
        
        
        if ([obj1 isEqualToString:@"#"]) {
            
            return NSOrderedDescending;
        }else if ([obj2 isEqualToString:@"#"])
        {
            return NSOrderedAscending;
        }
        
        return [obj1  compare: obj2];
        
    };

    allKeys = [allKeys sortedArrayUsingComparator:cmptr];

    self.allLetterKeys = allKeys;
    NSMutableArray *allSectionDataArray = [NSMutableArray array];
    
    for (NSString *keyValue in allKeys) {
        
        YFTBSectionsTitleModel *sectionModel = [allValudDic objectForKey:keyValue];
        
        if ([sectionModel isKindOfClass:[YFTBSectionsTitleModel class]])
        {
            [allSectionDataArray addObject:sectionModel];
        }
        
    }
    self.allSectionLetterFilterdataArray = allSectionDataArray;
    
}

- (YFTBSectionsTitleModel *)sectionModelWith:(NSString *)key
{
    YFTBSectionsTitleModel *model1 = [[YFTBSectionsTitleModel alloc] init];
    [model1 setStudentFilter];
    model1.sectionTitle = key;
    return model1;
}

- (void)setSearchStr:(NSString *)searchStr isLetterSort:(BOOL)isLetter
{
    return;
//    if ([searchStr isEqualToString:_searchStr] == YES)
//    {
//        return;
//    }
//    _searchStr = searchStr;
// 
//    if (!_searchStr || _searchStr.length == 0)
//    {
//        self.showLetterFilterdataArray = self.allSectionLetterFilterdataArray;
//        self.showSortTimeArray = self.showSortTimeArray;
//    }else
//    {
//    // 根据 搜索字符串 筛选
//    [self searchResultYF];
//    }
//    return;
//    _searchResultArray = [NSMutableArray array];
//    
//    if (self.searchStr.length > 0) {
//        
//        if (isLetter)
//        {
//
//            for (YFTBSectionsTitleModel *model in self.allSectionLetterFilterdataArray) {
//                
//                YFTBSectionsTitleModel *sectionModel = [[YFTBSectionsTitleModel alloc] init];
//                [sectionModel setStudentFilter];
//                sectionModel.sectionTitle  = model.sectionTitle;
//
//                for (YFStudentListModel *subModel in model.dataArray)
//                {
//                    if ([[subModel.username lowercaseString] rangeOfString:[self.searchStr lowercaseString]].length||[subModel.phone rangeOfString:self.searchStr].length) {
//                        
//                        [sectionModel.dataArray addObject:subModel];
//                    }
//                }
//                
//                if (sectionModel.dataArray.count > 0)
//                {
//                    [self.searchResultArray addObject:sectionModel];
//                }
//                
//            }
//            
//            
//            
//        }else
//        {
//            YFTBSectionsTitleModel *sectionModelTimeSort = [[YFTBSectionsTitleModel alloc] init];
//
//            for (YFStudentListModel *model in sectionModelTimeSort.dataArray)
//            {
//            
//                if ([[model.username lowercaseString] rangeOfString:[self.searchStr lowercaseString]].length||[model.phone rangeOfString:self.searchStr].length) {
//                    
//                    [sectionModelTimeSort.dataArray addObject:model];
//                }
//            }
//            self.searchResultArray = [NSMutableArray arrayWithObject:sectionModelTimeSort];
//        }
//    
//        
//        
//    }
    
}

- (YFFilterOtherModel *)fiterOtherModel
{
    if (!_fiterOtherModel)
    {
        _fiterOtherModel = [[YFFilterOtherModel alloc] init];
    }
    return _fiterOtherModel;
}

- (NSMutableArray *)sortTimeArray
{
    if (_sortTimeArray == nil)
    {
        _sortTimeArray =[[NSMutableArray alloc] init];
        YFTBSectionsTitleModel *sectionModel = [[YFTBSectionsTitleModel alloc] init];
        [_sortTimeArray addObject:sectionModel];

    }
    return _sortTimeArray;
}

- (void)setTimeArraySorted
{
    
    if (_isSortTime == YES)
    {
        return;
    }
    _isSortTime = YES;
    
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSComparator cmptr = ^(YFStudentListModel *obj1,YFStudentListModel* obj2){

        NSString *timeStr1 = [obj1.join_at stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        NSString *timeStr2 = [obj1.join_at stringByReplacingOccurrencesOfString:@"T" withString:@" "];
      NSTimeInterval timeinter1 =  [[df dateFromString:timeStr1] timeIntervalSince1970];
        
      NSTimeInterval timeinter2 =  [[df dateFromString:timeStr2] timeIntervalSince1970];
        
        
        if (timeinter1 > timeinter2) {
                        return NSOrderedAscending;
        }else
        {
            return NSOrderedDescending;
        }
    };
    
    YFTBSectionsTitleModel *sectionModelTimeSort = self.sortTimeArray[0];

    
    [sectionModelTimeSort.dataArray sortUsingComparator:cmptr];
    
//    for (YFStudentListModel *model in sectionModelTimeSort.dataArray)
//    {
//        DebugLogYF(@"%@",model.join_at);
//        NSLog(@"%@",model.join_at);
//    }

}

-(NSMutableArray *)showSortTimeArray
{
    // 如果 _sortTimeArray 里的数据为空，返回空数组
    if (_sortTimeArray.count > 0) {
        YFTBSectionsTitleModel *sectionModel = _sortTimeArray[0];
        if ([sectionModel isKindOfClass:[YFTBSectionsTitleModel class]])
        {
            if (sectionModel.dataArray.count <= 0)
            {
                return [NSMutableArray array];
            }
        }
    }
    return _showSortTimeArray;
}

- (NSString *)allMemNum
{
    if (self.sortTimeArray.count > 0)
    {
        YFTBSectionsTitleModel *sectionModelTimeSort = self.sortTimeArray[0];
        
        return  [NSString stringWithFormat:@"%@",@(sectionModelTimeSort.dataArray.count)];
    }
   return @"";
}

@end
