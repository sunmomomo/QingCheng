//
//  Meeting.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meeting : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSURL *link;

@property(nonatomic,copy)NSURL *image;

@end
