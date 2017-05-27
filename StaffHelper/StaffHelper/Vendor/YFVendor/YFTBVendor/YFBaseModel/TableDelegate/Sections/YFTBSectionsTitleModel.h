//
//  YFTBSectionsTitleModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSectionsModel.h"

@interface YFTBSectionsTitleModel : YFTBSectionsModel

@property(nonatomic,assign)CGFloat xxOffset;
@property(nonatomic,assign)CGFloat yyOffset;

@property(nonatomic,assign)CGFloat headReaHeight;

@property(nonatomic,copy)NSString *sectionTitle;

@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,strong)UIColor *headViewBaColor;

@property(nonatomic,strong)UIFont *font;

@property(nonatomic, weak)UIView *subViewOfHeaderView;

/**
 * 默认 dataarray.count = 0,不显示，YES 显示
 */
@property(nonatomic, assign)BOOL isAlwaysShowHeadView;

-(void)setStudentFilter;


-(void)setFollowinFilter;

-(void)setGrayViewHeight:(CGFloat)height;

@end
