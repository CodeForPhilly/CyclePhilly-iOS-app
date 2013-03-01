//
//  NoteViewController.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-3-1.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NoteManager.h"

@interface NoteViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView *noteView;
    Note *note;
    UIBarButtonItem *doneButton;
	UIBarButtonItem *flipButton;
	UIView *infoView;
}

@property (nonatomic, retain) Note *note;
@property (nonatomic ,retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *flipButton;
@property (nonatomic, retain) UIView *infoView;

-(id)initWithNote:(Note *)note;

@end
