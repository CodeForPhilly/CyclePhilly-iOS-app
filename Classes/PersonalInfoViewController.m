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
//  PersonalInfoViewController.m
//  CycleTracks
//
//  Copyright 2009-2010 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 9/23/09.
//	For more information on the project, 
//	e-mail Billy Charlton at the SFCTA <billy.charlton@sfcta.org>


#import "PersonalInfoViewController.h"
#import "User.h"
#import "constants.h"

#define kMaxCyclingFreq 3

@implementation PersonalInfoViewController

@synthesize delegate, managedObjectContext, user;
@synthesize age, email, gender, ethnicity, income, homeZIP, workZIP, schoolZIP;
@synthesize cyclingFreq, riderType, riderHistory;
@synthesize ageSelectedRow, genderSelectedRow, ethnicitySelectedRow, incomeSelectedRow, cyclingFreqSelectedRow, riderTypeSelectedRow, riderHistorySelectedRow, selectedItem;


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}


- (id)init
{
	NSLog(@"INIT");
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}


- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		NSLog(@"PersonalInfoViewController::initWithManagedObjectContext");
		self.managedObjectContext = context;
    }
    return self;
}

- (UITextField*)initTextFieldAlpha
{
	CGRect frame = CGRectMake( 152, 7, 138, 29 );
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.textAlignment = UITextAlignmentRight;
	textField.placeholder = @"Choose one";
	textField.delegate = self;
	return textField;
}

- (UITextField*)initTextFieldBeta
{
	CGRect frame = CGRectMake( 152, 7, 138, 29 );
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.textAlignment = UITextAlignmentRight;
	textField.placeholder = @"Choose one";
	textField.delegate = self;
	return textField;
}


- (UITextField*)initTextFieldEmail
{
	CGRect frame = CGRectMake( 152, 7, 138, 29 );
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone,
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.textAlignment = UITextAlignmentRight;
	textField.placeholder = @"name@domain";
	textField.keyboardType = UIKeyboardTypeEmailAddress;
	textField.returnKeyType = UIReturnKeyDone;
	textField.delegate = self;
	return textField;
}


- (UITextField*)initTextFieldNumeric
{
	CGRect frame = CGRectMake( 152, 7, 138, 29 );
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.textAlignment = UITextAlignmentRight;
	textField.placeholder = @"12345";
	textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	textField.returnKeyType = UIReturnKeyDone;
	textField.delegate = self;
	return textField;
}


