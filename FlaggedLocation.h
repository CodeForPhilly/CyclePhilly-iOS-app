//
//  FlaggedLocation.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-2-1.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trip, User;

@interface FlaggedLocation : NSManagedObject

@property (nonatomic, retain) NSDate * recorded;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * altitude;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * hAccuracy;
@property (nonatomic, retain) NSNumber * vAccuracy;
@property (nonatomic, retain) NSString * flag_type;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Trip *trip;

@end
