//
//  InstanciaMascota.m
//  Magochi
//
//  Created by Mario Silveira on 11/24/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "InstanciaMascota.h"

@interface InstanciaMascota ()

@property (nonatomic)  Mascota* mascota;
@property (nonatomic, strong) NSNumber* energia;
@property NSTimer* timerEjercicio;

@end

@implementation InstanciaMascota

__strong static InstanciaMascota *_instanciaMascota = nil;

+(InstanciaMascota*) sharedInstance {
    
    static dispatch_once_t pred = 0;
    
    
    dispatch_once(&pred, ^{
        _instanciaMascota = [[InstanciaMascota alloc]init];
    });
    
    return  _instanciaMascota;
    
}

-(InstanciaMascota*) init {
    InstanciaMascota* instancia = [super init];
    instancia.energia = [[NSNumber alloc]initWithInt:100];
  /*  instancia.timerEjercicio = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tickTimerEjercicio) userInfo:nil repeats:YES];
    */
    return instancia;
}

-(void) setMascota: (Mascota*) pet {
    _mascota = pet;
}

-(Mascota*) getMascota {
    return _mascota;
}

-(void) configurarTimerEjercicio {
    _instanciaMascota.timerEjercicio = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tickTimerEjercicio) userInfo:nil repeats:YES];
}

-(void) iniciarEjercicio {
    if(!_timerEjercicio){
        [self configurarTimerEjercicio];
    }
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timerEjercicio forMode:NSDefaultRunLoopMode];
}

-(void) tickTimerEjercicio {
    if (_energia.intValue > 0) {
        _energia = [NSNumber numberWithInt:[_energia intValue] - 10];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESCAR_ENERGIA"
                                             object:_energia];
    } else {
        [self pararEjercicio];
    }
}

-(void) pararEjercicio {
    if (_timerEjercicio && [_timerEjercicio isValid]){
        [_timerEjercicio invalidate];
    }
    _timerEjercicio = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PARAR_EJERCICIO" object:nil];
}

-(NSNumber*) getEnergia {
    return _energia;
}

- (void) subaEnergia: (NSNumber*) energia {
    self.energia = energia;
}

@end
