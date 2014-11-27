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

-(NSDictionary*) dataForSending{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.codigo, @"code",
             self.nombre, @"name",
             self.energia, @"energy",
             self.nivel, @"level",
             self.experiencia, @"experience",
             self.tipo, @"pet_type", nil];
}

@end


