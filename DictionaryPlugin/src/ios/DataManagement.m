//
//  DataManagement.m
//  coreData
//
//  Created by msp on 16/3/3.
//  Copyright © 2016年 msp. All rights reserved.
//

#import "DataManagement.h"
#import "Global.h"
#import "PrintObject.h"

static DataManagement * insance = nil;

@implementation DataManagement

@synthesize managedObjectContext =_managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+ (DataManagement*)instance
{
    if(insance == nil)
    {
        insance = [[DataManagement alloc] init];
    }
    
    return insance;
}

#pragma mark - manage data

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext =self.managedObjectContext;
    if (managedObjectContext !=nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolvederror %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Core Data stack
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to thepersistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext !=nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application'smodel.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel !=nil) {
        return _managedObjectModel;
    }
    //这里一定要注意，这里的iWeather就是你刚才建立的数据模型的名字，一定要一致。否则会报错。
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"Word"withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and theapplication's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator !=nil) {
        return _persistentStoreCoordinator;
    }
    //这里的iWeaher.sqlite，也应该与数据模型的名字保持一致。
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"data222.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolvederror %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.
- (NSURL*)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}


//插入数据
- (BOOL)addIntoDataSource:(Word*)item {
    
    if([self isExist:item.word])
    {
        return [self update:item];
    }
    else
    {
    
        WordEntity* entiry = (WordEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"WordEntity" inManagedObjectContext:self.managedObjectContext];
        [entiry setWord:item.word];
        [entiry setUkphonetic:item.ukphonetic];
        [entiry setUsphonetic:item.usphonetic];
        [entiry setTranslate:[item.translate dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSError* error;
        BOOL isSaveSuccess=[_managedObjectContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error:%@",error);
        }else{
            NSLog(@"Save successful!");
        }
        
        [self queryAllData];
        
        return isSaveSuccess;
    }
    
}

- (BOOL)isExist:(NSString*)word
{
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* item=[NSEntityDescription entityForName:@"WordEntity" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:item];

    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    for (WordEntity* item in mutableFetchResult) {
        
        if([item.word isEqualToString:word])
        {
            return YES;
        }
        
        NSLog(@"word:%@",item.word);
        NSLog(@"transition:%@",[[NSString alloc] initWithData:item.translate encoding:NSUTF8StringEncoding]);
    }

    
    return NO;
}

//查询
- (Word*)query:(NSString*)word {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* item=[NSEntityDescription entityForName:@"WordEntity" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:item];
    //    NSSortDescriptor* sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    //    NSArray* sortDescriptions=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    //    [request setSortDescriptors:sortDescriptions];
    //    [sortDescriptions release];
    //    [sortDescriptor release];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
 
    for (WordEntity* item in mutableFetchResult) {
        NSLog(@"word:%@",item.word);
        NSLog(@"transition:%@",[[NSString alloc] initWithData:item.translate encoding:NSUTF8StringEncoding]);
    }
    
    return nil;
    
}

//查询
- (NSArray*)queryAllData
{
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* entiry=[NSEntityDescription entityForName:@"WordEntity" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entiry];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }

    NSMutableArray * datas = [NSMutableArray array];
    
    for (WordEntity* item in mutableFetchResult) {
        NSLog(@"word:%@",item.word);
        NSLog(@"usphonetic:%@",item.usphonetic);
        NSLog(@"ukphonetic:%@",item.ukphonetic);
        NSLog(@"transition:%@",[Global convertUnicodeToUTF8:[[NSString alloc] initWithData:item.translate encoding:NSUTF8StringEncoding]]);
        Word * word = [[Word alloc] init];
        word.word = item.word;
        word.ukphonetic = item.ukphonetic;
        word.usphonetic = item.usphonetic;
        word.translate = [Global convertUnicodeToUTF8:[[NSString alloc] initWithData:item.translate encoding:NSUTF8StringEncoding]] ;
        
        NSDictionary * dic = [PrintObject getObjectData:word];
        
        [datas addObject:dic];
    }
    
    return datas;
}
//更新
- (BOOL)update:(Word*)item {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"WordEntity" inManagedObjectContext:_managedObjectContext];
    [request setEntity:user];
    //查询条件
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"word==%@",item.word];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }

    //更新age后要进行保存，否则没更新
    for (WordEntity* word in mutableFetchResult) {
        [word setUkphonetic:item.ukphonetic];
        [word setUsphonetic:item.usphonetic];
        [word setTranslate:[item.translate dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    [_managedObjectContext save:&error];
    
    return YES;
    
}
//删除
- (BOOL)del:(Word*)item {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"WordEntity" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:user];
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"word==%@",item.word];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %i",[mutableFetchResult count]);
    for (WordEntity* user in mutableFetchResult) {
        [self.managedObjectContext deleteObject:user];
    }
    
    if ([self.managedObjectContext save:&error]) {
       
        return YES;
    }
    else
    {
         NSLog(@"Error:%@,%@",error,[error userInfo]);
        return NO;
    }
    
}

@end
