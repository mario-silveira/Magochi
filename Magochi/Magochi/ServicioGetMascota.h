//
//  ServicioGetMascota.h
//  Magochi
//
//  Created by Mario Silveira on 12/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mascota.h"

@interface ServicioGetMascota : NSObject

typedef void (^SuccessGetMascota)(Mascota*);

-(void) recibirMascota:(SuccessGetMascota) successblock;

@end
