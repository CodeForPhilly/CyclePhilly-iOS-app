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
//  RecordTripViewController.h
//  CycleTracks
//
//  Copyright 2009-2010 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 8/10/09.
//	For more information on the project, 
//	e-mail Billy Charlton at the SFCTA <billy.charlton@sfcta.org>


#import <CoreLocation/CoreLocation.h>
#import "ActivityIndicatorDelegate.h"
#import <MapKit/MapKit.h>
#import "PersonalInfoDelegate.h"
#import "RecordingInProgressDelegate.h"
#import "TripPurposeDelegate.h"
#import "CycleAtlantaAppDelegate.h"
#import "Note.h"
#import <Firebase/Firebase.h>


@class ReminderManager;
@class TripManager;
@class NoteManager;
//@class CycleTracksAppDelegate;

//@interface RecordTripViewController : UITableViewController 
@interface RecordTripViewController : UIViewController 
	<CLLocationManagerDelegate,
	MKMapViewDelegate,
	UINavigationControllerDelegate, 
	UITabBarControllerDelegate, 
	PersonalInfoDelegate,
	RecordingInProgressDelegate,
	TripPurposeDelegate,
	UIActionSheetDelegate,
	UIAlertViewDelegate,
	UITextViewDelegate>
{
    NSManagedObjectContext *managedObjectContext;
	CycleAtlantaAppDelegate *appDelegate;
//    CLLocationManager *locationManager;
	/*
	UITableViewCell *tripPurposeCell;
	UITableViewCell *personalInfoCell;
	*/
	BOOL				didUpdateUserLocation;
	IBOutlet MKMapView	*mapView;
	
	IBOutlet UIButton *infoButton;
	IBOutlet UIButton *saveButton;
	IBOutlet UIButton *startButton;
    IBOutlet UIButton *noteButton;
	
	IBOutlet UILabel *timeCounter;
	IBOutlet UILabel *distCounter;
	IBOutlet UILabel *speedCounter;
    UIActionSheet *saveActionSheet;


	NSTimer *timer;
	
	// pointer to opacity mask, TabBar view
	UIView *opacityMask;
	UIView *parentView;
	
	BOOL recording;
	BOOL shouldUpdateCounter;
	BOOL userInfoSaved;
    NSInteger pickerCategory;
	
	TripManager		*tripManager;
    NoteManager *noteManager;
    
    
    CLLocation *myLocation;
//	ReminderManager *reminderManager;
}

//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

//@property (nonatomic, retain) CLLocationManager *locationManager;
/*
@property (nonatomic, retain) UITableViewCell	*tripPurposeCell;
@property (nonatomic, retain) UITableViewCell	*personalInfoCell;
*/
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) UIButton *saveButton;
@property (nonatomic, retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *noteButton;

@property (nonatomic, retain) UILabel *timeCounter;
@property (nonatomic, retain) UILabel *distCounter;
@property (nonatomic, retain) UIActionSheet *saveActionSheet;


@property (assign) NSTimer *timer;

@property (nonatomic, retain) UIView   *parentView;


@property (assign) BOOL recording;
@property (assign) BOOL shouldUpdateCounter;
@property (assign) BOOL userInfoSaved;

//@property (nonatomic, retain) ReminderManager *reminderManager;
@property (nonatomic, retain) TripManager *tripManager;

@property (nonatomic, retain) NoteManager *noteManager;

@property (nonatomic, retain) CycleAtlantaAppDelegate *appDelegate;

- (void)initTripManager:(TripManager*)manager;

- (void)initNoteManager:(NoteManager*)manager;

// DEPRECATED
//- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context;
//- (id)initWithTripManager:(TripManager*)manager;

// IBAction handlers
- (IBAction)save:(UIButton *)sender;
- (void)save;

- (IBAction)start:(UIButton *)sender;

-(IBAction)notethis:(id)sender;


// timer methods
- (void)start:(UIButton *)sender;
- (void)createCounter;
- (void)resetCounter;
- (void)setCounterTimeSince:(NSDate *)startDate distance:(CLLocationDistance)distance;
- (void)updateCounter:(NSTimer *)theTimer;

- (UIButton *)createSaveButton;
- (UIButton *)createStartButton;
- (UIButton *)createNoteButton;

- (void)displayUploadedTripMap;
- (void)displayUploadedNote;

@end
