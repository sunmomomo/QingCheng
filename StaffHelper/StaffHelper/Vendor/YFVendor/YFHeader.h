//
//  YFHeader.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kPostAddOriginIdtifierYF;// 添加来源
extern NSString * const kPostAddOriginToMemeberIdtifierYF;// 给会员添加来源
extern NSString * const kPostAddRecomendToMemeberIdtifierYF;// 给会员添加推荐


extern NSString * const kPostModifyOrAddStudentIdtifierYF;// 修改或者添加会员
extern NSString * const kPostAddNewFollowingIdtifierYF;// 新增 来源
extern NSString * const kPostAddNewMemberIdtifierYF;// 新增 会员

extern NSString * const kPostAddNewSellerIdtifierYF;// 新增 销售

extern NSString * const kPostAddNewCoachIdtifierYF;// 新增 教练

extern NSString * const kPostDeleteMemberIdtifierYF;//删除 会员

extern NSString * const kPostAddNewStudentToSellerIdtifierYF;// 给销售添加 新的名下会员

extern NSString * const kPostAddNewStudentToCoachIdtifierYF;// 给教练添加 新的名下会员

extern NSString * const kPostSenderGroupSmsSuccessIdtifierYF;// 群发短信成功

extern NSString * const kPostSenderGroupDraftSmsSuccessIdtifierYF;// 群发短信草稿成功




extern NSString * const kPostDeleteSmsDraftSuccessIdtifierYF;// 删除 更新短信草稿
extern NSString * const kPostAddSmsDraftSuccessIdtifierYF;// 保存至 短信草稿
extern NSString * const kPostUpdataSmsDraftSuccessIdtifierYF;// 更新 短信草稿 不发送

extern NSString * const kPostUpdateCardValidTimeSuccessYF;


extern NSString * const kModifyGymDetailIdtifierYF;// 修改场馆信息
#define YFGenderKeyForParam @"gender"
#define YFStatusKeyForParam @"status"


extern NSString * const kAddNewGymIdtifierYF;// 新增场馆


@interface YFHeader : NSObject

@end
