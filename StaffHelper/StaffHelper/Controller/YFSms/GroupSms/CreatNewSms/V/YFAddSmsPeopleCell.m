//
//  YFAddSmsPeopleCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAddSmsPeopleCell.h"

#import "YFSmsTagView.h"

@interface YFAddSmsPeopleCell ()


@end

@implementation YFAddSmsPeopleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.tagView];
    }
    return self;
}



- (YFTagView *)tagView
{
    if (_tagView == nil)
    {
        YFSmsTagView *tagView = [[YFSmsTagView alloc] initWithFrame:CGRectMake(10, 0, MSW - 20, 50)];
        
        tagView.tagPaddingSize = CGSizeMake(6, 12);
        
        [tagView setPreText:@"收件人:"];
        
        [tagView setAddButtonWithFrame:CGRectMake(0, 0, 26, 26)];
        
        [tagView.addButton setImage:[UIImage imageNamed:@"AddSmsPeo"] forState:UIControlStateNormal];
        
//        [tagView.addButton addTarget:self action:@selector(addTagAction:) forControlEvents:UIControlEventTouchUpInside];
//
//        [tagView addTags:@[
//                           @"dog",
//                           @"cat",
//                           @"pig",
//                           @"duck",
//                           @"horse",
//                           @"elephant",
//                           @"ant",
//                           @"fish",
//                           @"bird",
//                           @"engle",
//                           @"snake",
//                           @"mouse",
//                           @"squirrel",
//                           @"beaver",
//                           @"kangaroo",
//                           @"monkey",
//                           @"panda",
//                           @"bear",
//                           @"lion",
//                           ]];

        _tagView = tagView;
    }
    return _tagView;
}

- (void)addTagAction:(UIButton *)sender
{
    
}


@end
