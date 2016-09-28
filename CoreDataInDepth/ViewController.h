//
//  ViewController.h
//  CoreDataInDepth
//
//  Created by Akshay.Agrawal on 9/19/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *recordTableView;
@property (strong,nonatomic) NSMutableArray *userInfoArray;

@end