- (User *)createUser
{
	// Create and configure a new instance of the User entity
	User *noob = (User *)[[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext] retain];
	
	NSError *error;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
		NSLog(@"createUser error %@, %@", error, [error localizedDescription]);
	}
	
	return [noob autorelease];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	// Set the title.
	// self.title = @"Personal Info";
    
    genderArray = [[NSArray alloc]initWithObjects: @" ", @"Female",@"Male", nil];
    
    ageArray = [[NSArray alloc]initWithObjects: @" ", @"Less than 18", @"18-24", @"25-34", @"35-44", @"45-54", @"55-64", @"65+", nil];
    
    ethnicityArray = [[NSArray alloc]initWithObjects: @" ", @"White", @"African American", @"Asian", @"Native American", @"Pacific Islander", @"Multi-racial", @"Hispanic / Mexican / Latino", @"Other", nil];
    
    incomeArray = [[NSArray alloc]initWithObjects: @" ", @"Less than $20,000", @"$20,000 to $39,999", @"$40,000 to $59,999", @"$60,000 to $74,999", @"$75,000 to $99,999", @"$100,000 or greater", nil];
    
    cyclingFreqArray = [[NSArray alloc]initWithObjects: @" ", @"Less than once a month", @"Several times per month", @"Several times per week", @"Daily", nil];
    
    riderTypeArray = [[NSArray alloc]initWithObjects: @" ", @"Strong & fearless", @"Enthused & confident", @"Comfortable, but cautious", @"Interested, but concerned", nil];
    
    riderHistoryArray = [[NSArray alloc]initWithObjects: @" ", @"Since childhood", @"Several years", @"One year or less", @"Just trying it out / just started", nil];
    
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    
	// initialize text fields
	self.age		= [self initTextFieldAlpha];
	self.email		= [self initTextFieldEmail];
	self.gender		= [self initTextFieldAlpha];
    self.ethnicity  = [self initTextFieldAlpha];
    self.income     = [self initTextFieldAlpha];
	self.homeZIP	= [self initTextFieldNumeric];
	self.workZIP	= [self initTextFieldNumeric];
	self.schoolZIP	= [self initTextFieldNumeric];
    self.cyclingFreq = [self initTextFieldBeta];
    self.riderType  =  [self initTextFieldBeta];
    self.riderHistory =[self initTextFieldBeta];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

	// Set up the buttons.
    // this is actually the Save button.
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(done)];
    
    //Initial Save button state is disabled. will be enabled if a change has been made to any of the fields.
	done.enabled = NO;
	self.navigationItem.rightBarButtonItem = done;
	
	NSFetchRequest		*request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	NSError *error;
	NSInteger count = [managedObjectContext countForFetchRequest:request error:&error];
	NSLog(@"saved user count  = %d", count);
	if ( count == 0 )
	{
		// create an empty User entity
		[self setUser:[self createUser]];
	}
	
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
		NSLog(@"no saved user");
		if ( error != nil )
			NSLog(@"PersonalInfo viewDidLoad fetch error %@, %@", error, [error localizedDescription]);
	}
	
	[self setUser:[mutableFetchResults objectAtIndex:0]];
	if ( user != nil )
	{
		// initialize text fields indexes to saved personal info
		age.text            = [ageArray objectAtIndex:[user.age integerValue]];
        ageSelectedRow      = [user.age integerValue];
		email.text          = user.email;
		gender.text         = [genderArray objectAtIndex:[user.gender integerValue]];;
        genderSelectedRow   = [user.gender integerValue];
        ethnicity.text      = [ethnicityArray objectAtIndex:[user.ethnicity integerValue]];
        ethnicitySelectedRow= [user.ethnicity integerValue];
        income.text         = [incomeArray objectAtIndex:[user.income integerValue]];
        incomeSelectedRow   = [user.income integerValue];
		
        homeZIP.text        = user.homeZIP;
		workZIP.text        = user.workZIP;
		schoolZIP.text      = user.schoolZIP;
        
        cyclingFreq.text        = [cyclingFreqArray objectAtIndex:[user.cyclingFreq integerValue]];
        cyclingFreqSelectedRow  = [user.cyclingFreq integerValue];
        riderType.text          = [riderTypeArray objectAtIndex:[user.rider_type integerValue]];
        riderTypeSelectedRow    = [user.rider_type integerValue];
        riderHistory.text       = [riderHistoryArray objectAtIndex:[user.rider_history integerValue]];
        riderHistorySelectedRow = [user.rider_history integerValue];
		
		// init cycling frequency
		//NSLog(@"init cycling freq: %d", [user.cyclingFreq intValue]);
		//cyclingFreq		= [NSNumber numberWithInt:[user.cyclingFreq intValue]];
		
		//if ( !([user.cyclingFreq intValue] > kMaxCyclingFreq) )
		//	[self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[user.cyclingFreq integerValue]
        //    inSection:2]];
	}
	else
		NSLog(@"init FAIL");
	
	[mutableFetchResults release];
	[request release];
}


#pragma mark UITextFieldDelegate methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(currentTextField == email || currentTextField == workZIP || currentTextField == homeZIP || currentTextField == schoolZIP || textField != email || textField != workZIP || textField != homeZIP || textField != schoolZIP){
        NSLog(@"currentTextField: text2");
        [currentTextField resignFirstResponder];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)myTextField{
    
    /*if(currentTextField == email || currentTextField == workZIP || currentTextField == homeZIP || currentTextField == schoolZIP){
        NSLog(@"currentTextField: text");
        [currentTextField resignFirstResponder];
        [myTextField resignFirstResponder];
    }
    NSLog(@"currentTextfield: picker");*/
    currentTextField = myTextField;
    
    if(myTextField == gender || myTextField == age || myTextField == ethnicity || myTextField == income || myTextField == cyclingFreq || myTextField == riderType || myTextField == riderHistory){
        
        [myTextField resignFirstResponder];
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]; //as we want to display a subview we won't be using the default buttons but rather we're need to create a toolbar to display the buttons on
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        
        [actionSheet addSubview:pickerView];
        
        doneToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        doneToolbar.barStyle = UIBarStyleBlackOpaque;
        [doneToolbar sizeToFit];
        
        NSMutableArray *barItems = [[[NSMutableArray alloc] init] autorelease];
        
        UIBarButtonItem *flexSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
        [barItems addObject:cancelBtn];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        [barItems addObject:doneBtn];
        
        //TODO add a next and previous button to left side to take us to the next/previous thing. and switch to the right kind of input mode.
        
        [doneToolbar setItems:barItems animated:YES];
        
        [actionSheet addSubview:doneToolbar];
        
        selectedItem = 0;
        if(myTextField == gender){
            selectedItem = [user.gender integerValue];
        }else if (myTextField == age){
            selectedItem = [user.age integerValue];
        }else if (myTextField == ethnicity){
            selectedItem = [user.ethnicity integerValue];
        }else if (myTextField == income){
            selectedItem = [user.income integerValue];
        }else if (myTextField == cyclingFreq){
            selectedItem = [user.cyclingFreq integerValue];
        }else if (myTextField == riderType){
            selectedItem = [user.rider_type integerValue];
        }else if (myTextField == riderHistory){
            selectedItem = [user.rider_history integerValue];
        }
        
        [pickerView selectRow:selectedItem inComponent:0 animated:NO];
        
        [pickerView reloadAllComponents];
        
        [actionSheet addSubview:pickerView];
        
        [actionSheet showInView:self.view];
        
        [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];

    }
}

