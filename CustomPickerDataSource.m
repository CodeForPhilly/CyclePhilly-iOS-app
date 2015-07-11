/** Cycle Philly, 2013 Code For Philly
 *                                    Philadelphia, PA. USA
 *
 *
 *   Contact: Corey Acri <acri.corey@gmail.com>
 *            Lloyd Emelle <lemelle@codeforamerica.org>
 *
 *   Updated/Modified for Philadelphia's app deployment. Based on the
 *   Cycle Atlanta and CycleTracks codebase for SFCTA.
 *
 * Cycle Atlanta, Copyright 2012, 2013 Georgia Institute of Technology
 *                                    Atlanta, GA. USA
 *
 *   @author Christopher Le Dantec <ledantec@gatech.edu>
 *   @author Anhong Guo <guoanhong@gatech.edu>
 *
 *   Updated/Modified for Atlanta's app deployment. Based on the
 *   CycleTracks codebase for SFCTA.
 *
 ** CycleTracks, Copyright 2009,2010 San Francisco County Transportation Authority
 *                                    San Francisco, CA, USA
 *
 *   @author Matt Paul <mattpaul@mopimp.com>
 *
 *   This file is part of CycleTracks.
 *
 *   CycleTracks is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   CycleTracks is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with CycleTracks.  If not, see <http://www.gnu.org/licenses/>.
 */

//
//  CustomPickerDataSource.m
//  CycleTracks
//
//  Copyright 2009-2010 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 9/22/09.
//	For more information on the project, 
//	e-mail Billy Charlton at the SFCTA <billy.charlton@sfcta.org>

#import "CustomPickerDataSource.h"
#import "CustomView.h"
#import "TripPurposeDelegate.h"

@implementation CustomPickerDataSource

@synthesize customPickerArray, pickerTitles, pickerImages, parent;

- (id)init {
	// use predetermined frame size
	self = [super init];
	if (!self) return self;
    
    pickerCategory = [[NSUserDefaults standardUserDefaults] integerForKey:@"pickerCategory"];
        
    if (IOS_6_OR_EARLIER) {
        // setup for picker on ios 5/6
        
        // create the data source for this custom picker
        NSMutableArray *viewArray = [[NSMutableArray alloc] init];
        CustomView *view;
        
        if (pickerCategory == 0) {
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Commute";
            view.image = [UIImage imageNamed:kTripPurposeCommuteIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"School";
            view.image = [UIImage imageNamed:kTripPurposeSchoolIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Work-Related";
            view.image = [UIImage imageNamed:kTripPurposeWorkIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Exercise";
            view.image = [UIImage imageNamed:kTripPurposeExerciseIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Social";
            view.image = [UIImage imageNamed:kTripPurposeSocialIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Shopping";
            view.image = [UIImage imageNamed:kTripPurposeShoppingIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Errand";
            view.image = [UIImage imageNamed:kTripPurposeErrandIcon];
            [viewArray addObject:view];
            [view release];
            
            view = [[CustomView alloc] initWithFrame:CGRectZero];
            view.title = @"Other";
            view.image = [UIImage imageNamed:kTripPurposeOtherIcon];
            [viewArray addObject:view];
            [view release];
        }
        
        self.customPickerArray = viewArray;
        [viewArray release];
            
    } else {
        // ios7 or later
        if (pickerCategory == 0) {
            self.pickerTitles = [NSArray arrayWithObjects:@"Commute", @"School", @"Work-Related", @"Exercise", @"Social", @"Shopping", @"Errand", @"Other", nil];
            self.pickerImages = [NSArray arrayWithObjects: [UIImage imageNamed:kTripPurposeCommuteIcon], [UIImage imageNamed:kTripPurposeSchoolIcon],
                                 [UIImage imageNamed:kTripPurposeWorkIcon], [UIImage imageNamed:kTripPurposeExerciseIcon], [UIImage imageNamed:kTripPurposeSocialIcon],
                                 [UIImage imageNamed:kTripPurposeShoppingIcon], [UIImage imageNamed:kTripPurposeErrandIcon], [UIImage imageNamed:kTripPurposeOtherIcon], nil];
        }
    }
    return self;
}

- (void)dealloc
{
    [pickerTitles release];
    [pickerImages release];
	[customPickerArray release];
	[super dealloc];
}


#pragma mark UIPickerViewDataSource

/////////
// method definitions for iOS 5/6
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return [CustomView viewWidth];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return [CustomView viewHeight];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (IOS_6_OR_EARLIER) {
        // iOS 5/6
        return [customPickerArray count];
    } else {
        // iOS 7+
        return [pickerTitles count];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (IOS_6_OR_EARLIER) {
        // tell the picker which view to use for a given component and row;
        // we have an array of views to show (iOS 5/6)
        return [customPickerArray objectAtIndex:row];
    }
    // iOS 7+
    if(view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 48)];
    }
    else {
        NSArray *viewsToRemove = [view subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
    }
    
    if([pickerImages count] > 0) {
        UIImage *image = [pickerImages objectAtIndex:row];
        UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [imageView setFrame:CGRectMake(60, 0, 44, 44)];
        [view addSubview:imageView];
        [imageView release];
    }
    
    CGRect labelFrame = CGRectMake(108, 0, pickerView.frame.size.width, 48);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    label.text = [NSString stringWithFormat:@" %@", [pickerTitles objectAtIndex: row]];
    
    [view addSubview:label];
    [label release];
    return [view autorelease];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [parent pickerView:pickerView didSelectRow:row inComponent:component];
}

@end
