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
#import "Persistencia.h"

@implementation Mascota

-(Mascota*) init {
    self = [super init];
    if (self) {
        self.codigo = CODIGO_MASCOTA;
        self.energia = [[NSNumber alloc]initWithInt:100];
        self.nivel = [[NSNumber alloc]initWithInt:1];
        self.experiencia = 0;
        
        self.experienciaSiguienteNivel = [[NSNumber alloc]initWithInt:100];
    }
    
    return self;
}

-(Mascota*)initMascotaRanking: (NSString*) nombre tipo:(NSNumber*) tipo nivel:(NSNumber*) nivel codigo:(NSString*) codigo ubicacion:(CLLocation*) ubicacion {
    self = [super init];
    if (self){
        self.nombre = nombre;
        self.tipo = tipo;
        self.nivel = nivel;
        self.codigo = codigo;
        self.ubicacion = ubicacion;
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)coder{
    if(self = [super init]){
        [self setCodigo:[coder decodeObjectForKey:@"code"]];
        [self setNombre:[coder decodeObjectForKey:@"name"]];
        [self setEnergia:[coder decodeObjectForKey:@"energy"]];
        [self setNivel:[coder decodeObjectForKey:@"level"]];
        [self setExperiencia:[coder decodeObjectForKey:@"experience"]];
        [self setTipo:[coder decodeObjectForKey:@"pet_type"]];
     /*   CLLocation* location = [[CLLocation alloc]init];
        location.coordinate.latitude = [coder decodeObjectForKey:@"position_lat"];
        [self setUbicacion:location];*/
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.codigo forKey:@"code"];
    [coder encodeObject:self.nombre forKey:@"name"];
    [coder encodeObject:self.energia forKey:@"energy"];
    [coder encodeObject:self.nivel forKey:@"level"];
    [coder encodeObject:self.experiencia forKey:@"experience"];
    [coder encodeObject:self.tipo forKey:@"pet_type"];
}

-(void)setTipo:(NSNumber *)tipo{
    _tipo = tipo;
    [self setImagenes:[Utils getImagenes][tipo.intValue]];
    
}

-(NSDictionary*) dataForSending{
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

-(void)guardarMascota{
    [Persistencia guardarMascota:self];
}

+(Mascota*)cargarMascota{
    return [Persistencia cargarMascota];
}

@end


