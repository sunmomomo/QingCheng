//
//  CoverPictureView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CoverPictureViewDatasource;

@interface CoverPictureView : UIView

@property(nonatomic,weak)id<CoverPictureViewDatasource> datasource;

-(void)reload;

@end

@protocol CoverPictureViewDatasource <NSObject>

@required

-(NSInteger)pictureNumberOfCoverPicutreView:(CoverPictureView*)cview;

-(void)showAllPicture;

-(void)coverPictureView:(CoverPictureView*)cview pictureSelectedAtIndex:(NSInteger)index;

@optional

-(UIImage*)coverPictureView:(CoverPictureView*)cview pictureInIndex:(NSInteger)index;

-(NSURL*)coverPictureView:(CoverPictureView*)cview pictureURLInIndex:(NSInteger)index;

@end
