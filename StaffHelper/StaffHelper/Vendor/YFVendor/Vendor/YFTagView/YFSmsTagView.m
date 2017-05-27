//
//  YFSmsTagView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsTagView.h"

#import "YFTagSmsButton.h"

@implementation YFSmsTagView

- (YFTagButton *)tagButtonWithTag:(NSString *)tag
{
    CGRect frame = [self setNewButtonframeWithTag:tag extraWidth:14];
    
    
    UIImageView *deleteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 14, (frame.size.height - 8) / 2.0, 8, 8)];
    [deleteImageView setImage:[UIImage imageNamed:@"SmsDelete"]];
    deleteImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteGestureAction:)];
    
    [deleteImageView addGestureRecognizer:tapGes];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(deleteImageView.left - 4, (frame.size.height - 16) / 2.0, OnePX, 16)];
    lineView.backgroundColor = RGB_YF(106, 127, 164);
    
    YFTagSmsButton *tagBtn = [[YFTagSmsButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height) imageFrame:CGRectZero titleFrame:CGRectMake(frame.size.height / 2.0, 0, frame.size.width - frame.size.height - 6, frame.size.height)];
    
    [tagBtn addSubview:deleteImageView];
    
    [tagBtn addSubview:lineView];
    
    [self setButtonSetting:tagBtn];
    
    [tagBtn setTitle:tag forState:UIControlStateNormal];
    
    tagBtn.layer.cornerRadius = tagBtn.frame.size.height * 0.5f;
    tagBtn.layer.borderColor = RGB_YF(125, 146, 179).CGColor;
    tagBtn.layer.masksToBounds = YES;
    tagBtn.layer.borderWidth = OnePX;
    
    return tagBtn;
}
- (void)deleteGestureAction:(UITapGestureRecognizer *)tapGes
{
    UIView *tapView = [tapGes view];
    
    YFTagButton *tagButton = (YFTagButton *)[tapView superview];
    
    NSInteger index = [self.tgButtonArray indexOfObject:tagButton];

    if (index >= 0 && index < self.tgButtonArray.count)
    {
    [self removeTagWithIndex:index];
    }
}

- (void)handlerButtonAction:(YFTagButton *)sender
{
    
}

@end
