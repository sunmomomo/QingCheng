//
//  YFRespoDataArrayModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFRespoDataArrayModel.h"

@implementation YFRespoDataArrayModel


-(instancetype)initWithDictionary:(NSDictionary *)jsonDic modelClass:(Class)modelClass
{
    self = [super initWithDictionary:jsonDic modelClass:modelClass];
    if (self)
    {
        self.dic = jsonDic;
        
        NSArray *userS;
        
        if ([jsonDic isKindOfClass:[NSArray class]]) {
            userS = (NSArray *)jsonDic;
        }else{
            userS = [jsonDic objectForKey:@"users"];
            
            if (!userS) {
                userS = [jsonDic objectForKey:@"sellers"];
            }
        }
        
        
        [self resultArray:userS];
        
    }
    return self;
}

- (void)setArrayKey:(NSString *)arrayKey
{
    _arrayKey = arrayKey;
    
    NSArray *userS;
    
    userS = self.dic[arrayKey];
    
    if (userS) {
        [self resultArray:userS];
    }
    
}

- (void)setExArrayKey:(NSString *)exArrayKey
{
    _exArrayKey = exArrayKey;
    
    NSArray *userS;
    
    userS = self.dic[_exArrayKey];
    
    if (userS) {
        [self resultExArray:userS];
    }
}

- (void)setExDicKey:(NSString *)exDicKey
{
    _exDicKey = exDicKey;
    
    [self resultDic:self.dic[_exDicKey]];
}

-(void)resultDic:(NSDictionary  *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]] == NO || dic.count <= 0)
    {
        return;
    }
    if (!self.modelClass) {
        self.exDic = dic;
        return;
    }
    
    
    YFBaseModel *model = [self.modelClass defaultWithYYModelDic:dic];
    
    _exDicModel = model;
    
}


-(void)resultArray:(NSArray *)listArray
{
    if ([listArray isKindOfClass:[NSArray class]] == NO)
    {
        return;
    }
    if (!self.modelClass) {
        self.listArray = (NSMutableArray *)listArray;
        return;
    }
    _listArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in listArray)
    {
        YFBaseModel *model = [[self.modelClass alloc] initWithDictionary:dic];
        [_listArray addObject:model];
    }
}

-(void)resultExArray:(NSArray *)listArray
{
    if ([listArray isKindOfClass:[NSArray class]] == NO)
    {
        return;
    }
    if (!self.modelClass) {
        self.listArray = (NSMutableArray *)listArray;
        return;
    }
    _listArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in listArray)
    {
        YFBaseModel *model = [self.modelClass defaultWithYYModelDic:dic];
        [_listArray addObject:model];
    }
    
}



@end



