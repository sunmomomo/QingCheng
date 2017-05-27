//
//  CardChooseStudentController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Student.h"

#import "CardKind.h"

@interface CardChooseStudentController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,strong)Card *card;

-(void)chooseStudent:(Student*)student;

@end
