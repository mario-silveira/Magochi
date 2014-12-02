//
//  Mascota.m
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "Mascota.h"
#import "Utils.h"
#import "Constantes.h"

@implementation Mascota

-(Mascota*) init {
    Mascota* mascota = [super init];
    if (mascota) {
        mascota.codigo = CODIGO_MASCOTA;
        mascota.energia = [[NSNumber alloc]initWithInt:100];
        mascota.nivel = [[NSNumber alloc]initWithInt:1];
        mascota.experiencia = 0;
        
        mascota.experienciaSiguienteNivel = [[NSNumber alloc]initWithInt:100];
    }
    
    return mascota;
}

-(Mascota*)initMascotaRanking: (NSString*) nombre tipo:(NSNumber*) tipo nivel:(NSNumber*) nivel codigo:(NSString*) codigo ubicacion:(CLLocation*) ubicacion {
    Mascota* mascota = [super init];
    if (mascota){
        mascota.nombre = nombre;
        mascota.tipo = tipo;
        mascota.nivel = nivel;
        mascota.codigo = codigo;
        mascota.ubicacion = ubicacion;
    }
    
    return mascota;
}

-(void)setTipo:(NSNumber *)tipo{
    _tipo = tipo;
    [self setImagenes:[Utils getImagenes][tipo.intValue]];
    
}

-(NSDictionary*) dataForSending{
    NSLog(@"lat %f", self.ubicacion.coordinate.latitude);
    NSLog(@"lon %f", self.ubicacion.coordinate.longitude);
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.codigo, @"code",
            self.nombre, @"name",
            self.energia, @"energy",
            self.nivel, @"level",
            [NSString stringWithFormat:@"%f", self.ubicacion.coordinate.latitude], @"position_lat",
            [NSString stringWithFormat:@"%f", self.ubicacion.coordinate.longitude], @"position_lon",
            self.experiencia, @"experience",
            self.tipo, @"pet_type",nil];
}

-(NSString*) getImagenMascota{
    return self.imagenes.imagen;
}

-(NSArray*) getImagenesComiendo{
    return self.imagenes.imagenesComiendo;
}

-(NSArray*) getImagenesEjercitando{
    return self.imagenes.imagenesEjercicio;
}

-(NSArray*) getImagenesCansado{
    return self.imagenes.imagenesCansado;
}

@end


