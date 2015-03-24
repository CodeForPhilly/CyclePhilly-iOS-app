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
//  PersonalInfoViewController.h
//  CycleTracks
//
//  Copyright 2009-2010 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 9/23/09.
//	For more information on the project, 
//	e-mail Billy Charlton at the SFCTA <billy.charlton@sfcta.org>

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "PersonalInfoDelegate.h"


@class User;


@interface PersonalInfoViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UIWebViewDelegate>
{
	id <PersonalInfoDelegate> delegate;
	NSManagedObjectContext *managedObjectContext;
	User *user;

	UITextField *age;
	UITextField *email;
	UITextField *gender;
    UITextField *ethnicity;
    UITextField *income;
	UITextField *homeZIP;
	UITextField *workZIP;
	UITextField *schoolZIP;
    UITextField *cyclingFreq;
    UITextField *riderType;
    UITextField *riderHistory;
    UIToolbar *doneToolbar;
    UIActionSheet *actionSheet;
    UIPickerView *pickerView;
    UITextField *currentTextField;
    
    NSArray *genderArray;
    NSArray *ageArray;
    NSArray *ethnicityArray;
    NSArray *incomeArray;
    NSArray *cyclingFreqArray;
    NSArray *riderTypeArray;
    NSArray *riderHistoryArray;
    
    NSInteger ageSelectedRow;
    NSInteger genderSelectedRow;
    NSInteger ethnicitySelectedRow;
    NSInteger incomeSelectedRow;
    NSInteger cyclingFreqSelectedRow;
    NSInteger riderTypeSelectedRow;
    NSInteger riderHistorySelectedRow;
    NSInteger selectedItem;
}


@property (nonatomic, retain) id <PersonalInfoDelegate> delegate;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) User *user;

@property (nonatomic, retain) UITextField	*age;
@property (nonatomic, retain) UITextField	*email;
@property (nonatomic, retain) UITextField	*gender;
@property (nonatomic, retain) UITextField   *ethnicity;
@property (nonatomic, retain) UITextField   *income;
@property (nonatomic, retain) UITextField	*homeZIP;
@property (nonatomic, retain) UITextField	*workZIP;
@property (nonatomic, retain) UITextField	*schoolZIP;

@property (nonatomic, retain) UITextField   *cyclingFreq;
@property (nonatomic, retain) UITextField   *riderType;
@property (nonatomic, retain) UITextField   *riderHistory;

@property (nonatomic) NSInteger ageSelectedRow;
@property (nonatomic) NSInteger genderSelectedRow;
@property (nonatomic) NSInteger ethnicitySelectedRow;
@property (nonatomic) NSInteger incomeSelectedRow;
@property (nonatomic) NSInteger cyclingFreqSelectedRow;
@property (nonatomic) NSInteger riderTypeSelectedRow;
@property (nonatomic) NSInteger riderHistorySelectedRow;
@property (nonatomic) NSInteger selectedItem;

// DEPRECATED
- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context;

- (void)done;

@end
