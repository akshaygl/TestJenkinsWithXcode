//
//  ViewController.m
//  CoreDataInDepth
//
//  Created by Akshay.Agrawal on 9/19/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "ViewController.h"
#import "UserRecordCell.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "AddRecordViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSaveMainThreadContext:) name:@"SaveMainThreadContext" object:nil];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self fetchUserInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userInfoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserRecordCell *infoCell = (UserRecordCell *)[self.recordTableView dequeueReusableCellWithIdentifier:@"UserRecordCell" forIndexPath:indexPath];
    if(infoCell==nil){
        infoCell = [[UserRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserRecordCell"];
    }
    UserInfo *userInfo= [self.userInfoArray objectAtIndex:indexPath.row];
    infoCell.userInfoLabel.text = userInfo.name;
    return infoCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"addItemSegue" sender:@"updateRecord"];
}

- (IBAction)addRecordClicked:(id)sender {
    [self performSegueWithIdentifier:@"addItemSegue" sender:@"newRecord"];
}

-(void)fetchUserInfo{
    NSManagedObjectContext *mainThreadContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
    NSError *error;
    self.userInfoArray =(NSMutableArray *)[mainThreadContext executeFetchRequest:fetchRequest error:&error];
    if(error==nil)
        [self.recordTableView reloadData];
    //dummmy comment
    //temp comment
    /**
     *  <#Description#>
     *
     *  @return <#return value description#>
     */
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AddRecordViewController *addRecordVC = (AddRecordViewController *)[segue destinationViewController];
    if([(NSString *)sender isEqualToString:@"newRecord"])
        addRecordVC.isNewRecord = YES;
    else{
        addRecordVC.isNewRecord = NO;
        NSIndexPath *selectedRowIndexPath = [self.recordTableView indexPathForSelectedRow];
        UserInfo *selectedRecord = [self.userInfoArray objectAtIndex:selectedRowIndexPath.row];
        addRecordVC.selectedRecordId = selectedRecord.objectID;
    }
}

-(void)didSaveMainThreadContext:(NSNotification *) notifData{
    NSError *error;
   [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] save:&error];
}
@end
