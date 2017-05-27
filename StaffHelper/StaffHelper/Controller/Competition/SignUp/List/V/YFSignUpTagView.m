//
//  YFSignUpTagView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpTagView.h"

#import "YFTagSmsButton.h"

@implementation YFSignUpTagView

- (YFTagButton *)tagButtonWithTag:(NSString *)tag
{
    CGRect frame = [self setNewButtonframeWithTag:tag extraWidth:17];
    
    UIImageView *deleteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.height / 2.0 , (frame.size.height - 10) / 2.0, 12, 10)];
    [deleteImageView setImage:[UIImage imageNamed:@"signUpTag"]];
    
    YFTagSmsButton *tagBtn = [[YFTagSmsButton alloc] initWithFrame:frame imageFrame:CGRectZero titleFrame:CGRectMake(frame.size.height / 2.0 + 16, 0, frame.size.width - frame.size.height - 6, frame.size.height)];
    
    [tagBtn addSubview:deleteImageView];
    
    [self setButtonSetting:tagBtn];
    
    [tagBtn setTitle:tag forState:UIControlStateNormal];
    
    tagBtn.layer.cornerRadius = tagBtn.frame.size.height * 0.5f;
    tagBtn.layer.borderColor = RGB_YF(199, 199, 199).CGColor;
    tagBtn.layer.masksToBounds = YES;
    tagBtn.layer.borderWidth = OnePX;
    
    return tagBtn;
}
- (void)handlerButtonAction:(YFTagButton *)sender
{
    
}

@end
