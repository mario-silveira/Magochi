//
//  ServicioGetTodasMascotas.m
//  Magochi
//
//  Created by Mario Silveira on 12/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ServicioGetTodasMascotas.h"
#import "NetworkManager.h"
#import "CoreDataHelper.h"

@interface ServicioGetTodasMascotas ()

@property (nonatomic, copy) SuccessGetTodasMascota successBlock;

@end

@implementation ServicioGetTodasMascotas


-(void) recibirTodasMascotas : (SuccessGetTodasMascota) bloque {
    
    self.successBlock = bloque;
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
        NSNumber* latitud;
        NSNumber* longitud;
        [[CoreDataHelper sharedInstance] borrarMascotasRanking];
        NSManagedObjectContext*context = [[CoreDataHelper sharedInstance] managedObjectContext];
        for (NSDictionary* data in responseObject) {
            nombre = [data objectForKey:@"name"];
            tipo = [data objectForKey:@"pet_type"];
            nivel = [data objectForKey:@"level"];
            codigo = [data objectForKey:@"code"];
            latitud = [data objectForKey:@"position_lat"];
            longitud = [data objectForKey:@"position_lon"];
            
            Mascota * mascota = (Mascota*)[NSEntityDescription insertNewObjectForEntityForName:@"Mascota"
                                                                      inManagedObjectContext: context];
//            [mascotasDesordenadas addObject:[[Mascota alloc]initMascotaRanking:nombre tipo:tipo nivel:nivel codigo:codigo latitud:latitud longitud:longitud]];
                                         
            [mascota setNombre: nombre];
            [mascota setTipo: tipo];
            [mascota setCodigo: codigo];
            [mascota setLatitud: latitud];
            [mascota setLongitud: longitud];
            [mascota setNivel: nivel];
            [mascotasDesordenadas addObject: mascota];
                                         
        }
        
        NSError* error;
        if (![context save:&error]){
            NSLog(@"Error al guardar los datos");
            [context rollback];
        }
        
        NSArray* mascotasOrdenadas = [mascotasDesordenadas sortedArrayUsingComparator:^NSComparisonResult(Mascota* a, Mascota* b) {
            NSNumber *first = a.nivel;
            NSNumber *second =b.nivel;
            return [second compare:first];
        }];
        
        
        self.successBlock([mascotasOrdenadas copy]);
    };
}

-(void (^)(NSURLSessionDataTask *task, NSError *error)) failureGetAllPetsBlock {
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error en recibir la mascota: %@",error);
    };
}
@end
