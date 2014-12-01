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

@property (nonatomic, strong) NSString* codigo;
@property (nonatomic, strong) NSString* nombre;
@property (nonatomic, strong) NSNumber* tipo;
@property (nonatomic, strong) NSNumber* energia;
@property (nonatomic, strong) NSNumber* nivel;
@property (nonatomic, strong) NSNumber* experiencia;
@property (nonatomic, strong) NSNumber* experienciaSiguienteNivel;
@property (nonatomic, strong) Imagenes* imagenes;

-(Mascota*)initMascotaRanking: (NSString*) nombre tipo:(NSNumber*) tipo nivel:(NSNumber*) nivel codigo:(NSString*) codigo;
-(NSDictionary*) dataForSending;
-(NSString*) getImagenMascota;
-(NSArray*) getImagenesComiendo;
-(NSArray*) getImagenesEjercitando;
-(NSArray*) getImagenesCansado;

@end
