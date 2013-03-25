/** Cycle Atlanta, Copyright 2012, 2013 Georgia Institute of Technology
 *                                    Atlanta, GA. USA
 *
 *   @author Christopher Le Dantec <ledantec@gatech.edu>
 *   @author Anhong Guo <guoanhong@gatech.edu>
 *
 *   Cycle Atlanta is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Cycle Atlanta is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Cycle Atlanta.  If not, see <http://www.gnu.org/licenses/>.
 */

//
//  UIImageViewResizable.m
//
//  Created by Mike Valstar on 2012-09-10.
//

#import "UIImageViewResizable.h"

#define MINIMUM_SCALE 1.0
#define MAXIMUM_SCALE 4.0

@implementation UIImageViewResizable

@synthesize isZoomable;

/********************
 Public Methods
 *******************/
-(void) scaleToMinimum{
    CGAffineTransform transform = CGAffineTransformMakeScale(MINIMUM_SCALE, MINIMUM_SCALE);
    self.transform = transform;
    
    //check center and move if outside bounds
    CGPoint newCenter = CGPointMake(self.frame.origin.x + (self.frame.size.width / 2),
                                    self.frame.origin.y + (self.frame.size.height / 2));
    newCenter = [self constrictToBounds:newCenter];
    self.frame = CGRectMake(newCenter.x - (self.frame.size.width / 2),
                            newCenter.y - (self.frame.size.height / 2),
                            self.frame.size.width,
                            self.frame.size.height);
    
    [self removeGestureRecognizer:panGesture]; // remove pan gesture when zoomed out
}

-(void) applyGestures{
    self.userInteractionEnabled = YES;
    
    // Pinch
    UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(pinch:)];
    pgr.delegate = self;
    [self addGestureRecognizer:pgr];
    
    // Pan
    panGesture = [[UIPanGestureRecognizer alloc]
                  initWithTarget:self action:@selector(pan:)];
    panGesture.delegate = self;
    //[self addGestureRecognizer:panGesture]; // Do not add right away wait until zoomed
    
    // Double Tap
    UITapGestureRecognizer *dtgr = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(doubleTap:)];
    dtgr.numberOfTapsRequired = 2;
    dtgr.delegate = self;
    [self addGestureRecognizer:dtgr];
}

/********************
 Gestures
 *******************/

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if (isZoomable == NO) return;
    if (gesture.state == UIGestureRecognizerStateEnded
        || gesture.state == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = self.frame.size.width / self.bounds.size.width;
        CGFloat newScale = currentScale * gesture.scale;
        [self addGestureRecognizer:panGesture];
        
        if (newScale < MINIMUM_SCALE) {
            newScale = MINIMUM_SCALE;
            [self removeGestureRecognizer:panGesture]; // remove pan gesture when zoomed out
        }
        if (newScale > MAXIMUM_SCALE) {
            newScale = MAXIMUM_SCALE;
        }
        
        CGAffineTransform transform = CGAffineTransformMakeScale(newScale, newScale);
        self.transform = transform;
        gesture.scale = 1;
        
        //check center and move if outside bounds
        CGPoint newCenter = CGPointMake(self.frame.origin.x + (self.frame.size.width / 2),
                                        self.frame.origin.y + (self.frame.size.height / 2));
        newCenter = [self constrictToBounds:newCenter];
        self.frame = CGRectMake(newCenter.x - (self.frame.size.width / 2),
                                newCenter.y - (self.frame.size.height / 2),
                                self.frame.size.width,
                                self.frame.size.height);
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    if (isZoomable == NO) return;
    CGFloat currentScale = self.frame.size.width / self.bounds.size.width;
    CGPoint translation = [gesture translationInView:self];
    CGPoint newCenter = CGPointMake(gesture.view.center.x + (translation.x * currentScale),
                                    gesture.view.center.y + (translation.y * currentScale));
    
    newCenter = [self constrictToBounds:newCenter];
    
    gesture.view.center = newCenter;
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
    
}

- (void)doubleTap:(UITapGestureRecognizer *)gesture {
    NSLog(@"double tap detected");
    if (isZoomable == NO) return;
    CGFloat currentScale = self.frame.size.width / self.bounds.size.width;
    if(ceil(currentScale) != ceil(MAXIMUM_SCALE)){
        CGAffineTransform transform = CGAffineTransformMakeScale(MAXIMUM_SCALE, MAXIMUM_SCALE);
        self.transform = transform;
        [self addGestureRecognizer:panGesture];
    }else{
        CGAffineTransform transform = CGAffineTransformMakeScale(MINIMUM_SCALE, MINIMUM_SCALE);
        self.transform = transform;
        [self removeGestureRecognizer:panGesture]; // remove pan gesture when zoomed out
    }
}

/********************
 Internal Methods
 *******************/

// Check the bounding box for the resize point
- (CGPoint)constrictToBounds:(CGPoint)point{
    CGFloat lowerXBound  =  ceil(self.bounds.size.width - ( self.frame.size.width / 2 ));
    CGFloat higherXBound = floor(lowerXBound + (self.frame.size.width - self.bounds.size.width));
    
    CGFloat lowerYBound  = ceil(self.bounds.size.height - ( self.frame.size.height / 2 ));
    CGFloat higherYBound = floor(lowerYBound + (self.frame.size.height - self.bounds.size.height));
    
    if ( point.x < lowerXBound)
        point.x = lowerXBound;
    if ( point.x > higherXBound )
        point.x = higherXBound;
    if ( point.y < lowerYBound)
        point.y = lowerYBound;
    if ( point.y > higherYBound )
        point.y = higherYBound;
    
    return point;
}

@end