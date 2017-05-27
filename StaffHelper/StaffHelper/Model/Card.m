//
//  Card.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Card.h"

@implementation Card

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cardKind = [[CardKind alloc]init];
        
    }
    return self;
}

-(id)copy
{
    
    Card *card = [[Card alloc]init];
    
    card.users = [self.users copy];
    
    card.cardId = self.cardId;
    
    card.cardName = self.cardName;
    
    card.cardNumber = self.cardNumber;
    
    card.remain = self.remain;
    
    card.checkValid = self.checkValid;
    
    card.color = self.color;
    
    card.start = self.start;
    
    card.end = self.end;
    
    card.cardKind = self.cardKind;
    
    card.validFrom = self.validFrom;
    
    card.validTo = self.validTo;
    
    card.trial_days = self.trial_days;
    
    return card;
    
}

- (NSString *)getStartTimeYF
{
    return self.cardKind.type == CardKindTypeTime?self.start:self.validFrom;
}

- (NSString *)getEndTimeYF
{
 return self.cardKind.type == CardKindTypeTime?self.end:self.validTo;
}

@end
