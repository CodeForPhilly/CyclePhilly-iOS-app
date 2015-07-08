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
 *   Cycle Atlanta is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Cycle Atlanta is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Cycle Atlanta.  If not, see <http://www.gnu.org/licenses/>.
 */

#import <MobileCoreServices/UTCoreTypes.h>
#import "NoteViewController.h"
#import "LoadingView.h"
#import "TripPurposeDelegate.h"
#import "Note.h"
#import "UIImageViewResizable.h"

#define kFudgeFactor	1.5
#define kInfoViewAlpha	0.8
#define kMinLatDelta	0.0039
#define kMinLonDelta	0.0034

@interface NoteViewController ()

@end

@implementation NoteViewController

@synthesize doneButton, flipButton, infoView, note;
@synthesize delegate;

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
	infoView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,560)];
    NSInteger textLength = [note.details length];
    long row = 1+(textLength-1)/34;
	if ([note.image_data length] != 0 && textLength != 0) {
        infoView.alpha = 1.0;
        infoView.backgroundColor = [UIColor blackColor];
        
        UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 427)] autorelease];
        
        UIImageViewResizable *noteImageResize = [[[UIImageViewResizable alloc] initWithFrame:CGRectMake(0, 0, 320, 427)] autorelease];
        
        noteImageResize.image= [UIImage imageWithData:note.image_data];
        noteImageResize.contentMode = UIViewContentModeScaleAspectFill;
        
//        [noteImageResize applyGestures];
        
//        UIImageView *noteImage      = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 427)];
//        noteImage.image= [UIImage imageWithData:note.image_data];
//        noteImage.contentMode = UIViewContentModeScaleAspectFill;
        
        [scrollView addSubview:noteImageResize];
        
        [infoView addSubview:scrollView];
        
        UIImageView *bgImageHeader      = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)] autorelease];
        bgImageHeader.backgroundColor = [UIColor blackColor];
        bgImageHeader.alpha = 0.8;
        [infoView addSubview:bgImageHeader];
        
        UILabel *notesHeader		= [[[UILabel alloc] initWithFrame:CGRectMake(9,85,160,25)] autorelease];
        notesHeader.backgroundColor = [UIColor clearColor];
        notesHeader.font			= [UIFont boldSystemFontOfSize:18.0];
        notesHeader.opaque			= NO;
        notesHeader.text			= @"Details";
        notesHeader.textColor		= [UIColor whiteColor];
        [infoView addSubview:notesHeader];
        
        UIImageView *bgImageText      = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 110, 320, 25*row+25)] autorelease];
        bgImageText.backgroundColor = [UIColor blackColor];
        bgImageText.alpha = 0.8;
        [infoView addSubview:bgImageText];
        
        UITextView *notesText		= [[[UITextView alloc] initWithFrame:CGRectMake(0,110,320,25*row+15)] autorelease];
        notesText.backgroundColor	= [UIColor clearColor];
        notesText.editable			= NO;
        notesText.font				= [UIFont systemFontOfSize:16.0];
        notesText.text				= note.details;
        notesText.textColor			= [UIColor whiteColor];
        [infoView addSubview:notesText];
    }
    if ([note.image_data length] != 0 && textLength == 0) {
        infoView.alpha = 1.0;
        infoView.backgroundColor = [UIColor blackColor];
        
        UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 427)] autorelease];
        UIImageView *noteImage   = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 427)] autorelease];
        noteImage.image= [UIImage imageWithData:note.image_data];
        noteImage.contentMode = UIViewContentModeScaleAspectFill;
        
        [scrollView addSubview:noteImage];
        
        [infoView addSubview:scrollView];
        
        [infoView addSubview:noteImage];
    }
    else if ([note.image_data length] == 0 && textLength != 0) {
        infoView.alpha				= kInfoViewAlpha;
        infoView.backgroundColor	= [UIColor blackColor];
        
        UILabel *notesHeader		= [[[UILabel alloc] initWithFrame:CGRectMake(9,85,160,25)] autorelease];
        notesHeader.backgroundColor = [UIColor clearColor];
        notesHeader.font			= [UIFont boldSystemFontOfSize:18.0];
        notesHeader.opaque			= NO;
        notesHeader.text			= @"Details";
        notesHeader.textColor		= [UIColor whiteColor];
        [infoView addSubview:notesHeader];
        
        UITextView *notesText		= [[[UITextView alloc] initWithFrame:CGRectMake(0,110,320,200)] autorelease];
        notesText.backgroundColor	= [UIColor clearColor];
        notesText.editable			= NO;
        notesText.font				= [UIFont systemFontOfSize:16.0];
        notesText.text				= note.details;
        notesText.textColor			= [UIColor whiteColor];
        [infoView addSubview:notesText];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBarHidden = NO;
    
	if ( note )
	{
		// format date as a string
        NSDateFormatter *outputDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [outputDateFormatter setDateStyle:kCFDateFormatterLongStyle];
        
        NSDateFormatter *outputTimeFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [outputTimeFormatter setTimeStyle:kCFDateFormatterShortStyle];
        
        NSString *newDateString = [outputDateFormatter stringFromDate:note.recorded];
        NSString *newTimeString = [outputTimeFormatter stringFromDate:note.recorded];
		
		self.navigationItem.prompt = [NSString stringWithFormat:@"%@ at %@",newDateString,newTimeString];
        NSLog(@"NewDataString: %@", newDateString);
        NSLog(@"NewTimeString: %@", newTimeString);
        
        NSString *title = [[[NSString alloc] init] autorelease];
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
        
        MKPointAnnotation *notePoint = [[[MKPointAnnotation alloc] init] autorelease];
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
    
    LoadingView *loading = (LoadingView*)[self.parentViewController.view viewWithTag:999];
	//NSLog(@"loading: %@", loading);
	[loading performSelector:@selector(removeView) withObject:nil afterDelay:0.5];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UIImage *thumbnailOriginal;
    thumbnailOriginal = [self screenshot];
    
    CGRect clippedRect  = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+160, self.view.frame.size.width, self.view.frame.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([thumbnailOriginal CGImage], clippedRect);
    UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    CGSize size;
    size.height = 72;
    size.width = 72;
    
    UIImage *thumbnail;
    thumbnail = shrinkImage1(newImage, size);
    
    NSData *thumbnailData = [[[NSData alloc] initWithData:UIImageJPEGRepresentation(thumbnail, 0)] autorelease];
    NSLog(@"Size of Thumbnail Image(bytes):%lu",(unsigned long)[thumbnailData length]);
    NSLog(@"Size: %f, %f", thumbnail.size.height, thumbnail.size.width);
    
    [delegate getNoteThumbnail:thumbnailData];
}


UIImage *shrinkImage1(UIImage *original, CGSize size) {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale,
                                                 size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context,
                       CGRectMake(0, 0, size.width * scale, size.height * scale),
                       original.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    CGColorSpaceRelease(colorSpace);
    return final;
}


- (UIImage*)screenshot
{
    NSLog(@"Screen Shoot");
    // Create a graphics context with the target size
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y+50);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return screenImage;
}


- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{

//    // Try to dequeue an existing pin view first.
//    MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView
//                                                          dequeueReusableAnnotationViewWithIdentifier:@"LastCoord"];
//    
//    if ( !pinView )
//    {
//        // If an existing pin view was not available, create one
//        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"LastCoord"]
//                   autorelease];
//        
//        pinView.animatesDrop = YES;
//        pinView.canShowCallout = YES;
//        pinView.pinColor = MKPinAnnotationColorRed;
//    }
//    
//    annotationView = pinView;
    
    
    
    MKAnnotationView *noteAnnotation = (MKAnnotationView*)[noteView dequeueReusableAnnotationViewWithIdentifier:@"notePin"];
    
    if (!noteAnnotation)
    {
        // If an existing pin view was not available, create one
        noteAnnotation = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"notePin"]
                          autorelease];
        if ([note.note_type intValue]>=0 && [note.note_type intValue]<=5) {
            noteAnnotation.image = [UIImage imageNamed:@"noteIssueMapGlyph.png"];
            //noteAnnotation.centerOffset = CGPointMake(-(noteAnnotation.image.size.width/4),(noteAnnotation.image.size.height/3));
            NSLog(@"Note Pin Note This Issue");
        }
        else if ([note.note_type intValue]>=6 && [note.note_type intValue]<=11) {
            noteAnnotation.image = [UIImage imageNamed:@"noteAssetMapGlyph.png"];
            //noteAnnotation.centerOffset = CGPointMake(-(noteAnnotation.image.size.width/4),(noteAnnotation.image.size.height/3));
            NSLog(@"Note Pin Note This Asset");
        }
    }
    
    return noteAnnotation;
}

- (void)didReceiveMemoryWarning
{
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
	LoadingView *loading = (LoadingView*)[self.parentViewController.view viewWithTag:999];
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
