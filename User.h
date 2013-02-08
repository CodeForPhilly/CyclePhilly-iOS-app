//
//  User.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-2-8.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FlaggedLocation, Trip;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * cyclingFreq;
@property (nonatomic, retain) NSNumber * rider_history;
@property (nonatomic, retain) NSNumber * rider_type;
@property (nonatomic, retain) NSNumber * income;
@property (nonatomic, retain) NSNumber * ethnicity;
@property (nonatomic, retain) NSString * homeZIP;
@property (nonatomic, retain) NSString * schoolZIP;
@property (nonatomic, retain) NSString * workZIP;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSSet *flaggedlocations;
@property (nonatomic, retain) NSSet *trips;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFlaggedlocationsObject:(FlaggedLocation *)value;
- (void)removeFlaggedlocationsObject:(FlaggedLocation *)value;
- (void)addFlaggedlocations:(NSSet *)values;
- (void)removeFlaggedlocations:(NSSet *)values;

- (void)addTripsObject:(Trip *)value;
- (void)removeTripsObject:(Trip *)value;
- (void)addTrips:(NSSet *)values;
- (void)removeTrips:(NSSet *)values;

@end
