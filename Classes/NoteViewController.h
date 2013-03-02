//
//  NoteViewController.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-3-1.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "NoteManager.h"
#import "TripManager.h"
#import "TripPurposeDelegate.h"

@interface NoteViewController : UIViewController <MKMapViewDelegate>
{
    id <TripPurposeDelegate> delegate;
    IBOutlet MKMapView *noteView;
    Note *note;
    UIBarButtonItem *doneButton;
	UIBarButtonItem *flipButton;
	UIView *infoView;
}

@property (nonatomic, retain) id <TripPurposeDelegate> delegate;
@property (nonatomic, retain) Note *note;
@property (nonatomic ,retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *flipButton;
@property (nonatomic, retain) UIView *infoView;

-(id)initWithNote:(Note *)note;

@end
