//
//  QCTextField.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "MOTextField.h"

typedef enum : NSUInteger {
    QCTextFieldTypeDefault,
    QCTextFieldTypeCell,
} QCTextFieldType;

@protocol QCTextFieldDelegate;

@interface QCTextField : MOTextField

@property(nonatomic,strong,setter=setLeftImg:)UIImage *leftImg;

@property(nonatomic,copy)NSString *unit;

@property(nonatomic,assign)BOOL mustInput;

@property(nonatomic,assign)QCTextFieldType type;

@property(nonatomic,assign)BOOL leftChoose;

@property(nonatomic,copy)NSString *textPlaceholder;

@property(nonatomic,weak)id<QCTextFieldDelegate> qcdelegate;

@property(nonatomic,strong,setter=setPlaceholderColor:)UIColor *placeholderColor;

@end

@protocol QCTextFieldDelegate <NSObject>

@optional

-(void)QCTextFieldLeftClick:(QCTextField*)textfield;

@end
