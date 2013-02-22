//
//  DetailViewController.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TripPurposeDelegate.h"

@interface DetailViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>{
    id <TripPurposeDelegate> delegate;
    UITextView *detailTextView;
    UIButton *addPicButton;
    NSInteger pickerCategory;
    NSString *details;
    UIImage *image;
    NSData *imageData;
}

@property (nonatomic, retain) id <TripPurposeDelegate> delegate;

@property (nonatomic, retain) IBOutlet UITextView *detailTextView;
@property (nonatomic, retain) IBOutlet UIButton *addPicButton;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageFrameView;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *imageFrame;
@property (nonatomic, retain) NSData *imageData;

@property (copy, nonatomic) NSString *lastChosenMediaType;

-(IBAction)skip:(id)sender;
-(IBAction)saveDetail:(id)sender;

- (IBAction)shootPictureOrVideo:(id)sender;
- (IBAction)selectExistingPictureOrVideo:(id)sender;

-(IBAction)screenShoot:(id)sender;
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;

@end
