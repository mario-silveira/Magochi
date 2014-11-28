//
//  Utils.h
//  Magochi
//
//  Created by Mario Silveira on 11/19/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#ifndef Magochi_Utils_h
#define Magochi_Utils_h

enum typeDef {
    Ciervo = 0,
    Gato = 1,
    Jirafa = 2,
    Leon = 3,
} tipoMascota;

@interface Utils : NSObject


+(void)cargarImagenes;
+(NSArray*) getImagenes;


@end




#endif
