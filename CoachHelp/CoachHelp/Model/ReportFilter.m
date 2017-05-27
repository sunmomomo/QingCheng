//
//  ReportFilter.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ReportFilter.h"

@implementation ReportFilter

-(void)setAllGroup:(BOOL)allGroup
{
    
    _allGroup = allGroup;
    
    if (_allGroup) {
        
        _allPrivate = NO;
        
        _course = nil;
        
    }
    
}

-(void)setAllPrivate:(BOOL)allPrivate
{
    
    _allPrivate = allPrivate;
    
    if (_allPrivate) {
        
        _allGroup = NO;
        
        _course = nil;
        
    }
    
}

-(void)setCourse:(Course *)course
{
    
    _course = course;
    
    if (_course) {
        
        _allGroup = NO;
        
        _allPrivate = NO;
        
    }
    
}

-(void)setCardKind:(CardKind *)cardKind
{
    
    _cardKind = cardKind;
    
    if (_cardKind) {
        
        _allTimeCardKind = NO;
        
        _allCountCardKind = NO;
        
        _allPrepaidCardKind = NO;
        
    }
    
}

-(void)setAllPrepaidCardKind:(BOOL)allPrepaidCardKind
{
    
    _allPrepaidCardKind = allPrepaidCardKind;
    
    if (_allPrepaidCardKind) {
        
        _allCountCardKind = NO;
        
        _allTimeCardKind = NO;
        
    }
    
}

-(void)setAllTimeCardKind:(BOOL)allTimeCardKind
{
    
    _allTimeCardKind = allTimeCardKind;
    
    if (_allTimeCardKind) {
        
        _allPrepaidCardKind = NO;
        
        _allCountCardKind = NO;
        
    }
    
}
-(void)setAllCountCardKind:(BOOL)allCountCardKind
{
    
    _allCountCardKind = allCountCardKind;
    
    if (_allPrepaidCardKind) {
        
        _allPrepaidCardKind = NO;
        
        _allTimeCardKind = NO;
        
    }
    
}
@end
