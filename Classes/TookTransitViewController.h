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
    UILabel     *transitText;
    UILabel     *answerTransitYesNo;
    UISwitch    *tookPublicTransit;
    UILabel     *rentalText;
    UILabel     *answerRentalYesNo;
    UISwitch    *tookRental;

    
    id <TripPurposeDelegate> delegate;
    IBOutlet UINavigationBar *navBarItself;
}

@property (nonatomic, retain) IBOutlet UIView *tookTransitView;
@property (nonatomic, retain) IBOutlet UILabel *transitText;
@property (nonatomic, retain) IBOutlet UILabel * answerTransitYesNo;
@property (nonatomic, retain) IBOutlet UISwitch *tookPublicTransit;
@property (nonatomic, retain) IBOutlet UILabel *rentalText;
@property (nonatomic, retain) IBOutlet UILabel * answerRentalYesNo;
@property (nonatomic, retain) IBOutlet UISwitch *tookRental;
@property (nonatomic, retain) id <TripPurposeDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)saveDetail:(id)sender;
-(IBAction)answerChanged:(UISwitch *)sender;

@end