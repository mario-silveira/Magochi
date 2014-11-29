//
//  Mascota.h
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Imagenes.h"

@interface Mascota : NSObject

@property NSString* codigo;
@property NSString* nombre;
@property (nonatomic) NSNumber* tipo;
@property NSNumber* energia;
@property NSNumber* nivel;
@property NSNumber* experiencia;
@property NSNumber* experienciaSiguienteNivel;
@property (nonatomic) Imagenes* imagenes;

-(Mascota*)initMascotaRanking: (NSString*) nombre tipo:(NSNumber*) tipo nivel:(NSNumber*) nivel codigo:(NSString*) codigo;
-(NSDictionary*) dataForSending;
-(NSString*) getImagenMascota;
-(NSArray*) getImagenesComiendo;
-(NSArray*) getImagenesEjercitando;
-(NSArray*) getImagenesCansado;

@end
