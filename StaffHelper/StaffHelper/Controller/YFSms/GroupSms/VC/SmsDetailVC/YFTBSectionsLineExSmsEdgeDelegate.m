//
//  YFTBSectionsLineExSmsEdgeDelegate.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsLineExSmsEdgeDelegate.h"

@implementation YFTBSectionsLineExSmsEdgeDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([UIMenuController sharedMenuController].isMenuVisible)
    {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
}

@end
