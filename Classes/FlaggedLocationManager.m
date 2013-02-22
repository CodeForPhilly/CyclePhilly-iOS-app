/** Cycle Altanta, Copyright 2012 Georgia Institute of Technology
 *                                    Atlanta, GA. USA
 *
 *   @author Christopher Le Dantec <ledantec@gatech.edu>
 *   @author Anhong Guo <guoanhong15@gmail.com>
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
//  TripManager.m
//	CycleTracks
//
//  Copyright 2009-2010 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 9/22/09.
//	For more information on the project,
//	e-mail Billy Charlton at the SFCTA <billy.charlton@sfcta.org>


#import "constants.h"
#import "SaveRequest.h"
#import "TripManager.h"
#import "User.h"
#import "FlaggedLocation.h"
#import "FlaggedLocationManager.h"
#import "LoadingView.h"
#import "RecordTripViewController.h"


#define kSaveFlaggedLocationProtocolVersion	4

@implementation FlaggedLocationManager

@synthesize flaggedLocation, managedObjectContextFlagged, receivedDataFlagged;
@synthesize uploadingView, parent;

// change initialization values

// change this function for flagged location detail view

// change this function for Flagged Location initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context
{
    if ( self = [super init] )
	{
		self.managedObjectContextFlagged = context;
        self.flaggedLocation = (FlaggedLocation *)[NSEntityDescription insertNewObjectForEntityForName:@"FlaggedLocation" inManagedObjectContext:managedObjectContextFlagged];
    }
    return self;
}

- (void)addFlagType:(NSNumber *)flagType
{
    flaggedLocation.flag_type=flagType;
    NSLog(@"Added flag type: %d", (int)flagType);
}

- (void)addDetails:(NSString *)details
{
    flaggedLocation.details = details;
    NSLog(@"Added details: %@", details);
}

- (void)addImgURL:(NSString *)imgURL
{
    flaggedLocation.image_url = imgURL;
    NSLog(@"Added image url: %@", imgURL);
}

- (void)addImage:(UIImage *)image
{
    NSLog(@"Added image:");
}

- (void)addLocation:(CLLocation *)locationNow
{
    NSLog(@"This is very very special!");
    
    [flaggedLocation setAltitude:[NSNumber numberWithDouble:locationNow.altitude]];
    [flaggedLocation setLatitude:[NSNumber numberWithDouble:locationNow.coordinate.latitude]];
    [flaggedLocation setLongitude:[NSNumber numberWithDouble:locationNow.coordinate.longitude]];
    [flaggedLocation setSpeed:[NSNumber numberWithDouble:locationNow.speed]];
    [flaggedLocation setHAccuracy:[NSNumber numberWithDouble:locationNow.horizontalAccuracy]];
    [flaggedLocation setVAccuracy:[NSNumber numberWithDouble:locationNow.verticalAccuracy]];
    [flaggedLocation setRecorded:locationNow.timestamp];
	
	NSError *error;
	if (![managedObjectContextFlagged save:&error]) {
		// Handle the error.
		NSLog(@"FlaggedLocation addLocation error %@, %@", error, [error localizedDescription]);
	}
    
}

- (void) saveFlaggedLocation
{
    NSMutableDictionary *flaggedLocationDict;
	
	// format date as a string
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"saving using protocol version 4");
	
    // create a flaggedLocationDict for each flaggedLocaton
    flaggedLocationDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [flaggedLocationDict setValue:flaggedLocation.altitude  forKey:@"a"];  //altitude
    [flaggedLocationDict setValue:flaggedLocation.latitude  forKey:@"l"];  //latitude
    [flaggedLocationDict setValue:flaggedLocation.longitude forKey:@"n"];  //longitude
    [flaggedLocationDict setValue:flaggedLocation.speed     forKey:@"s"];  //speed
    [flaggedLocationDict setValue:flaggedLocation.hAccuracy forKey:@"h"];  //haccuracy
    [flaggedLocationDict setValue:flaggedLocation.vAccuracy forKey:@"v"];  //vaccuracy
    
    [flaggedLocationDict setValue:flaggedLocation.flag_type     forKey:@"t"];  //flag_type
    [flaggedLocationDict setValue:flaggedLocation.details forKey:@"d"];  //details
    [flaggedLocationDict setValue:flaggedLocation.image_url forKey:@"i"];  //image_url
    
    
    NSString *newDateString = [outputFormatter stringFromDate:flaggedLocation.recorded];
    [flaggedLocationDict setValue:newDateString forKey:@"r"];    //recorded timestamp
    
    
    // JSON encode user data and trip data, return to strings
    NSError *writeError = nil;
    
    // JSON encode the Flagged Location data
    NSData *flaggedLocationJsonData = [NSJSONSerialization dataWithJSONObject:flaggedLocationDict options:0 error:&writeError];
    NSString *flaggedLocationJson = [[NSString alloc] initWithData:flaggedLocationJsonData encoding:NSUTF8StringEncoding];
    
	// NOTE: device hash added by SaveRequest initWithPostVars
	NSDictionary *postVars = [NSDictionary dictionaryWithObjectsAndKeys:
                              flaggedLocationJson, @"flaggLocation",
							  [NSString stringWithFormat:@"%d", kSaveFlaggedLocationProtocolVersion], @"version",
							  nil];
	// create save request
	SaveRequest *saveRequest = [[SaveRequest alloc] initWithPostVars:postVars with:4];
	
	// create the connection with the request and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:[saveRequest request]
																   delegate:self];
	// create loading view to indicate trip is being uploaded
    uploadingView = [[LoadingView loadingViewInView:parent.parentViewController.view:kSavingTitle] retain];
    
    //switch to map w/ trip view
    [parent displayUploadedFlaggedLocation];
    NSLog(@"flaggedLocation save and parent");
    
    if ( theConnection )
    {
        receivedDataFlagged=[[NSMutableData data] retain];
    }
    else
    {
        // inform the user that the download could not be made
        
    }
    
}


#pragma mark NSURLConnection delegate methods


- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	NSLog(@"%d bytesWritten, %d totalBytesWritten, %d totalBytesExpectedToWrite",
		  bytesWritten, totalBytesWritten, totalBytesExpectedToWrite );
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	// this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	NSLog(@"didReceiveResponse: %@", response);
	
	NSHTTPURLResponse *httpResponse = nil;
	if ( [response isKindOfClass:[NSHTTPURLResponse class]] &&
		( httpResponse = (NSHTTPURLResponse*)response ) )
	{
		BOOL success = NO;
		NSString *title   = nil;
		NSString *message = nil;
		switch ( [httpResponse statusCode] )
		{
			case 200:
			case 201:
				success = YES;
				title	= kSuccessTitle;
				message = kSaveSuccess;
				break;
			case 202:
				success = YES;
				title	= kSuccessTitle;
				message = kSaveAccepted;
				break;
			case 500:
			default:
				title = @"Internal Server Error";
				//message = [NSString stringWithFormat:@"%d", [httpResponse statusCode]];
				message = kServerError;
		}
		
		NSLog(@"%@: %@", title, message);
        
        //
        // DEBUG
        NSLog(@"+++++++DEBUG didReceiveResponse %@: %@", [response URL],[(NSHTTPURLResponse*)response allHeaderFields]);
	}
	
    // it can be called multiple times, for example in the case of a
	// redirect, so each time we reset the data.
	
    // receivedData is declared as a method instance elsewhere
    [receivedDataFlagged setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
	[receivedDataFlagged appendData:data];
    //	[activityDelegate startAnimating];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
	
    // receivedData is declared as a method instance elsewhere
    [receivedDataFlagged release];
    
    // TODO: is this really adequate...?
    [uploadingView loadingComplete:kConnectionError:1.5];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    
    //	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kConnectionError
    //													message:[error localizedDescription]
    //												   delegate:nil
    //										  cancelButtonTitle:@"OK"
    //										  otherButtonTitles:nil];
    //	[alert show];
    //	[alert release];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// do something with the data
    NSLog(@"+++++++DEBUG: Received %d bytes of data", [receivedDataFlagged length]);
	NSLog(@"%@", [[[NSString alloc] initWithData:receivedDataFlagged encoding:NSUTF8StringEncoding] autorelease] );
    
    // release the connection, and the data object
    [connection release];
    [receivedDataFlagged release];
}


@end
