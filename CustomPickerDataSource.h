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
//  CustomPickerDataSource.h
//  CycleTracks
//
//  Copyright 2009-2010 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 9/22/09.
//	For more information on the project, 
//	e-mail Billy Charlton at the SFCTA <billy.charlton@sfcta.org>

// Trip Purpose descriptions
#define kDescCommute	@"The primary reason for this bike trip is to get between home and your primary work location."
#define kDescSchool		@"The primary reason for this bike trip is to go to or from school or college."
#define kDescWork		@"The primary reason for this bike trip is to go to or from business-related meeting, function, or work-related errand for your job."
#define kDescExercise	@"The primary reason for this bike trip is exercise or biking for the sake of biking."
#define kDescSocial		@"The primary reason for this bike trip is going to or from a social activity (e.g. at a friend's house, the park, a restaurant, the movies)."
#define kDescShopping	@"The primary reason for this bike trip is to purchase or bring home goods or groceries."
#define kDescErrand		@"The primary reason for this bike trip is to attend to personal business such as banking, doctor visit, going to the gym, etc."
#define kDescOther		@"If none of the other reasons apply to this trip, you can enter trip comments after saving your trip to tell us more."

// Issue descriptions
#define kIssueDescPavementIssue  @"Select this option if the the road needs repairs (pothole, rough concrete, gravel in the road, manhole cover, sewer grate)."
#define kIssueDescTrafficSignal  @"Select this option if the traffic signal is malfunctioning."
#define kIssueDescEnforcement    @"Select this option to note bike lane obstructions (cars, trucks in bike lanes etc.)."
#define kIssueDescNeedParking    @"Select this option if you would like to see secure bike parking in this location."
#define kIssueDescBikeLaneIssue  @"Select this option if the bike lane needs improvement (it ends abruptly or needs repainting)."
#define kIssueDescNoteThisSpot   @"Misc. comments about needed improvements."

#define kDescNoteThis   @"Select an issue or note an asset."

// Asset descriptions
#define kAssetDescBikeParking   @"Note if secure bike parking is in this location."
#define kAssetDescBikeShops @"Note if bike shops are in this location."
#define kAssetDescPublicRestrooms   @"Note if public restrooms are in this location."
#define kAssetDescSecretPassage @"Note for routes outside normal bike lanes."
#define kAssetDescWaterFountains    @"Note if water is available in this location."
#define kAssetDescNoteThisSpot  @"Note any misc. assets in this location."


@interface CustomPickerDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
{
	NSArray	*customPickerArray;
	id<UIPickerViewDelegate> parent;
    NSInteger pickerCategory;
}

@property (nonatomic, retain) NSArray *pickerTitles;
@property (nonatomic, retain) NSArray *pickerImages;
@property (nonatomic, retain) id<UIPickerViewDelegate> parent;

@end
