//
//  ViewControllerDetalles.m
//  Magochi
//
//  Created by Mario Silveira on 12/4/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerDetalles.h"
#import "ServicioGetMascota.h"
#import "Mascota.h"

@interface ViewControllerDetalles ()

@property (nonatomic, strong) NSString* codigo;
@property (nonatomic, strong) Mascota* mascota;

@end

@implementation ViewControllerDetalles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    ServicioGetMascota* servicioGetMascota = [[ServicioGetMascota alloc] init];
    [servicioGetMascota recibirMascota:self.codigo bloque: ^(Mascota * mascota) {
        [weakSelf setMascota:mascota];
        [weakSelf cargarData];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)setCodigo:(NSString*) codigo{
    _codigo = codigo;
}

-(void)cargarData{
    [self.lblDetalle setText:self.mascota.nombre];
    
}

@end
