//
//  ImageResize.h
//  Cycle Atlanta
//
//  Created by Christopher Le Dantec on 3/23/13.
//
//

#import <Foundation/Foundation.h>

@interface ImageResize : NSObject

+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)targetSize;

@end
