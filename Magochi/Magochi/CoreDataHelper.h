//
//  CoreDataHelper.h
//  Magochi
//
//  Created by Mario Silveira on 12/3/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataHelper*) sharedInstance;

- (NSURL *)applicationDocumentsDirectory;

-(NSArray*) getMascotasRanking;
-(void) guardarMascotasRanking: (NSArray*) mascotas;
-(void) borrarMascotasRanking;

@end
