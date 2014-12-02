//
//  Persistencia.h
//  Magochi
//
//  Created by Mario Silveira on 12/2/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mascota.h"

@interface Persistencia : NSObject


+(void) guardarMascota : (Mascota*) mascota;
+(Mascota*) cargarMascota;


@end
