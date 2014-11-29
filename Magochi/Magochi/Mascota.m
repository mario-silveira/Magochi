//
//  Mascota.m
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "Mascota.h"
#import "Utils.h"

@implementation Mascota

-(Mascota*) init {
    Mascota* mascota = [super init];
    mascota.codigo = @"MSILVEIRA8031";
    mascota.energia = [[NSNumber alloc]initWithInt:100];
    mascota.nivel = [[NSNumber alloc]initWithInt:1];
    mascota.experiencia = 0;
    
    mascota.experienciaSiguienteNivel = [[NSNumber alloc]initWithInt:100];
    return mascota;
}

-(Mascota*)initMascotaRanking: (NSString*) nombre tipo:(NSNumber*) tipo nivel:(NSNumber*) nivel codigo:(NSString*) codigo {
    Mascota* mascota = [super init];
    mascota.nombre = nombre;
    mascota.tipo = tipo;
    mascota.nivel = nivel;
    mascota.codigo = codigo;
    return mascota;
}

-(void)setTipo:(NSNumber *)tipo{
    _tipo = tipo;
    [self setImagenes:[Utils getImagenes][tipo.intValue]];
    
}

-(NSDictionary*) dataForSending{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.codigo, @"code",
             self.nombre, @"name",
             self.energia, @"energy",
             self.nivel, @"level",
             self.experiencia, @"experience",
             self.tipo, @"pet_type", nil];
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