// the user pressed the "Done" button, so dismiss the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSLog(@"textFieldShouldReturn");
	[textField resignFirstResponder];
	return YES;
}


// save the new value for this textField
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidEndEditing");
	
	// save value
	if ( user != nil )
	{		
		if ( textField == email )
		{
            //enable save button if value has been changed.
            if (email.text != user.email){
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
			NSLog(@"saving email: %@", email.text);
			[user setEmail:email.text];
		}		
		if ( textField == homeZIP )
		{
            if (homeZIP.text != user.homeZIP){
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
			NSLog(@"saving homeZIP: %@", homeZIP.text);
			[user setHomeZIP:homeZIP.text];
		}
		if ( textField == schoolZIP )
		{
            if (schoolZIP.text != user.schoolZIP){
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
			NSLog(@"saving schoolZIP: %@", schoolZIP.text);
			[user setSchoolZIP:schoolZIP.text];
		}
		if ( textField == workZIP )
		{
            if (workZIP.text != user.workZIP){
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
			NSLog(@"saving workZIP: %@", workZIP.text);
			[user setWorkZIP:workZIP.text];
		}
       
		
		NSError *error;
		if (![managedObjectContext save:&error]) {
			// Handle the error.
			NSLog(@"PersonalInfo save textField error %@, %@", error, [error localizedDescription]);
		}
	}
}


- (void)done
{
    [email resignFirstResponder];
    [homeZIP resignFirstResponder];
    [workZIP resignFirstResponder];
    [schoolZIP resignFirstResponder];
    
    NSLog(@"Saving User Data");
	if ( user != nil )
	{
		[user setAge:[NSNumber numberWithInt:ageSelectedRow]];
        NSLog(@"saved age index: %@ and text: %@", user.age, age.text);

		[user setEmail:email.text];
        NSLog(@"saved email: %@", user.email);

		[user setGender:[NSNumber numberWithInt:genderSelectedRow]];
		NSLog(@"saved gender index: %@ and text: %@", user.gender, gender.text);
        
        [user setEthnicity:[NSNumber numberWithInt:ethnicitySelectedRow]];
        NSLog(@"saved ethnicity index: %@ and text: %@", user.ethnicity, ethnicity.text);
        
        [user setIncome:[NSNumber numberWithInt:incomeSelectedRow]];
        NSLog(@"saved income index: %@ and text: %@", user.income, income.text);
        
		[user setHomeZIP:homeZIP.text];
        NSLog(@"saved homeZIP: %@", homeZIP.text);

		[user setSchoolZIP:schoolZIP.text];
        NSLog(@"saved schoolZIP: %@", schoolZIP.text);

		[user setWorkZIP:workZIP.text];
        NSLog(@"saved workZIP: %@", workZIP.text);
                
        [user setCyclingFreq:[NSNumber numberWithInt:cyclingFreqSelectedRow]];
        NSLog(@"saved cycle freq index: %@ and text: %@", user.cyclingFreq, cyclingFreq.text);
        
        [user setRider_type:[NSNumber numberWithInt:riderTypeSelectedRow]];
        NSLog(@"saved rider type index: %@ and text: %@", user.rider_type, riderType.text);
        
        [user setRider_history:[NSNumber numberWithInt:riderHistorySelectedRow]];
        NSLog(@"saved rider history index: %@ and text: %@", user.rider_history, riderHistory.text);
		
		//NSLog(@"saving cycling freq: %d", [cyclingFreq intValue]);
		//[user setCyclingFreq:cyclingFreq];

		NSError *error;
		if (![managedObjectContext save:&error]) {
			// Handle the error.
			NSLog(@"PersonalInfo save cycling freq error %@, %@", error, [error localizedDescription]);
		}
	}
	else
		NSLog(@"ERROR can't save personal info for nil user");
	
	// update UI
	
	[delegate setSaved:YES];
    //disable the save button after saving
	self.navigationItem.rightBarButtonItem.enabled = NO;
	[self.navigationController popViewControllerAnimated:YES];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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


#pragma mark Table view methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
        case 0:
			return nil;
			break;
		case 1:
			return @"Tell us about yourself";
			break;
		case 2:
			return @"Your typical commute";
			break;
		case 3:
			return @"How often do you cycle?";
			break;
        case 4:
			return @"What kind of rider are you?";
			break;
        case 5:
			return @"How long have you been a cyclist?";
			break;
	}
    return nil;
}

//- (UIView *)tableView:(UITableView *)tbl viewForHeaderInSection:(NSInteger)section
//{
//    UIView* sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tbl.bounds.size.width, 18)];
//    sectionHead.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
//    sectionHead.userInteractionEnabled = YES;
//    sectionHead.tag = section;
//    
//    UILabel *sectionText = [[UILabel alloc] initWithFrame:CGRectMake(18, 8, tbl.bounds.size.width - 10, 18)];
//    
//    switch (section) {
//		case 0:
//			sectionText.text = @"Tell us about yourself";
//			break;
//		case 1:
//			sectionText.text = @"Your typical commute";
//			break;
//		case 2:
//			sectionText.text = @"How often do you cycle?";
//			break;
//        case 3:
//			sectionText.text = @"What kind of rider are you?";
//			break;
//        case 4:
//			sectionText.text = @"How long have you been a cyclist?";
//			break;
//	}
//    sectionText.backgroundColor = [UIColor clearColor];
//    sectionText.textColor = [UIColor colorWithHue:0.6 saturation:0.33 brightness: 0.49 alpha:1];
//    //sectionText.shadowColor = [UIColor grayColor];
//    //sectionText.shadowOffset = CGSizeMake(0,0.001);
//    sectionText.font = [UIFont boldSystemFontOfSize:16];
//    
//    [sectionHead addSubview:sectionText];
//    [sectionText release];
//    
//    return [sectionHead autorelease];
//}
//
//-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return UITableViewAutomaticDimension;
//}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch ( section )
	{
        case 0:
            return 1;
            break;
		case 1:
			return 5;
			break;
		case 2:
			return 3;
			break;
		case 3:
			return 1;
			break;
        case 4:
			return 1;
			break;
        case 5:
			return 1;
			break;
		default:
			return 0;
	}
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    // Set up the cell...
	UITableViewCell *cell = nil;
	
	// outer switch statement identifies section
	switch ([indexPath indexAtPosition:0])
	{
        case 0:
		{
			static NSString *CellIdentifier = @"CellInstruction";
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
			// inner switch statement identifies row
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					cell.textLabel.text = @"Questions? Contact Us";
					break;
			}
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
			break;

		case 1:
		{
			static NSString *CellIdentifier = @"CellPersonalInfo";
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}

			// inner switch statement identifies row
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					cell.textLabel.text = @"Age";
					[cell.contentView addSubview:age];
					break;
				case 1:
					cell.textLabel.text = @"Email";
					[cell.contentView addSubview:email];
					break;
				case 2:
					cell.textLabel.text = @"Gender";
					[cell.contentView addSubview:gender];
					break;
                case 3:
					cell.textLabel.text = @"Ethnicity";
					[cell.contentView addSubview:ethnicity];
					break;
                case 4:
					cell.textLabel.text = @"Home Income";
					[cell.contentView addSubview:income];
					break;
			}
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
			break;
	
		case 2:
		{
			static NSString *CellIdentifier = @"CellZip";
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}

			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					cell.textLabel.text = @"Home ZIP";
					[cell.contentView addSubview:homeZIP];
					break;
				case 1:
					cell.textLabel.text = @"Work ZIP";
					[cell.contentView addSubview:workZIP];
					break;
				case 2:
					cell.textLabel.text = @"School ZIP";
					[cell.contentView addSubview:schoolZIP];
					break;
			}
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
			break;
            
        case 3:
		{
			static NSString *CellIdentifier = @"CellFrequecy";
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
			// inner switch statement identifies row
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
                    cell.textLabel.text = @"Cycle Frequency";
					[cell.contentView addSubview:cyclingFreq];
					break;
            }
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
			break;
            
        case 4:
		{
			static NSString *CellIdentifier = @"CellType";
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
			// inner switch statement identifies row
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
                    cell.textLabel.text = @"Rider Type";
					[cell.contentView addSubview:riderType];
					break;
            }
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
			break;
            
        case 5:
		{
			static NSString *CellIdentifier = @"CellHistory";
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
			// inner switch statement identifies row
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
                    cell.textLabel.text = @"Rider History";
                    [cell.contentView addSubview:riderHistory];
					break;
			}
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
            break;
            
//        case 5:
//		{
//			static NSString *CellIdentifier = @"CellTextField";
//			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//			if (cell == nil) {
//				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//			}
//            
//			// inner switch statement identifies row
//			switch ([indexPath indexAtPosition:1])
//			{
//				case 0:
//                    cell.textLabel.text = @"Getting started with Cycle Philly";
//					break;
//			}
//			
//			cell.selectionStyle = UITableViewCellSelectionStyleNone;
//		}
            
//		case 2:
//		{
//			static NSString *CellIdentifier = @"CellCheckmark";
//			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//			if (cell == nil) {
//				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//			}
//			
//			switch ([indexPath indexAtPosition:1])
//			{
//				case 0:
//					cell.textLabel.text = @"Less than once a month";
//					break;
//				case 1:
//					cell.textLabel.text = @"Several times per month";
//					break;
//				case 2:
//					cell.textLabel.text = @"Several times per week";
//					break;
//				case 3:
//					cell.textLabel.text = @"Daily";
//					break;
//			}
//			/*
//			if ( user != nil )
//				if ( [user.cyclingFreq intValue] == [indexPath indexAtPosition:1] )
//					cell.accessoryType = UITableViewCellAccessoryCheckmark;
//			 */
//			if ( [cyclingFreq intValue] == [indexPath indexAtPosition:1] )
//				cell.accessoryType = UITableViewCellAccessoryCheckmark;
//			else
//				cell.accessoryType = UITableViewCellAccessoryNone;
//		}
	}
	
	// debug
	//NSLog(@"%@", [cell subviews]);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];

    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];

	// outer switch statement identifies section
    NSURL *url = [NSURL URLWithString:kInstructionsURL];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
	switch ([indexPath indexAtPosition:0])
	{
		case 0:
		{
			// inner switch statement identifies row
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
                    [[UIApplication sharedApplication] openURL:[request URL]];
					break;
				case 1:
					break;
			}
			break;
		}
			
		case 1:
		{
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					break;
				case 1:
					break;
			}
			break;
		}
            
        case 2:
		{
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					break;
				case 1:
					break;
			}
			break;
		}
            
        case 3:
		{
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					break;
				case 1:
					break;
			}
			break;
		}
            
        case 4:
		{
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					break;
				case 1:
					break;
			}
			break;
		}
        case 5:
		{
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					break;
				case 1:
					break;
			}
			break;
		}
		
