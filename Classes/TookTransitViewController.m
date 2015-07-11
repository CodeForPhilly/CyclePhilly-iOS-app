//
//  TookTransitViewController.m
//  Cycle Philly
//
//  Created by kat on 4/19/14.
//
//

#import "TookTransitViewController.h"
#import "TripDetailViewController.h"

@interface TookTransitViewController ()
@end

@implementation TookTransitViewController

@synthesize tookTransitView;
@synthesize tookPublicTransit, descriptionText, answerYesNo;
@synthesize delegate;

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
    [super viewDidLoad];
    [self.view addSubview:tookTransitView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)answerChanged:(UISwitch *)sender {
    NSLog(@"Switch moved");
    if (self.tookPublicTransit.on) {
        self.answerYesNo.text = @"Yes";
    } else {
        self.answerYesNo.text = @"No";
    }
}

-(IBAction)cancel:(id)sender{
    NSLog(@"Cancelled");
    
    [tookTransitView resignFirstResponder];
    [delegate didCancelNote];
}

-(IBAction)saveDetail:(id)sender{
    NSLog(@"Save Detail");
    
    if (self.tookPublicTransit.on) {
        NSLog(@"Noted took transit in TookTransitViewController");
        [delegate didTakeTransit];
    }
    
    TripDetailViewController *tripDetailViewController = [[TripDetailViewController alloc] initWithNibName:@"TripDetailViewController" bundle:nil];
    tripDetailViewController.delegate = self.delegate;
    
    [self presentViewController:tripDetailViewController animated:YES completion:nil];
    
}

- (void)dealloc {
    self.delegate = nil;
    self.tookTransitView = nil;
    self.tookPublicTransit = nil;
    self.descriptionText = nil;
    
    [descriptionText release];
    [tookPublicTransit release];
    [delegate release];
    
    [navBarItself release];
    
    [super dealloc];
}

@end