//
//  Utils.m
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "Mascota.h"
@interface Utils ()

//@property (nonatomic, strong) NSArray* mascotas;

@end


static NSArray *mascotas;

@implementation Utils


+(void)cargarMascotas {
    
    Mascota* ciervo = [[Mascota alloc]init];
    ciervo.tipo = @"Ciervo";
    ciervo.imagen = @"ciervo_comiendo_1";
    ciervo.imagenesComiendo = [[NSArray alloc]initWithObjects:
                           @"ciervo_comiendo_1",
                           @"ciervo_comiendo_2",
                           @"ciervo_comiendo_3",
                           @"ciervo_comiendo_4", nil];
    
    Mascota* gato = [[Mascota alloc]init];
    gato.tipo = @"Gato";
    gato.imagen = @"gato_comiendo_1";
    gato.imagenesComiendo = [[NSArray alloc]initWithObjects:
                               @"gato_comiendo_1",
                               @"gato_comiendo_2",
                               @"gato_comiendo_3",
                               @"gato_comiendo_4", nil];
    
    Mascota* jirafa = [[Mascota alloc]init];
    jirafa.tipo = @"Jirafa";
    jirafa.imagen = @"jirafa_comiendo_1";
    jirafa.imagenesComiendo = [[NSArray alloc]initWithObjects:
                               @"jirafa_comiendo_1",
                               @"jirafa_comiendo_2",
                               @"jirafa_comiendo_3",
                               @"jirafa_comiendo_4", nil];
    
    Mascota* leon = [[Mascota alloc]init];
    leon.tipo = @"Leon";
    leon.imagen = @"leon_comiendo_1";
    leon.imagenesComiendo = [[NSArray alloc]initWithObjects:
                               @"leon_comiendo_1",
                               @"leon_comiendo_2",
                               @"leon_comiendo_3",
                               @"leon_comiendo_4", nil];
    
    mascotas = [[NSArray alloc]initWithObjects:ciervo, gato, jirafa, leon, nil];
}

+(NSArray*) getMascotas{
    return mascotas;
}


@end
