//
//  YFTagView.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/6.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFTagButton.h"

@class YFTagView;
@protocol EYTagViewDelegate <NSObject>

-(void)heightDidChangedTagView:(YFTagView*)tagView;

/**
 *  @return whether delete
 */
@optional
-(BOOL)willRemoveTag:(YFTagView*)tagView index:(NSInteger)index;
@end

@interface YFTagView : UIView


@property (nonatomic, weak) id<EYTagViewDelegate> delegate;

@property(nonatomic, strong)NSMutableArray *tgButtonArray;

@property (nonatomic, assign) CGFloat tagHeight;//default

@property (nonatomic, assign) CGFloat viewMaxHeight;

@property (nonatomic) CGSize tagPaddingSize;//top & left
@property (nonatomic) CGSize textPaddingSize;

@property (nonatomic, strong) UIFont *fontTag;
@property (nonatomic, strong) UIFont *fontInput;

@property (nonatomic, strong) UIColor* colorSelectText;
@property (nonatomic, strong) UIColor *colorTextTag;

@property (nonatomic, strong) UIColor *colorTagNomalBg;
@property (nonatomic, strong) UIColor *colorTagSelectedBg;


@property (nonatomic, strong) UIColor *colorTagBoardNomal;
@property (nonatomic, strong) UIColor *colorTagBoardSelect;

@property(nonatomic, strong)UIButton *addButton;

// 从哪个位置开始 排列
@property(nonatomic, assign)CGFloat beginxx;

- (void)addTags:(NSArray *)tags;

- (void)addTagModels:(NSMutableArray *)tags;

@property(nonatomic, copy)NSString *(^titleBlock)(id);

- (void)setPreText:(NSString *)preDesText;

- (void)setAddButtonWithFrame:(CGRect)frame;

- (void)removeAllTag;

- (YFTagButton *)tagButtonWithTag:(NSString *)tag;

- (void)setButtonSetting:(YFTagButton *)tagBtn;

- (CGRect)setNewButtonframeWithTag:(NSString *)tag extraWidth:(CGFloat)extraWidth;

- (void)removeTagWithIndex:(NSInteger)index;
@end
