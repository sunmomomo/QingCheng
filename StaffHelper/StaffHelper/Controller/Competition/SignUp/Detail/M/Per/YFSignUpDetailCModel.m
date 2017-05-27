//
//  YFSignUpDetailCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpDetailCModel.h"

#import "YFSignUpDetailCell.h"

#import "YFDateService.h"

static NSString *yFSignUpDetailCell = @"YFSignUpDetailCell";


@implementation YFSignUpDetailCModel
{
    NSMutableAttributedString *_priceAttri;
}


- (NSInteger)beginDays
{
    
    if (!self.start)
    {
        return -1;
    }
    return [YFDateService calcDaysCurrentToDateString:self.start];
}

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFSignUpDetailCell;
        self.cellClass = [YFSignUpDetailCell class];
        self.cellHeight = 173.0;
        self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        _priceAttri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"报名费用：%@元",self.price]];
        
        [_priceAttri addAttribute:NSFontAttributeName value:FontSizeFY(15) range:NSMakeRange(0, _priceAttri.length)];

        [_priceAttri addAttribute:NSForegroundColorAttributeName value:YFCellSubGrayTitleColor range:NSMakeRange(0,5)];

        [_priceAttri addAttribute:NSForegroundColorAttributeName value:RGB_YF(249, 148, 78) range:NSMakeRange(5, _priceAttri.length - 5)];

        
        self.created_at = [self.created_at stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}


- (void)setCell:(YFSignUpDetailCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell.signUpTagView setTitleBlock:^NSString *(YFTeamCModel *model) {
        return model.name;
    }];
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFSignUpDetailCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.signUpTimeLabel.text = [NSString stringWithFormat:@"报名时间：%@",self.created_at];
    baseCell.signUpPayLabel.attributedText = _priceAttri;

    if (self.teams.count) {
        baseCell.signUpTagView.hidden = NO;
        [baseCell.signUpTagView removeAllTag];
        [baseCell.signUpTagView addTagModels:self.teams];
        self.cellHeight = baseCell.signUpTagView.bottom + 12;
    }else
    {
        baseCell.signUpTagView.hidden = YES;
        self.cellHeight = baseCell.signUpTagView.top + baseCell.signUpTagView.tagPaddingSize.height * 2 + baseCell.signUpTagView.tagHeight;
    }
}


- (YFSignUpAttendanceEmptyCModel *)attendanceNotBegin
{
    if (!_attendanceNotBegin)
    {
        _attendanceNotBegin = [YFSignUpAttendanceEmptyCModel defaultWithYYModelDic:nil];
    }
    return _attendanceNotBegin;
}

+ (instancetype)creatDetailModel
{
    NSDictionary *dataDic = @{@"id":@(1),
                              @"gender":@(0),
                              @"username":@"陈驰远",
                              @"phone":@"1234111111",
                              @"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png",
                              @"created_at":@"2016-03-04T09:20",
                              @"price":@(100),
                              @"teams":@[@{@"id":@(1),
                                           @"name":@"kent",
                                           },
                                         @{@"id":@(2),
                                           @"name":@"沉池园",
                                           },
                                         @{@"id":@(3),
                                           @"name":@"向鸿儒",
                                           },
                                         @{@"id":@(1),
                                           @"name":@"kent",
                                           },
                                         @{@"id":@(2),
                                           @"name":@"沉池园",
                                           },
                                         @{@"id":@(3),
                                           @"name":@"向鸿儒",
                                           }],
                              @"attendance":@{
                                      @"days":@{
                                              @"count":@(56742),
                                              @"rank_country":@(3000),
                                              @"rank_gym":@(2000),
                                              },
                                      @"private_course":@{
                                              @"count":@(556),
                                              @"rank_country":@(2002),
                                              @"rank_gym":@(4),
                                              },
                                      @"group_course":@{
                                              @"count":@(12),
                                              @"rank_country":@(2009),
                                              @"rank_gym":@(12),
                                              },
                                      @"checkin":@{
                                              @"count":@(1),
                                              @"rank_country":@(2030),
                                              @"rank_gym":@(30),
                                              },
                                      },
                              };
    
    
    YFSignUpDetailCModel *model = [YFSignUpDetailCModel defaultWithYYModelDic:dataDic];
    
    return model;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}


@end