//		case 2:
//		{
//			// cycling frequency
//			// remove all checkmarks
//			UITableViewCell *cell;
//			cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//			cell.accessoryType = UITableViewCellAccessoryNone;
//			cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
//			cell.accessoryType = UITableViewCellAccessoryNone;
//			cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
//			cell.accessoryType = UITableViewCellAccessoryNone;
//			cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
//			cell.accessoryType = UITableViewCellAccessoryNone;
//			
//			// apply checkmark to selected cell
//			cell = [tableView cellForRowAtIndexPath:indexPath];
//			cell.accessoryType = UITableViewCellAccessoryCheckmark;
//
//			// store cycling freq
//			cyclingFreq = [NSNumber numberWithInt:[indexPath indexAtPosition:1]];
//			NSLog(@"setting instance variable cycling freq: %d", [cyclingFreq intValue]);
//		}
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if(currentTextField == gender){
        return [genderArray count];
    }
    else if(currentTextField == age){
        return [ageArray count];
    }
    else if(currentTextField == ethnicity){
        return [ethnicityArray count];
    }
    else if(currentTextField == income){
        return [incomeArray count];
    }
    else if(currentTextField == cyclingFreq){
        return [cyclingFreqArray count];
    }
    else if(currentTextField == riderType){
        return [riderTypeArray count];
    }
    else if(currentTextField == riderHistory){
        return [riderHistoryArray count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(currentTextField == gender){
        return [genderArray objectAtIndex:row];
    }
    else if(currentTextField == age){
        return [ageArray objectAtIndex:row];
    }
    else if(currentTextField == ethnicity){
        return [ethnicityArray objectAtIndex:row];
    }
    else if(currentTextField == income){
        return [incomeArray objectAtIndex:row];
    }
    else if(currentTextField == cyclingFreq){
        return [cyclingFreqArray objectAtIndex:row];
    }
    else if(currentTextField == riderType){
        return [riderTypeArray objectAtIndex:row];
    }
    else if(currentTextField == riderHistory){
        return [riderHistoryArray objectAtIndex:row];
    }
    return nil;
}

- (void)doneButtonPressed:(id)sender{
    
    NSInteger selectedRow;
    selectedRow = [pickerView selectedRowInComponent:0];
    if(currentTextField == gender){
        //enable save button if value has been changed.
        if (selectedRow != [user.gender integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        genderSelectedRow = selectedRow;
        NSString *genderSelect = [genderArray objectAtIndex:selectedRow];
        gender.text = genderSelect;
    }
    if(currentTextField == age){
        //enable save button if value has been changed.
        if (selectedRow != [user.age integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }

        ageSelectedRow = selectedRow;
        NSString *ageSelect = [ageArray objectAtIndex:selectedRow];
        age.text = ageSelect;
    }
    if(currentTextField == ethnicity){
        //enable save button if value has been changed.
        if (selectedRow != [user.ethnicity integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }

        ethnicitySelectedRow = selectedRow;
        NSString *ethnicitySelect = [ethnicityArray objectAtIndex:selectedRow];
        ethnicity.text = ethnicitySelect;
    }
    if(currentTextField == income){
        //enable save button if value has been changed.
        if (selectedRow != [user.income integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }

        incomeSelectedRow = selectedRow;
        NSString *incomeSelect = [incomeArray objectAtIndex:selectedRow];
        income.text = incomeSelect;
    }
    if(currentTextField == cyclingFreq){
        //enable save button if value has been changed.
        if (selectedRow != [user.cyclingFreq integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }

        cyclingFreqSelectedRow = selectedRow;
        NSString *cyclingFreqSelect = [cyclingFreqArray objectAtIndex:selectedRow];
        cyclingFreq.text = cyclingFreqSelect;
    }
    if(currentTextField == riderType){
        //enable save button if value has been changed.
        if (selectedRow != [user.rider_type integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }

        riderTypeSelectedRow = selectedRow;
        NSString *riderTypeSelect = [riderTypeArray objectAtIndex:selectedRow];
        riderType.text = riderTypeSelect;
    }
    if(currentTextField == riderHistory){
        //enable save button if value has been changed.
        if (selectedRow != [user.rider_history integerValue]){
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }

        riderHistorySelectedRow = selectedRow;
        NSString *riderHistorySelect = [riderHistoryArray objectAtIndex:selectedRow];
        riderHistory.text = riderHistorySelect;
    }
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];
}

- (void)cancelButtonPressed:(id)sender{
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];
}

- (void)dealloc {
    self.delegate = nil;
    self.managedObjectContext = nil;
    self.user = nil;
    self.age = nil;
    self.email = nil;
    self.gender = nil;
    self.ethnicity = nil;
    self.income = nil;
    self.homeZIP = nil;
    self.workZIP = nil;
    self.schoolZIP = nil;
    self.cyclingFreq = nil;
    self.riderType = nil;
    self.riderHistory = nil;
    self.ageSelectedRow = nil;
    self.genderSelectedRow = nil;
    self.ethnicitySelectedRow = nil;
    self.incomeSelectedRow = nil;
    self.cyclingFreqSelectedRow = nil;
    self.riderTypeSelectedRow = nil;
    self.riderHistorySelectedRow = nil;
    self.selectedItem = nil;
    
    [delegate release];
    [managedObjectContext release];
    [user release];
    [age release];
    [email release];
    [gender release];
    [ethnicity release];
    [income release];
    [homeZIP release];
    [workZIP release];
    [schoolZIP release];
    [cyclingFreq release];
    [riderType release];
    [riderHistory release];
    
    [doneToolbar release];
    [actionSheet release];
    [pickerView release];
    [currentTextField release];
    [genderArray release];
    [ageArray release];
    [ethnicityArray release];
    
    [super dealloc];
}

@end

