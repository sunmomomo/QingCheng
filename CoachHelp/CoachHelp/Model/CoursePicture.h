//
//  CoursePicture.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoursePicture : NSObject

@property(nonatomic,copy)NSString *uploadStaffName;

@property(nonatomic,copy)NSString *canSeeUserName;

@property(nonatomic,copy)NSString *uploadTime;

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,assign)BOOL isPrivate;

@end
