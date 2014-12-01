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
#import "Imagenes.h"
@interface Utils ()

//@property (nonatomic, strong) NSArray* mascotas;

@end


static NSArray *imagenes;

@implementation Utils


+(void)cargarImagenes {
    
    Imagenes* ciervo = [[Imagenes alloc]init];
    ciervo.imagen = @"ciervo_comiendo_1";
    ciervo.imagenesComiendo = [[NSArray alloc]initWithObjects:
                           @"ciervo_comiendo_1",
                           @"ciervo_comiendo_2",
                           @"ciervo_comiendo_3",
                           @"ciervo_comiendo_4", nil];
    ciervo.imagenesEjercicio = [[NSArray alloc]initWithObjects:
                               @"ciervo_ejercicio_1",
                               @"ciervo_ejercicio_2",
                               @"ciervo_ejercicio_3",
                               @"ciervo_ejercicio_4",
                               @"ciervo_ejercicio_5", nil];
    ciervo.imagenesCansado = [[NSArray alloc]initWithObjects:
                              @"ciervo_exhausto_1",
                              @"ciervo_exhausto_2",
                              @"ciervo_exhausto_3",
                              @"ciervo_exhausto_4", nil];
    
    
    Imagenes* gato = [[Imagenes alloc]init];
    gato.imagen = @"gato_comiendo_1";
    gato.imagenesComiendo = [[NSArray alloc]initWithObjects:
                            @"gato_comiendo_1",
                            @"gato_comiendo_2",
                            @"gato_comiendo_3",
                            @"gato_comiendo_4", nil];
    gato.imagenesEjercicio = [[NSArray alloc]initWithObjects:
                              @"gato_ejercicio_1",
                              @"gato_ejercicio_2",
                              @"gato_ejercicio_3",
                              @"gato_ejercicio_4",
                              @"gato_ejercicio_5", nil];
    gato.imagenesCansado = [[NSArray alloc]initWithObjects:
                            @"gato_exhausto_1",
                            @"gato_exhausto_2",
                            @"gato_exhausto_3",
                            @"gato_exhausto_4", nil];
    
    Imagenes* leon = [[Imagenes alloc]init];
    leon.imagen = @"leon_comiendo_1";
    leon.imagenesComiendo = [[NSArray alloc]initWithObjects:
                            @"leon_comiendo_1",
                            @"leon_comiendo_2",
                            @"leon_comiendo_3",
                            @"leon_comiendo_4", nil];
    leon.imagenesEjercicio = [[NSArray alloc]initWithObjects:
                             @"leon_ejercicio_1",
                             @"leon_ejercicio_2",
                             @"leon_ejercicio_3",
                             @"leon_ejercicio_4",
                             @"leon_ejercicio_5", nil];
    leon.imagenesCansado = [[NSArray alloc]initWithObjects:
                            @"leon_exhausto_1",
                            @"leon_exhausto_2",
                            @"leon_exhausto_3",
                            @"leon_exhausto_4", nil];
    
    Imagenes* jirafa = [[Imagenes alloc]init];
    jirafa.imagen = @"jirafa_comiendo_1";
    jirafa.imagenesComiendo = [[NSArray alloc]initWithObjects:
                               @"jirafa_comiendo_1",
                               @"jirafa_comiendo_2",
                               @"jirafa_comiendo_3",
                               @"jirafa_comiendo_4", nil];
    jirafa.imagenesEjercicio = [[NSArray alloc]initWithObjects:
                                @"jirafa_ejercicio_1",
                                @"jirafa_ejercicio_2",
                                @"jirafa_ejercicio_3",
                                @"jirafa_ejercicio_4",
                                @"jirafa_ejercicio_5", nil];
    jirafa.imagenesCansado = [[NSArray alloc]initWithObjects:
                              @"jirafa_exhausto_1",
                              @"jirafa_exhausto_2",
                              @"jirafa_exhausto_3",
                              @"jirafa_exhausto_4", nil];

    
    imagenes = [[NSArray alloc]initWithObjects:ciervo, gato, leon, jirafa, nil];
}

+(NSArray*) getImagenes{
    return imagenes;
}



@end
