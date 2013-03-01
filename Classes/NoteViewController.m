//
//  NoteViewController.m
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-3-1.
//
//

#import "NoteViewController.h"
#import "LoadingView.h"
#import "Note.h"

#define kFudgeFactor	1.5
#define kInfoViewAlpha	0.8
#define kMinLatDelta	0.0039
#define kMinLonDelta	0.0034

@interface NoteViewController ()

@end

@implementation NoteViewController

@synthesize doneButton, flipButton, infoView, note;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithNote:(Note *)_note
{
	if (self = [super initWithNibName:@"NoteViewController" bundle:nil]) {
		NSLog(@"NoteViewController initWithNote");
		self.note = _note;
		noteView.delegate = self;
    }
    return self;
}

- (void)infoAction:(UIButton*)sender
{
	NSLog(@"infoAction");
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	
	[UIView setAnimationTransition:([infoView superview] ?
									UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
						   forView:self.view cache:YES];
	
	if ([infoView superview])
		[infoView removeFromSuperview];
	else
		[self.view addSubview:infoView];
	
	[UIView commitAnimations];
	
	// adjust our done/info buttons accordingly
	if ([infoView superview] == self.view)
		self.navigationItem.rightBarButtonItem = doneButton;
	else
		self.navigationItem.rightBarButtonItem = flipButton;
}

- (void)initInfoView
{
	infoView					= [[UIView alloc] initWithFrame:CGRectMake(0,0,320,460)];
	infoView.alpha				= kInfoViewAlpha;
	infoView.backgroundColor	= [UIColor blackColor];
	
	UILabel *notesHeader		= [[UILabel alloc] initWithFrame:CGRectMake(9,85,160,25)];
	notesHeader.backgroundColor = [UIColor clearColor];
	notesHeader.font			= [UIFont boldSystemFontOfSize:18.0];
	notesHeader.opaque			= NO;
	notesHeader.text			= @"Note Detail";
	notesHeader.textColor		= [UIColor whiteColor];
	[infoView addSubview:notesHeader];
	
	UITextView *notesText		= [[UITextView alloc] initWithFrame:CGRectMake(0,110,320,200)];
	notesText.backgroundColor	= [UIColor clearColor];
	notesText.editable			= NO;
	notesText.font				= [UIFont systemFontOfSize:16.0];
	notesText.text				= note.details;
	notesText.textColor			= [UIColor whiteColor];
	[infoView addSubview:notesText];
    
    UIImageView *noteImage      = [[UIImageView alloc] initWithFrame:CGRectMake(9, 160, 180, 240)];
    noteImage.backgroundColor   = [UIColor clearColor];
    noteImage.image= [UIImage imageWithData:note.image_data];
    [infoView addSubview:noteImage];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBarHidden = NO;
    
	if ( note )
	{
		// format date as a string
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *newDateString = [outputFormatter stringFromDate:note.recorded];
		
		self.navigationItem.prompt = [NSString stringWithFormat:@"Time: %@",newDateString];
        NSLog(@"NewDataString: %@", newDateString);
        
        NSString *title = [[NSString alloc] init];
        switch ([note.note_type intValue]) {
            case 0:
                title = @"Pavement issue";
                break;
            case 1:
                title = @"Traffic signal";
                break;
            case 2:
                title = @"Enforcement";
                break;
            case 3:
                title = @"Bike parking";
                break;
            case 4:
                title = @"Bike lane issue";
                break;
            case 5:
                title = @"Note this issue";
                break;
            case 6:
                title = @"Bike parking";
                break;
            case 7:
                title = @"Bike shops";
                break;
            case 8:
                title = @"Public restrooms";
                break;
            case 9:
                title = @"Secret passage";
                break;
            case 10:
                title = @"Water fountains";
                break;
            case 11:
                title = @"Note this asset";
                break;
            default:
                break;
        }

		self.title = title;
		
		if ( ![note.details isEqual: @""] || ([note.image_data length] != 0))
		{
			doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(infoAction:)];
			
			UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
			infoButton.showsTouchWhenHighlighted = YES;
			[infoButton addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
			flipButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
			self.navigationItem.rightBarButtonItem = flipButton;
			
			[self initInfoView];
		}
        
        CLLocationCoordinate2D noteCoordinate;
        noteCoordinate.latitude = [note.latitude doubleValue];
        noteCoordinate.longitude = [note.longitude doubleValue];
        NSLog(@"noteCoordinate is: %f, %f", noteCoordinate.latitude, noteCoordinate.longitude);
        
        MKPointAnnotation *notePoint = [[MKPointAnnotation alloc] init];
        notePoint.coordinate = noteCoordinate;
        notePoint.title = @"Note";
        [noteView addAnnotation:notePoint];
        
        
        MKCoordinateRegion region = { { noteCoordinate.latitude, noteCoordinate.longitude }, { 0.0078, 0.0068 }};
        [noteView setRegion:region animated:NO];
        
    }
    else{
        MKCoordinateRegion region = { { 33.749038, -84.388068 }, { 0.10825, 0.10825 } };
		[noteView setRegion:region animated:NO];
    }
    
    LoadingView *loading = (LoadingView*)[self.parentViewController.view viewWithTag:909];
	//NSLog(@"loading: %@", loading);
	[loading performSelector:@selector(removeView) withObject:nil afterDelay:0.5];
    
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"NoteViewController");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MKMapViewDelegate methods


- (void)mapViewWillStartLoadingMap:(MKMapView *)noteView
{
	//NSLog(@"mapViewWillStartLoadingMap");
}


- (void)mapViewDidFailLoadingMap:(MKMapView *)noteView withError:(NSError *)error
{
	NSLog(@"mapViewDidFailLoadingMap:withError: %@", [error localizedDescription]);
}


- (void)mapViewDidFinishLoadingMap:(MKMapView *)_noteView
{
	//NSLog(@"mapViewDidFinishLoadingMap");
	LoadingView *loading = (LoadingView*)[self.parentViewController.view viewWithTag:909];
	//NSLog(@"loading: %@", loading);
	[loading removeView];
}

- (void)dealloc {
    self.note = nil;
    self.doneButton = nil;
    self.flipButton = nil;
    self.infoView = nil;
    
	[doneButton release];
	[flipButton release];
    [infoView release];
    [note release];
    
    [noteView release];
    
    [super dealloc];
}

@end
