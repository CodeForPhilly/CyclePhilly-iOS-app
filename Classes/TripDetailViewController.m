//
//  TripDetailViewController.m
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-3-13.
//
//

#import "TripDetailViewController.h"

@interface TripDetailViewController ()

@end

@implementation TripDetailViewController
@synthesize delegate;
@synthesize detailTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.detailTextView becomeFirstResponder];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    detailTextView.layer.borderWidth = 1.0;
    detailTextView.layer.borderColor = [[UIColor blackColor] CGColor];
}

-(IBAction)skip:(id)sender{
    NSLog(@"Skip");
    [delegate didCancelNote];
    
    pickerCategory = [[NSUserDefaults standardUserDefaults] integerForKey:@"pickerCategory"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey: @"pickerCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    details = @"";
    
    [delegate didEnterTripDetails:details];
    [delegate saveTrip];
}

-(IBAction)saveDetail:(id)sender{
    NSLog(@"Save Detail");
    [detailTextView resignFirstResponder];
    [delegate didCancelNote];
    
    pickerCategory = [[NSUserDefaults standardUserDefaults] integerForKey:@"pickerCategory"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey: @"pickerCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    details = detailTextView.text;
    
    [delegate didEnterTripDetails:details];
    [delegate saveTrip];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.delegate = nil;
    self.detailTextView = nil;
    
    [delegate release];
    [detailTextView release];
    
    [super dealloc];
}

@end
