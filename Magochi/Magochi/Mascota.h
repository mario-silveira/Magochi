//
//  Mascota.h
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mascota : NSObject

@property NSString* nombre;
@property NSString* tipo;
@property NSString* imagen;
@property NSArray* imagenesComiendo;
@property NSArray* imagenesEjercicio;
@property NSNumber* energia;

@end
