//
//  InstanciaMascota.h
//  Magochi
//
//  Created by Mario Silveira on 11/24/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mascota.h"


typedef void (^Success)(NSURLSessionDataTask *task, id responseObject);
typedef void (^Failure)(NSURLSessionDataTask *task, NSError *error);

@interface InstanciaMascota : NSObject

+ (InstanciaMascota*) sharedInstance;
-(void) iniciarEjercicio;
-(void) pararEjercicio;
-(void) setMascota: (Mascota*) pet;
-(Mascota*) getMascota;
-(NSNumber*) getEnergia;
-(void) subaEnergia: (NSNumber*) energia;
-(void) recibirMascota;

@end
