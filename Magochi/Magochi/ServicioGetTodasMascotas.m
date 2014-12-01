//
//  ServicioGetTodasMascotas.m
//  Magochi
//
//  Created by Mario Silveira on 12/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ServicioGetTodasMascotas.h"
#import "NetworkManager.h"

@interface ServicioGetTodasMascotas ()

@property (nonatomic, copy) SuccessGetTodasMascota successBlock;

@end

@implementation ServicioGetTodasMascotas


-(void) recibirTodasMascotas : (SuccessGetTodasMascota) successblock{
    [[NetworkManager sharedInstance] GET:@"/pet/all"
                              parameters:nil
                                 success:[self successGetAllPetsBlock]
                                 failure:[self failureGetAllPetsBlock]];
}

-(void (^)(NSURLSessionDataTask *task, id responseObject)) successGetAllPetsBlock {
    
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
        NSArray* mascotasOrdenadas = [mascotasDesordenadas sortedArrayUsingComparator:^NSComparisonResult(Mascota* a, Mascota* b) {
            NSNumber *first = a.nivel;
            NSNumber *second =b.nivel;
            return [second compare:first];
        }];
        
        self.successBlock(mascotasOrdenadas);
    };
}

-(void (^)(NSURLSessionDataTask *task, NSError *error)) failureGetAllPetsBlock {
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error en recibir la mascota: %@",error);
    };
}
@end
