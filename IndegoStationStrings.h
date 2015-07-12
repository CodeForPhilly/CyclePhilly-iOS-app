//
//  IndegoStationStrings.h
//  Cycle Philly
//
//  Created by Kathryn Killebrew on 7/12/15.
//
//

#ifndef Cycle_Philly_IndegoStationStrings_h
#define Cycle_Philly_IndegoStationStrings_h


#define kBikesAvailable			@"Bikes Available: "
#define kDocksAvailable			@"Open Docks: "
#define kEventStart             @"Event Start: "
#define kEventEnd               @"Event End: "

@interface IndegoStationStrings : NSObject 
+(NSDictionary*)getStatusDictionary;
@end

#endif
