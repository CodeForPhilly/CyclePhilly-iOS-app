//
//  TripDetailViewController.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-3-13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TripPurposeDelegate.h"

@interface TripDetailViewController : UIViewController<UINavigationControllerDelegate, UITextViewDelegate>
{
    id <TripPurposeDelegate> delegate;
    UITextView *detailTextView;
    NSInteger pickerCategory;
    NSString *details;
}

@property (nonatomic, retain) id <TripPurposeDelegate> delegate;

@property (nonatomic, retain) IBOutlet UITextView *detailTextView;


-(IBAction)skip:(id)sender;
-(IBAction)saveDetail:(id)sender;

@end
