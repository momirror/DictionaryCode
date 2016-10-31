//
//  DataManagement.h
//  coreData
//
//  Created by msp on 16/3/3.
//  Copyright © 2016年 msp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "WordEntity+CoreDataProperties.h"
#import "Word.h"

@interface DataManagement : NSObject

@property (readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;
@property (readonly,strong,nonatomic)NSManagedObjectModel *managedObjectModel;
@property (readonly,strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManagement*)instance;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (BOOL)addIntoDataSource:(Word*)item;
- (Word*)query:(NSString*)word;
- (BOOL)update:(Word*)item;
- (BOOL)del:(Word*)item;
- (BOOL)isExist:(NSString*)word;
- (NSArray*)queryAllData;
@end
