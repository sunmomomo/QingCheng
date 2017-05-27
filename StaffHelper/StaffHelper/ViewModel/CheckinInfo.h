//
//  CheckinInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Checkin.h"

#import "Checkout.h"

@interface CheckinInfo : NSObject

@property(nonatomic,assign)NSUInteger checkinNum;

@property(nonatomic,assign)NSUInteger checkoutNum;

@property(nonatomic,assign)BOOL checkinNew;

@property(nonatomic,assign)BOOL checkoutNew;

@property(nonatomic,strong)NSArray *checkins;

@property(nonatomic,strong)NSArray *checkouts;

@property(nonatomic,strong)NSArray *students;

@property(nonatomic,copy)NSString *checkinQRCode;

@property(nonatomic,copy)NSString *checkoutQRCode;

@property(nonatomic,strong)Checkin *lastCheckin;

@property(nonatomic,strong)Checkout *lastCheckout;

@property(nonatomic,strong)Checkin *checkin;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestCheckinDataWithCheckin:(Checkin*)checkin result:(void(^)(BOOL success,NSString *error))result;

-(void)requestCheckoutDataWithCheckout:(Checkout *)checkout result:(void(^)(BOOL success,NSString *error))result;

-(void)checkinWithCheckin:(Checkin*)checkin result:(void(^)(BOOL success,NSString *error))result;

-(void)cancelCheckin:(Checkin*)checkin result:(void(^)(BOOL success,NSString *error))result;

-(void)requsetCheckDetailData:(Checkin*)checkin result:(void(^)(BOOL success,NSString *error))result;

-(void)requestQRCodeResult:(void(^)(BOOL success,NSString *error))result;

-(void)ignoreWithCheckin:(Checkin *)checkin result:(void (^)(BOOL, NSString *))result;

@end
