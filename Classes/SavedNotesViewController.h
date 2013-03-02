//
//  SavedNotesViewController.h
//  Cycle Atlanta
//
//  Created by Guo Anhong on 13-3-1.
//
//

#import <MapKit/MapKit.h>


@class LoadingView;
@class NoteViewController;
@class Note;
@class NoteManager;

@interface SavedNotesViewController : UITableViewController
    <UINavigationControllerDelegate>
{
    NSMutableArray *notes;
    NoteManager *noteManager;
    NSManagedObjectContext *managedObjectContext;
    LoadingView *loading;
    NSInteger pickerCategory;
}

@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NoteManager *noteManager;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)initNoteManager:(NoteManager*)manager;

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context;
- (id)initWithNoteManager:(NoteManager*)manager;

@end
