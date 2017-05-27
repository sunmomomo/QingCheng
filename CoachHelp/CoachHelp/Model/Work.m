//
//  Work.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "Work.h"

@implementation Work

-(id)copy
{
    
    Work *work = [[Work alloc]init];
    
    work.workId = self.workId;
    
    work.title = self.title;
    
    work.job = self.job;
    
    work.summary = self.summary;
    
    work.performance = self.performance;
    
    work.comRemark = self.comRemark;
    
    work.startTime = self.startTime;
    
    work.endTime = self.endTime;
    
    work.group_user = self.group_user;
    
    work.group_course = self.group_course;
    
    work.private_user = self.private_user;
    
    work.private_course = self.private_course;
    
    work.sale = self.sale;
    
    work.isVerified = self.isVerified;
    
    work.city = self.city;
    
    work.gym = self.gym;
    
    work.descriptions = self.descriptions;
    
    work.isHide = self.isHide;
    
    work.showGroup = self.showGroup;
    
    work.showPrivate = self.showPrivate;
    
    work.showSale = self.showSale;
    
    return work;

}

@end
