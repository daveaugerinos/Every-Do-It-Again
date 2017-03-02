//
//  AddToDoViewController.h
//  Every-Do-It-Again
//
//  Created by Dave Augerinos on 2017-03-01.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddToDoViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
