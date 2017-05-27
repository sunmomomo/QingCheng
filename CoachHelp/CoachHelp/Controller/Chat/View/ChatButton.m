//
//  ChatButton.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatButton.h"

@implementation ChatButton

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
    
    if (self.touch) {
        
        self.touch();
        
    }
    
}

@end
