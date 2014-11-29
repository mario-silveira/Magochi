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
#import <Parse/Parse.h>
#import "ViewControllerGameView.h"


@interface InstanciaMascota ()

@property (nonatomic)  Mascota* mascota;
@property (nonatomic, strong) NSNumber* energia;
@property NSTimer* timerEjercicio;
@property NSArray* mascotas;

@property (nonatomic, copy) Success successGetBlock;
@property (nonatomic, copy) Failure failureGetBlock;
@property (nonatomic, copy) Success successGetAllPetsBlock;
@property (nonatomic, copy) Failure failureGetAllPetsBlock;

@end

@implementation InstanciaMascota

__strong static InstanciaMascota *_instanciaMascota = nil;
__weak typeof(InstanciaMascota) *weakSelf;

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
    weakSelf = self;

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
    
 //   [self createNotification];
    
    [self sendRemoteNotification];
    
    [[NetworkManager sharedInstance] POST:@"/pet"
                               parameters:[[self getMascota] dataForSending]
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      NSHTTPURLResponse* httpRsp = (NSHTTPURLResponse*) responseObject;
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

-(void) createNotification{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [[NSDate alloc] init];
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatCalendar = [NSCalendar currentCalendar];
    localNotification.alertBody = @"Nuevo Nivel!!";
    
    localNotification.userInfo = [_mascota dataForSending];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    
    // Schedule the notification
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

-(void) recibirMascota {
    
    [[NetworkManager sharedInstance] GET:@"/pet/MSILVEIRA8031"
                              parameters:nil
                                 success:[self getSuccessGetBlock]
                                 failure:[self getFailureGetBlock]];
}

- (void) sendRemoteNotification{

    PFPush *push = [[PFPush alloc] init];
    
    [push setChannel:@"PeleaDeMascotas"];
    [push setMessage:@"Nuevo Nivel"];
    [push setData:[[self mascota] dataForSending]];
    [push sendPushInBackground];
}

-(Success)getSuccessGetBlock {
    
    return ^(NSURLSessionDataTask* task, id responseObject){
        
        Mascota* mascota = [[Mascota alloc] init];
        mascota.energia = [responseObject objectForKey:@"energy"];
        mascota.codigo = [responseObject objectForKey:@"code"];
        mascota.nivel = [responseObject objectForKey:@"level"];
        mascota.experiencia = [responseObject objectForKey:@"experience"];
        mascota.nombre = [responseObject objectForKey:@"name"];
        mascota.tipo = [responseObject objectForKey:@"pet_type"];
        mascota.experienciaSiguienteNivel = [[NSNumber alloc] initWithInt:100 * (mascota.nivel.intValue * mascota.nivel.intValue)];
        [weakSelf setMascota:mascota];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MASCOTA_CARGADA" object:nil];
    };
    
}


-(Failure)getFailureGetBlock {
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error en recibir la mascota: %@",error);
    };
}


-(void) recibirTodasMascotas {
    [[NetworkManager sharedInstance] GET:@"/pet/all"
                              parameters:nil
                                 success:[self successGetAllPetsBlock]
                                 failure:[self failureGetAllPetsBlock]];

}

-(Success) successGetAllPetsBlock{
    return ^(NSURLSessionDataTask* task, id responseObject){
    
        NSMutableArray* mascotasDesordenadas = [[NSMutableArray alloc] init];
        
        NSString* nombre;
        NSNumber* tipo;
        NSNumber* nivel;
        NSString* codigo;
        for (NSDictionary* data in responseObject) {
            nombre = [data objectForKey:@"name"];
            tipo = [data objectForKey:@"pet_type"];
            nivel = [data objectForKey:@"level"];
            codigo = [data objectForKeyedSubscript:@"code"];
            [mascotasDesordenadas addObject:[[Mascota alloc]initMascotaRanking:nombre tipo:tipo nivel:nivel codigo:codigo]];
        }
        
        weakSelf.mascotas = [mascotasDesordenadas sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber *first = ((Mascota*) a).nivel;
            NSNumber *second =((Mascota*) b).nivel;
            return [second compare:first];
        }];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RANKING_CARGADO" object:nil];
    };
}

-(Failure)failureGetAllPetsBlock {
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error en recibir la mascota: %@",error);
    };
}

-(NSArray*) getMascotas{
    return _mascotas;
}


@end
