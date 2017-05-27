//
//  MOSawtoothView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/22.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOSawtoothView.h"

#define DefaultFillColor [UIColor lightGrayColor]
#define DefaultStrokeColor [UIColor grayColor]

static CGFloat DefaultBorderWidth = 0.50f;
static NSInteger DefaultJaggedEdgeHorizontalVertexDistance = 6;
static NSInteger DefaultJaggedEdgeVerticalVertexDistance = 5;

@implementation MOSawtoothView

- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(MOSeparatorType)topLineSeparatorType
      bottomLineSeparatorType:(MOSeparatorType)bottomLineSeparatorType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        _topSeparatorType       = topLineSeparatorType;
        _bottomSeparatorType    = bottomLineSeparatorType;
    }
    return self;
}

- (void)setTopLineSeparatorType:(MOSeparatorType)topLineSeparatorType
        bottomLineSeparatorType:(MOSeparatorType)bottomLineSeparatorType
{
    self.topSeparatorType       = topLineSeparatorType;
    self.bottomSeparatorType    = bottomLineSeparatorType;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *topStrokeColor  = self.topStrokeColor ?: DefaultStrokeColor;
    UIColor *bottomStrokeColor  = self.bottomStrokeColor ?: DefaultStrokeColor;
    
    CGFloat topBorderWidth = self.topBorderWidth ?: DefaultBorderWidth;
    CGFloat bottomBorderWidth = self.bottomBorderWidth ?: DefaultBorderWidth;
    
    switch (self.topSeparatorType) {
        case MOSeparatorTypeStraight:
            [self drawSeparatorAtPosition:MOSeparatorPositionTop
                                     type:MOSeparatorTypeStraight
                              strokeColor:topStrokeColor
                              borderWidth:topBorderWidth];
            break;
        case MOSeparatorTypeJagged:
            [self drawSeparatorAtPosition:MOSeparatorPositionTop
                                     type:MOSeparatorTypeJagged
                              strokeColor:topStrokeColor
                              borderWidth:topBorderWidth];
            break;
        default:
            break;
    }
    switch (self.bottomSeparatorType) {
        case MOSeparatorTypeStraight:
            [self drawSeparatorAtPosition:MOSeparatorPositionBottom
                                     type:MOSeparatorTypeStraight
                              strokeColor:bottomStrokeColor
                              borderWidth:bottomBorderWidth];
            break;
        case MOSeparatorTypeJagged:
            [self drawSeparatorAtPosition:MOSeparatorPositionBottom
                                     type:MOSeparatorTypeJagged
                              strokeColor:bottomStrokeColor
                              borderWidth:bottomBorderWidth];
            break;
        default:
            break;
    }
}

- (void)drawSeparatorAtPosition:(MOSeparatorPosition)position
                           type:(MOSeparatorType)type
                    strokeColor:(UIColor *)strokeColor
                    borderWidth:(CGFloat)borderWidth
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = borderWidth;
    NSInteger x = 0;
    NSInteger y = (position == MOSeparatorPositionTop) ? borderWidth : CGRectGetHeight(self.frame) - borderWidth;
    [path moveToPoint:CGPointMake(x, y)];
    
    if (type == MOSeparatorTypeJagged) {
        NSUInteger verticalDisplacement = self.jaggedEdgeVerticalVertexDistance ?: DefaultJaggedEdgeVerticalVertexDistance;
        NSUInteger horizontalDisplacement = self.jaggedEdgeHorizontalVertexDistance ?: DefaultJaggedEdgeHorizontalVertexDistance;
        verticalDisplacement *= (position == MOSeparatorPositionTop) ? +1 : -1;
        BOOL shouldMoveUp = YES;
        while (x <= CGRectGetWidth(self.frame)) {
            x += horizontalDisplacement;
            if (shouldMoveUp) {
                y += verticalDisplacement;
            }
            else {
                y -= verticalDisplacement;
            }
            [path addLineToPoint:CGPointMake(x, y)];
            shouldMoveUp = !shouldMoveUp;
        }
    }
    else if (type == MOSeparatorTypeStraight) {
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), y)];
    }
    
    CGFloat offSet = 2 * borderWidth;
    
    x = CGRectGetWidth(self.frame) + offSet;
    y = (position == MOSeparatorPositionTop) ? -offSet : CGRectGetHeight(self.frame) + offSet;
    [path addLineToPoint:CGPointMake(x,y)];
    
    x = -offSet;
    [path addLineToPoint:CGPointMake(x, y)];
    
    [strokeColor setStroke];
    [self drawBezierPath:path];
}

- (void)drawBezierPath:(UIBezierPath *)path
{
    UIColor *fillColor = self.fillColor ?: DefaultFillColor;
    [fillColor setFill];
    [path closePath];
    [path fill];
    [path stroke];
}

@end

