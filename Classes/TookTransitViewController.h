//
//  TookTransitViewController.h
//  Cycle Philly
//
//  Created by kat on 4/19/14.
//
//

#import <UIKit/UIKit.h>
#import "TripPurposeDelegate.h"

@interface TookTransitViewController : UIViewController
{
	UIView      *tookTransitView;
    UILabel     *descriptionText;
    UILabel     *answerYesNo;
    UISwitch    *tookPublicTransit;
    
    id <TripPurposeDelegate> delegate;
    IBOutlet UINavigationBar *navBarItself;
}

@property (nonatomic, retain) IBOutlet UIView *tookTransitView;
@property (nonatomic, retain) IBOutlet UILabel *descriptionText;
@property (nonatomic, retain) IBOutlet UILabel * answerYesNo;
@property (nonatomic, retain) IBOutlet UISwitch *tookPublicTransit;
@property (nonatomic, retain) id <TripPurposeDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)saveDetail:(id)sender;
-(IBAction)answerChanged:(UISwitch *)sender;

@end