//
//  StudentCheckinPhotoController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Student.h"

@interface StudentCheckinPhotoController : MOViewController

@property(nonatomic,copy)void(^editFinish)();

@property(nonatomic,strong)Student *student;

@end
