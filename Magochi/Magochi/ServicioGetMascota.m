//
//  ServicioGetMascota.m
//  Magochi
//
//  Created by Mario Silveira on 12/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ServicioGetMascota.h"
#import "NetworkManager.h"

@interface ServicioGetMascota ()

@property (nonatomic, copy) SuccessGetMascota successBlock;

@end

@implementation ServicioGetMascota

-(void) recibirMascota:(NSString*) codigo bloque:(SuccessGetMascota) bloque {
    
    self.successBlock = bloque;
    
    [[NetworkManager sharedInstance] GET:[NSString stringWithFormat:@"/pet/%@", codigo]
                              parameters:nil
                                 success:[self successGetBlock]
                                 failure:[self getFailureGetBlock]];
}

-(void (^)(NSURLSessionDataTask *task, id responseObject)) successGetBlock {
  //  __weak typeof(self) weakSelf = self;
    return ^(NSURLSessionDataTask* task, id responseObject){
        __weak typeof(self) weakSelf = self;
        Mascota* mascota = [[Mascota alloc] init];
        mascota.energia = [responseObject objectForKey:@"energy"];
        mascota.codigo = [responseObject objectForKey:@"code"];
        mascota.nivel = [responseObject objectForKey:@"level"];
        mascota.experiencia = [responseObject objectForKey:@"experience"];
        mascota.nombre = [responseObject objectForKey:@"name"];
        mascota.tipo = [responseObject objectForKey:@"pet_type"];
        mascota.experienciaSiguienteNivel = [[NSNumber alloc] initWithInt:100 * (mascota.nivel.intValue * mascota.nivel.intValue)];
        
        weakSelf.successBlock(mascota);
    };
    
}


-(void (^)(NSURLSessionDataTask *task, NSError *error))getFailureGetBlock {
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error en recibir la mascota: %@",error);
    };
}

@end
