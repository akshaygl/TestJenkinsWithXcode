//
//  AddRecordViewController.m
//  CoreDataInDepth
//
//  Created by Akshay.Agrawal on 9/19/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "AddRecordViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@interface AddRecordViewController ()

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //create managed object context
    [self createManagedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveButtonClicked:(id)sender {
    if(self.secondaryManagedObjectContext!=nil){
         NSError *error;
        if(self.isNewRecord){
            UserInfo *userInfoRecord = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:self.secondaryManagedObjectContext];
            userInfoRecord.name = self.userNameTxt.text;
           
            
        }
        else{
            NSFetchRequest *fetchRequest =[NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
            if(!self.selectedRecordId.isTemporaryID){
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objectID = %@)",self.selectedRecordId];
                NSManagedObjectContext *mainContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
            
                [fetchRequest setPredicate:predicate];
                UserInfo *selectedRecordInfo = (UserInfo *)[[mainContext executeFetchRequest:fetchRequest error:&error] firstObject];
                selectedRecordInfo.name = self.userNameTxt.text;
            }
        }
        [self.secondaryManagedObjectContext save:&error];
        if(error==nil)
        {
           [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveMainThreadContext" object:self userInfo:[NSDictionary dictionaryWithObject:self.secondaryManagedObjectContext forKey:@"contextInfo"]];
        }
    }
}

-(void) createManagedObjectContext{
    if (self.secondaryManagedObjectContext == nil) {
    NSPersistentStoreCoordinator *coordinator = [(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentStoreCoordinator];
    if (coordinator) {
     _secondaryManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_secondaryManagedObjectContext setParentContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    }
  }
}
@end
