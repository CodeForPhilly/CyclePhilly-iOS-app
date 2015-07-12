//
//  IndegoStationStrings.m
//  Cycle Philly
//
//  Created by Kathryn Killebrew on 7/12/15.
//
//

#import <Foundation/Foundation.h>
#import "IndegoStationStrings.h"

@implementation IndegoStationStrings

+(NSDictionary*)getStatusDictionary {
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @{
                 @"Active": @"Active",
                 @"Unavailable": @"Unavailable",
                 @"PartialService": @"Partial Service",
                 @"ComingSoon": @"Coming Soon",
                 @"SpecialEvent": @"Special Event"
                 };
    });
    return inst;
}

@end

