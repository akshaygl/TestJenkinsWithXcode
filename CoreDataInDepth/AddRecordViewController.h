//
//  AddRecordViewController.h
//  CoreDataInDepth
//
//  Created by Akshay.Agrawal on 9/19/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddRecordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userNameTxt;
- (IBAction)saveButtonClicked:(id)sender;
@property (readonly, strong, nonatomic) NSManagedObjectContext *secondaryManagedObjectContext;

@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,strong) NSManagedObjectID *selectedRecordId;
@end
