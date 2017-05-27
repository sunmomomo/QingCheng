//
//  YFSignUpGroupMemCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupMemCModel.h"

#import "YYModel.h"

#import "YFSignUpGroupMemCell.h"

#import "NSMutableDictionary+YFExtension.h"

@interface YFSignUpGroupMemCModel ()<YYModel>
@property(nonatomic, assign)CGFloat nameWidth;

@end

static NSString *yFSignUpGroupMemCell = @"YFSignUpGroupMemCell";


@implementation YFSignUpGroupMemCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
    }
    return self;
}

- (void)cellSettingYF
{
    self.cellIdentifier = yFSignUpGroupMemCell;
    self.cellClass = [YFSignUpGroupMemCell class];
    self.cellHeight = 79.0;
    self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFSignUpGroupMemCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.nameLabel.text = self.username;
    baseCell.phoneLabel.text = self.phone;
    baseCell.nameLabel.text = self.username;
    
    [baseCell.nameLabel changeWidth:self.nameWidth];
    
    [baseCell.sexImageView layoutIfNeeded];
    [baseCell.sexImageView setImage:[YFBaseCModel sexImageWithGender:self.gender]];
    
    [baseCell.headImageView sd_setImageWithURL:self.avatar placeholderImage:[YFBaseCModel placeHolderImageWithGender:self.gender]];

}

#pragma mark Data
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"p_id":@"id"
             };
}

- (CGFloat)nameWidth
{
    if (_nameWidth == 0)
    {
        YFSignUpGroupMemCell *weakCell = (YFSignUpGroupMemCell *)self.weakCell;
        CGSize size = YF_MULTILINE_TEXTSIZE(self.username, weakCell.nameLabel.font, CGSizeMake(150, weakCell.nameLabel.height), 0);
        
        return ceil(size.width);
    }
    return _nameWidth;
}

- (NSDictionary *)toJsonDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject_FY:self.p_id forKey:@"id"];
    [dic setObject_FY:self.avatar forKey:@"avatar"];
    [dic setObject_FY:self.gender forKey:@"gender"];
    [dic setObject_FY:self.username forKey:@"username"];
    [dic setObject_FY:self.phone forKey:@"phone"];

    return dic;
}


@end
