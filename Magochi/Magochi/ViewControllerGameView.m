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
@interface ViewControllerGameView ()

@property NSString* nombreMascota;
@property NSString* imagenMascota;
@property (strong, nonatomic) IBOutlet UIImageView *imgComida;

@end

@implementation ViewControllerGameView


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = self.nombreMascota;
    self.imgMascota.image = [UIImage imageNamed:self.imagenMascota];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.title = @"";
}

- (id)initWithData: (NSString*) nombre imagen: (NSString*) imagenMascota {
    self = [super initWithNibName:@"ViewControllerGameView" bundle:nil];
    self.nombreMascota = nombre;
    self.imagenMascota = imagenMascota;
    return self;
}

-(void) setComida: (Comida*) comida{
    self.imgComida.image = [UIImage imageNamed:comida.imagenComida];
}


- (IBAction)btnComer:(UIButton *)sender {
    
    ViewControllerTablaComidas* newView = [[ViewControllerTablaComidas alloc]init];
    newView.delegate = self;
    
    [self.navigationController pushViewController:newView animated:YES];
}


@end
