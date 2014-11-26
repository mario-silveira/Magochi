//
//  InstanciaMascota.m
//  Magochi
//
//  Created by Mario Silveira on 11/24/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "InstanciaMascota.h"
#import "NSTimer+StopTimer.h"
#import "NetworkManager.h"

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

    return instancia;
}

-(void) setMascota: (Mascota*) pet {
    _mascota = pet;
}

-(Mascota*) getMascota {
    return _mascota;
}

-(void) configurarTimerEjercicio {
    _instanciaMascota.timerEjercicio = [NSTimer scheduledTimerWithTimeInterval:1
                                                                        target:self
                                                                      selector:@selector(tickTimerEjercicio)
                                                                      userInfo:nil
                                                                       repeats:YES];
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
        [self subirExperiencia];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESCAR_ENERGIA"
                                             object:_energia];
    } else {
        [self exhausto];
    }
}

-(void) exhausto {
    [self.timerEjercicio pararTimer];
    _timerEjercicio = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MASCOTA_EXHAUSTA" object:nil];
}

-(void) pararEjercicio {
    if (_timerEjercicio && [_timerEjercicio isValid]){
        [_timerEjercicio invalidate];
    }
    _timerEjercicio = nil;
}

-(NSNumber*) getEnergia {
    return _energia;
}

- (void) subaEnergia: (NSNumber*) energia {
    self.energia = MIN([[NSNumber alloc] initWithInt:100], [[NSNumber alloc] initWithInt:[energia integerValue] + [self.energia integerValue]]);
    NSLog(@"energia:%@", self.energia);
}

- (void) subirExperiencia {
    self.mascota.experiencia = [[NSNumber alloc] initWithInt:[self.mascota.experiencia intValue] + 10];
    NSLog(@"Experiencia:%@", self.mascota.experiencia);
    if (self.mascota.experiencia.intValue >= self.mascota.experienciaSiguienteNivel.intValue) {
        [self subirNivel];
        NSLog(@"NUEVO NIVEL!!!");
    }
}

- (void) subirNivel {
    self.mascota.nivel = [[NSNumber alloc] initWithInt:[self.mascota.nivel intValue] + 1 ];
    [self.mascota setExperienciaSiguienteNivel:[self experienciaNuevoNivel]];
    NSLog(@"Experiencia siguiente nivel: %@", self.mascota.experienciaSiguienteNivel);
    [self enviarNuevoNivel];
}

- (NSNumber*) experienciaNuevoNivel {
    return [[NSNumber alloc] initWithInt:100 * (self.mascota.nivel.intValue * self.mascota.nivel.intValue)];
}

-(void) enviarNuevoNivel {
    NSLog(@"llego al llamado");
    [[NetworkManager sharedInstance] POST:@"/pet"
                               parameters:[[self getMascota] dataForSending]
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
        //                              NSHTTPURLResponse* httpRsp = (NSHTTPURLResponse*) responseObject;
                                      if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]){
                                          NSLog(@"la info llego sin error");
                                      } else {
                                          NSLog(@"hay errores en el llamado");
                                      }
                                      
                                      
                                  }
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

-(void) recibirMascota {
    [[NetworkManager sharedInstance] GET:@"/pet/MSILVEIRA8031"
                              parameters:nil
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                     NSString* nombre = [responseObject objectForKey:@"name"];
                                     NSNumber* experiencia = [responseObject objectForKey:@"experience"];
                                     NSNumber* nivel = [responseObject objectForKey:@"level"];
                                     NSNumber* energia = [responseObject objectForKey:@"energy"];
                                     
                                     
                                 }
                                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     NSLog(@"hay errores en el llamado:%@", error.localizedDescription);
                                 }];
}



@end
