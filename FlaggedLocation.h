//
//  FlaggedLocation.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-2-8.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface FlaggedLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSDate * recorded;
@property (nonatomic, retain) NSString * flag_type;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * vAccuracy;
@property (nonatomic, retain) NSNumber * hAccuracy;
@property (nonatomic, retain) NSNumber * altitude;
@property (nonatomic, retain) User *user;

@end
