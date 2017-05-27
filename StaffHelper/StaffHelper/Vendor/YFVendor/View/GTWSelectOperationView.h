//
//  GTWOperationView.h
//  GTW
//
//  Created by FengXingTianXia on 15-3-5.
//  Copyright (c) 2015年 xcode. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GTWSelectOperationViewHeight 47.0

@protocol GTWSelectOperationViewDelegate <NSObject>
// index 0 开始
- (void)operationViewDidSelectedIndex:(NSInteger)index selectedState:(BOOL)selectedState button:(UIButton *)button;

@end

@interface GTWSelectOperationView : UIView

@property(nonatomic, strong)NSArray *downSeleImageArray;
@property(nonatomic, strong)NSArray *upSeleImageArray;

@property (nonatomic,weak) id<GTWSelectOperationViewDelegate> delegate;
- (instancetype) initWithDataSource:(NSArray *)dataSource sepImage:(NSString *)sepImage delegate:(id)delegate font:(UIFont *)font;

- (instancetype) initWithDataSourceFY:(NSArray *)dataSource sepImage:(NSString *)sepImage delegate:(id)delegate font:(UIFont *)font;

- (instancetype)initWithDataSourceFY:(NSArray *)dataSource sepImageArray:(NSArray *)sepImageArray downImageArray:(NSArray *)sepImageDownArray delegate:(id)delegate font:(UIFont *)font;

- (instancetype)initWithDataSourceFY:(NSArray *)dataSource sepImageArray:(NSArray *)sepImageArray downImageArray:(NSArray *)sepImageDownArray delegate:(id)delegate font:(UIFont *)font allWidth:(CGFloat)allWidth;


-(void)setUnselectButtonFY;
-(void)setTitleValue:(NSString *)valueString;

-(void)setTitleValueToLastSelectButton:(NSString *)valueString;
-(void)setSelectButtonWithIndex:(NSUInteger)index;
-(void)setUnSelectButtonWithIndex:(NSUInteger)index;
-(void)setSelectButtonTitleWithIndex:(NSUInteger)index title:(NSString *)title;

- (BOOL)checkIsHaveSelect;
-(UIButton *)buttonWithIndex:(NSInteger )index;

-(void)setSelectButtonTitleWithIndex:(NSUInteger)index suitFrametitle:(NSString *)title;
-(void)setUnSelectButtonTitleWithIndex:(NSUInteger)index suitFrametitle:(NSString *)title;

-(void)setSelectButtonTitleWithIndex:(NSUInteger)index suitFrametitle:(NSString *)title maxWidth:(CGFloat)maxWidth;

@end

