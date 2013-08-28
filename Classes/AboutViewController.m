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
//  AboutViewController.m
//  CycleTracks
//
//  Created by Matt Paul on 2/23/10.
//  Copyright 2010 mopimp productions. All rights reserved.
//

#import "AboutViewController.h"
#import "constants.h"


@implementation AboutViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	NSLog(@"About viewDidLoad");
    //loads the instructions page everytime the app is started. good for testing.
    NSURL *url = [NSURL URLWithString:kInstructionsURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [webView loadRequest:request];
    //loads the instructions page once and saves it unless the app is deleted
	//[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kInstructionsURL]]];
    
    /*_alreadyConsent18 = [[NSUserDefaults standardUserDefaults] boolForKey:@"alreadyConsent18"];
    
    if (!_alreadyConsent18) {
        
        [[NSUserDefaults standardUserDefaults] setBool: !_alreadyConsent18
                                                forKey: @"alreadyConsent18"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle: kConsentFor18Title
                                                             message: kConsentFor18Message
                                                            delegate: self
                                                   cancelButtonTitle: @"NO"
                                                   otherButtonTitles: @"YES", nil]
                                  autorelease];
        [alertView show];
    }*/
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [webView release];
    [super dealloc];
}

/*
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _over18 = !(buttonIndex == 0);
    [[NSUserDefaults standardUserDefaults] setBool: _over18 forKey:@"over18"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"User's age is over 18: %d", _over18);
}*/

@end
