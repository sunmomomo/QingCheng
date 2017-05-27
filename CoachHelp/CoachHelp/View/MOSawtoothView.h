//
//  MOSawtoothView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/22.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MOSeparatorType) {
    MOSeparatorTypeStraight,
    MOSeparatorTypeJagged,
    MOSeparatorTypeNone
};

typedef NS_ENUM(NSUInteger, MOSeparatorPosition) {
    MOSeparatorPositionTop,
    MOSeparatorPositionBottom
};

@interface MOSawtoothView : UIView

@property (nonatomic, assign) MOSeparatorType topSeparatorType;
@property (nonatomic, assign) MOSeparatorType bottomSeparatorType;

@property (nonatomic, assign) NSUInteger jaggedEdgeHorizontalVertexDistance;
@property (nonatomic, assign) NSUInteger jaggedEdgeVerticalVertexDistance;

@property (nonatomic, assign) CGFloat topBorderWidth;
@property (nonatomic, assign) CGFloat bottomBorderWidth;

@property (nonatomic, strong) UIColor *topStrokeColor;
@property (nonatomic, strong) UIColor *bottomStrokeColor;

@property (nonatomic, strong) UIColor *fillColor;

/**
 * Initializes a view with the separator types.
 
 @param frame The frame of the separator view. This should usually just be set to the frame of its superview.
 @param topLineSeparatorType The type of separator at the top of the separator view.
 @param bottomLineSeparatorType The type of separator at the bottom of the separator view.
 @return A seperator view with the specified frame and top and bottom separators.
 */
- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(MOSeparatorType)topLineSeparatorType
      bottomLineSeparatorType:(MOSeparatorType)bottomLineSeparatorType;


/**
 * Sets the top and bottom separator types of the reciever
 
 @param topLineSeparatorType The type of separator at the top of the separator view.
 @param bottomLineSeparatorType The type of separator at the bottom of the separator view.
 */
- (void)setTopLineSeparatorType:(MOSeparatorType)topLineSeparatorType
        bottomLineSeparatorType:(MOSeparatorType)bottomLineSeparatorType;

@end