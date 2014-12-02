//
//  Persistencia.m
//  Magochi
//
//  Created by Mario Silveira on 12/2/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "Persistencia.h"

@implementation Persistencia


+(void)guardarMascota:(Mascota *)mascota{
    NSString* path = [self pathForFile];
    
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue:mascota forKey:@"mascota"];
    [NSKeyedArchiver archiveRootObject:rootObject toFile:path];
    
}

+(Mascota *)cargarMascota {
    NSString* path = [self pathForFile];
    
    NSDictionary* rootObj;
    
    rootObj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return [rootObj objectForKey:@"mascota"];
}


+(NSString*) pathForFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError* error;
    
    directory = [directory stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: directory] == NO)
    {
        
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return [directory stringByAppendingString:@"/Tamagochi.ios"];

}
@end
