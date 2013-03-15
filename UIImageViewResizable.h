//
//  UIImageViewResizable.h
//
//  Created by Mike Valstar on 2012-09-10.
//

#import <UIKit/UIKit.h>

@interface UIImageViewResizable : UIImageView <UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer *panGesture;
}

@property(nonatomic) BOOL isZoomable;

- (void) applyGestures;
- (void) scaleToMinimum;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)pan:(UIPanGestureRecognizer *)gesture;
- (void)doubleTap:(UITapGestureRecognizer *)gesture;

@end