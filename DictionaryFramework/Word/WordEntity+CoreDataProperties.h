//
//  WordEntity+CoreDataProperties.h
//  WordBook
//
//  Created by msp on 16/3/3.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WordEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface WordEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *ukphonetic;
@property (nullable, nonatomic, retain) NSData *translate;
@property (nullable, nonatomic, retain) NSString *word;
@property (nullable, nonatomic, retain) NSString *usphonetic;

@end

NS_ASSUME_NONNULL_END
