//
//  MKPointAnnotation+IndegoPointAnnotation.m
//  Cycle Philly
//
//  Created by Kathryn Killebrew on 7/12/15.
//
//

#import <objc/runtime.h>

#import "MKPointAnnotation+IndegoPointAnnotation.h"

@implementation MKPointAnnotation (IndegoPointAnnotation)
@dynamic stationStatus;

// associated objects icky hack required to add property for determining which marker icon to use
// http://nshipster.com/associated-objects/

- (void)setStationStatus:(NSString *)stationStatus {
    objc_setAssociatedObject(self, @selector(stationStatus), stationStatus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)stationStatus {
    return objc_getAssociatedObject(self, @selector(stationStatus));
}
@end
