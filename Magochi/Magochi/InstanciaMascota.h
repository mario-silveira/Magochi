//
//  InstanciaMascota.h
//  Magochi
//
//  Created by Mario Silveira on 11/24/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mascota.h"

@interface InstanciaMascota : NSObject

+ (InstanciaMascota*) sharedInstance;
-(void) iniciarEjercicio;
-(void) pararEjercicio;
-(void) setMascota: (Mascota*) pet;
-(Mascota*) getMascota;
-(NSNumber*) getEnergia;
-(void) subaEnergia: (NSNumber*) energia;
-(void) recibirMascota;
-(void) setearUbicacion: (CLLocation*) location;
-(void) recibirTodasMascotas;
-(NSMutableArray*) getMascotas;
-(void) cargarMascota;

-(void) tickTimerEjercicio;

@end
