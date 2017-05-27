//
//  MOFormView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOFormViewDatasource;

@interface MOFormView : UIView

@property(nonatomic,strong)UIColor *lineColor;

@property(nonatomic,weak)id<MOFormViewDatasource> datasource;

-(void)reloadData;

@end

@protocol MOFormViewDatasource <NSObject>

-(NSInteger)numberOfSectionsOfFormView:(MOFormView*)formView;

-(NSInteger)numberOfRowsOfFormView:(MOFormView *)formView;

-(UIFont*)fontOfRowOfFormView:(MOFormView*)formView;

-(UIColor*)formView:(MOFormView*)formView colorForRowAtIndexPath:(NSIndexPath*)indexPath;

-(NSString*)formView:(MOFormView*)formView titleForRowAtIndexPath:(NSIndexPath*)indexPath;

@end
