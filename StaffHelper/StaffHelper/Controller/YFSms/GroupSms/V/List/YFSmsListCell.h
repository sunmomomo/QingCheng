//
//  YFSmsListCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFButton.h"

@interface YFSmsListCell : YFBaseCell

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UILabel *desLabel;

@property(nonatomic, strong)UILabel *timeLabel;

@property(nonatomic, strong)UIImageView *arrowImageView;

@property(nonatomic, strong)YFButton *indicDraftButton;

@property(nonatomic, strong)YFButton *indicSenedButton;

- (void)fitFrame;

@end
