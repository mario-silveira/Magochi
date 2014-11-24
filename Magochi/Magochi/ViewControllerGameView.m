//
//  ViewControllerGameView.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerGameView.h"
#import "Utils.h"
#import "Comida.h"
#import "InstanciaMascota.h"

@interface ViewControllerGameView ()

@property (strong, nonatomic) IBOutlet UIImageView *imgComida;
@property BOOL comidaCargada;
@property BOOL ejercitando;

@end

@implementation ViewControllerGameView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.comidaCargada = NO;
    self.ejercitando = NO;
    
}

- (NSArray *) cargarArrayAnimacion:(NSArray *) array{
    
    NSMutableArray* result = [[NSMutableArray alloc] init];
    
    for (NSString* item in array){
        [result addObject:[UIImage imageNamed:item]];
    }
    return [[NSArray alloc]initWithArray:result];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = self.mascota.nombre;
    self.imgMascota.image = [UIImage imageNamed:self.mascota.imagen];
    
    self.imgComida.alpha = 1;
    self.imgComida.center = CGPointMake(281.0f, 572.0f);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refrescarEnergia:) name:@"REFRESCAR_ENERGIA"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pararEjercicio) name:@"PARAR_EJERCICIO"
                                               object:nil];
    

    [self refrescarEnergia:[[InstanciaMascota sharedInstance] getEnergia]];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.title = @"";
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithData: (Mascota*) mascota {
    self = [super initWithNibName:@"ViewControllerGameView" bundle:nil];
    self.mascota = mascota;
    return self;
}

-(void) setComida: (Comida*) comida{
    self.imgComida.image = [UIImage imageNamed:comida.imagenComida];
    self.comidaCargada = YES;
}


- (IBAction)btnComer:(UIButton *)sender {
    
    ViewControllerTablaComidas* newView = [[ViewControllerTablaComidas alloc]init];
    newView.delegate = self;
    
    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction)tapView:(UITapGestureRecognizer *)gesto {
    if (self.comidaCargada){
        CGPoint translation = [gesto locationOfTouch:0 inView:self.view];
    
        [UIView animateWithDuration:1.0f animations:^(void){
        
            self.imgComida.center = CGPointMake(translation.x, translation.y);
        
                                }
                         completion:^(BOOL finished){
               
                             UIView* xview = [self.view hitTest:translation withEvent:nil];
                             UIView* xx = self.imgBoca;
                             if ([xview isEqual:xx]){
                                 [self comidaEnBoca];
                             }
                         
        }];
    }
}

- (void)comidaEnBoca{
    
    self.imgComida.alpha = 0;
    [self.imgMascota setAnimationImages:[self cargarArrayAnimacion :self.mascota.imagenesComiendo]];
    self.imgMascota.animationRepeatCount = 2;
    self.imgMascota.animationDuration = 2;
    NSNumber* energia = [[NSNumber alloc]initWithFloat:100.0f];
    [[InstanciaMascota sharedInstance] subaEnergia:energia];
    
    [self refrescarEnergia:energia];
    
    [self.imgMascota startAnimating];
    
}

#pragma mark - Ejercicio

- (IBAction)clickEjercicio:(UIButton *)sender {
    if (self.ejercitando){
        [[InstanciaMascota sharedInstance] pararEjercicio];
        [self.btnEjercicio setTitle:@"Ejercitar" forState:UIControlStateNormal];
        self.ejercitando = NO;
    } else {
        [self.imgMascota setAnimationImages:[self cargarArrayAnimacion :self.mascota.imagenesEjercicio]];
        [self.imgMascota startAnimating];
        [InstanciaMascota.sharedInstance iniciarEjercicio];
        [self.btnEjercicio setTitle:@"Parar" forState:UIControlStateNormal];
        self.ejercitando = YES;
    }
    
    
}

- (void) refrescarEnergia: (NSNumber*) energia {
    
    [self.pgbEnergia setProgress:[[[InstanciaMascota sharedInstance] getEnergia] floatValue] / 100 animated:YES];

}

- (void) pararEjercicio {
    [self.imgMascota stopAnimating];
}

@end
