//
//  MOCycleView.h
//
//  Created by 馍馍帝 on 15/3/23.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOCycleViewDelegate;
@protocol MOCycleViewDatasource;

//自定义pageControl，改变圆点大小
@interface MOCustomPageContol : UIPageControl

@end

@interface MOCycleView : UIView<UIScrollViewDelegate>
@property(nonatomic,assign)BOOL shouldAutoScroll;
@property(nonatomic,strong)UIImageView *placeHolderImg;
@property(nonatomic,assign)id<MOCycleViewDelegate> delegate;
@property(nonatomic,assign,setter=setDatasource:)id<MOCycleViewDatasource> datasource;
@end

@protocol MOCycleViewDelegate <NSObject>

@optional

-(void)didSelectImage:(MOCycleView*)cView AtIndex:(NSInteger)index;

@end

@protocol MOCycleViewDatasource <NSObject>

@optional
-(UIColor *)setPageControlBackColorWithView:(MOCycleView*)cView;
-(UIColor *)setPageControlColorWithView:(MOCycleView*)cView;
-(CGRect)setPageControlWithView:(MOCycleView*)cView;
-(CGFloat)setPageControlSize:(MOCycleView*)cView;
-(void)cycleview:(MOCycleView*)cView didSelectViewAtIndex:(NSInteger)index;
@required
-(NSInteger)numberOfPageWithView:(MOCycleView*)cView;
-(UIView *)pageAtCView:(MOCycleView*)cView AtIndex:(NSInteger)index;

@end
