//
//  DetailDelegate.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 12-11-8.
//
//

#import <Foundation/Foundation.h>

@protocol DetailDelegate <NSObject>

@required
- (NSString *)getPurposeString:(unsigned int)index;
- (NSString *)setPurpose:(unsigned int)index;

@optional
- (void)didCancelPurpose;
- (void)didPickPurpose:(unsigned int)index;

@end
