//
//  UserInfo+CoreDataProperties.h
//  CoreDataInDepth
//
//  Created by Akshay.Agrawal on 9/19/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *userId;

@end

NS_ASSUME_NONNULL_END
