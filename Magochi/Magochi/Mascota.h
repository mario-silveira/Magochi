//
//  Mascota.h
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Imagenes.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

@interface Mascota : NSManagedObject <NSCoding>

@property (nonatomic, strong) NSString* codigo;
@property (nonatomic, strong) NSString* nombre;
@property (nonatomic, strong) NSNumber* tipo;
@property (nonatomic, strong) NSNumber* energia;
@property (nonatomic, strong) NSNumber* nivel;
@property (nonatomic, strong) NSNumber* experiencia;
@property (nonatomic, strong) NSNumber* experienciaSiguienteNivel;
@property (nonatomic, strong) Imagenes* imagenes;
@property (nonatomic, strong) NSNumber* latitud;
@property (nonatomic, strong) NSNumber* longitud;


-(Mascota*)initMascotaRanking: (NSString*) nombre tipo:(NSNumber*) tipo nivel:(NSNumber*) nivel codigo:(NSString*) codigo latitud:(NSNumber*) latitud longitud:(NSNumber*) longitud;

-(NSDictionary*) dataForSending;
-(NSString*) getImagenMascota;
-(NSArray*) getImagenesComiendo;
-(NSArray*) getImagenesEjercitando;
-(NSArray*) getImagenesCansado;
-(id)initWithCoder:(NSCoder *)coder;
-(void)encodeWithCoder:(NSCoder *)coder;
-(void)guardarMascota;
+(Mascota*) cargarMascota;
-(void) setTipo :(NSNumber*) tipo;

@end
