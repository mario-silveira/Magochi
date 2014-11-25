//
//  Comida.m
//  Magochi
//
//  Created by Mario Silveira on 11/20/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comida.h"



@implementation Comida : NSObject


-(id) initWithData:(NSNumber *) identifier :(NSString *)nombre :(NSString *)imagen {
    Comida* comida = [[Comida alloc]init];
    comida.idComida = identifier;
    comida.nombreComida = nombre;
    comida.imagenComida = imagen;
    comida.valor = [[NSNumber alloc]initWithInt:50];
    return comida;
}

@end

