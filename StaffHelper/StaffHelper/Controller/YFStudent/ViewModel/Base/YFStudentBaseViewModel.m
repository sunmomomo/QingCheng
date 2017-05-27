//
//  YFStudentBaseViewModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentBaseViewModel.h"

#import "Parameters.h"

#import "NSMutableDictionary+YFExtension.h"

#define API @"/api/staffs/%ld/group/messages/"

#define UpdataAPI @"/api/staffs/%ld/group/message/detail/"


#import "YFSmsListCModel.h"

@implementation YFStudentBaseViewModel
{
    NSString *_user_ids;
}

- (void)getResponseDatashowLoadingOn:(UIView *)superView successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
}



- (void)sendSMSDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:gym];
    
    [para setParameter:_user_ids forKey:@"user_ids"];
    
    [para setParameter:_content forKey:@"content"];
    
    [para.data setObje_FY:_send toKey:@"send"];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    [YFHttpService postSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        if (successBlock) {
            successBlock();
        }
        
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

- (void)updateSMSDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:gym];
    
    [para setParameter:_user_ids forKey:@"user_ids"];
    
    [para setParameter:_content forKey:@"content"];
    
    [para.data setObje_FY:_send toKey:@"send"];
    
    [para.data setObje_FY:self.message_id toKey:@"message_id"];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:UpdataAPI,StaffId]];
    
    [YFHttpService putSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        if (successBlock) {
            successBlock();
        }
        
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}


- (BOOL)setChooseArrayForIds:(NSArray *)array
{
    NSMutableString *idsStr = [NSMutableString string];
    for (Student *stu in array)
    {
        if (stu.stuId) {
        [idsStr appendFormat:@"%@,",@(stu.stuId)];
        }
    }
    _user_ids = idsStr;
    if (_user_ids.length <= 0)
    {
        return NO;
    }else
    {
        return YES;
    }
}



@end
