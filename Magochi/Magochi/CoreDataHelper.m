//
//  CoreDataHelper.m
//  Magochi
//
//  Created by Mario Silveira on 12/3/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "CoreDataHelper.h"
#import "Mascota.h"

@implementation CoreDataHelper

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


__strong static CoreDataHelper *_coreDataHelper = nil;
__weak typeof(CoreDataHelper) *weakSelf;

+(CoreDataHelper*) sharedInstance {
    
    static dispatch_once_t pred = 0;
    
    
    dispatch_once(&pred, ^{
        _coreDataHelper = [[CoreDataHelper alloc]init];
    });
    
    return  _coreDataHelper;
    
}




- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Base" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Base.xcdatamideld"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


-(NSArray *)getMascotasRanking {
    NSManagedObjectContext* context = [self managedObjectContext];
    NSFetchRequest* fetch = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entidad = [NSEntityDescription entityForName:@"Mascota" inManagedObjectContext:context];
    
    [fetch setEntity:entidad];
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"nivel" ascending:NO];
    [fetch setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError* error;
    NSArray* result = [context executeFetchRequest:fetch error:&error];
    
    if (error){
        NSLog(@"Ocurrio un error al traer datos");
    }
    
    return result;
}

-(void) guardarMascotasRanking: (NSArray*) mascotas {
    NSManagedObjectContext* context = [self managedObjectContext];
    
    for (Mascota* mascota in mascotas) {
        Mascota* m = [NSEntityDescription insertNewObjectForEntityForName:@"Mascota" inManagedObjectContext:context];
        [m setCodigo:mascota.codigo];
        [m setNombre:mascota.nombre];
        [m setNivel:mascota.nivel];
        [m setLatitud:mascota.latitud];
        [m setLongitud:mascota.longitud];
    }
    
    NSError* error;
    if (![context save:&error]){
        NSLog(@"Error al guardar los datos");
        [context rollback];
    }
}

-(void)borrarMascotasRanking {
    NSManagedObjectContext* context = [self managedObjectContext];
    
    NSArray* data = [self getMascotasRanking];
    
    for (Mascota* mascota in data){
        [context deleteObject:mascota];
    }
    NSError* error;
    if (![context save:&error]){
        NSLog(@"Error al borrar mascotas: %@", [error localizedDescription]);
        [context rollback];
    }
}

@end
