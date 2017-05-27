//
//  CountryChooseTextField.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/11/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QCTextField.h"

@interface CountryPhoneCell : UITableViewCell

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,copy)NSString *title;

@end

@interface CountryPhone : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *countryNo;

@end

@interface CountryPhoneInfo : NSObject

@property(nonatomic,strong)NSArray *countries;

+(instancetype)sharedInfo;

-(CountryPhone*)getCountryWithCode:(NSString *)code;

@end

@protocol CountryPhoneViewDelegate <NSObject>

-(void)chooseCountry:(CountryPhone*)country;

@end

@interface CountryPhoneView : UIView

@property(nonatomic,strong)CountryPhone *country;

@property(nonatomic,weak)id<CountryPhoneViewDelegate> delegate;

-(void)show;

-(void)close;

@end

@interface CountryChooseTextField : QCTextField

@property(nonatomic,strong)CountryPhone *country;

@end
