//
//  WordEntity.h
//  WordBook
//
//  Created by msp on 16/3/3.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface WordEntity : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nonatomic, retain) NSString *word;
@property (nonatomic, retain) NSString *ukphonetic;
@property (nonatomic, retain) NSString *usphonetic;
@property (nonatomic, retain) NSData *translate;


@end

NS_ASSUME_NONNULL_END

#import "WordEntity+CoreDataProperties.h"
