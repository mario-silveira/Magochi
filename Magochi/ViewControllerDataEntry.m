//
//  ViewControllerDataEntry.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerDataEntry.h"
#import "ViewControllerImageGallery.h"
#import "ViewControllerGameView.h"
#import "NSString+Validation.h"
#import "InstanciaMascota.h"
#import "ViewControllerGameView.h"
#import "Constantes.h"

@interface ViewControllerDataEntry ()

@property NSString* nombreMascota;
@property (strong, nonatomic) IBOutlet UILabel *lblError;

@end


@implementation ViewControllerDataEntry



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mascotaCargada)
                                                 name:@"MASCOTA_CARGADA"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:NOMBRE_MASCOTA_CARGADO];
    
    [self.lblError setHidden:YES];
    self.txtName.text = @"";
}

- (IBAction)btnClick:(id)sender {
    BOOL result = [self validateText: self.txtName.text];
    
    if (result){
        
        [self cargarPantallaImagenes];
    } else {
        [self.lblError setHidden:NO];
    }
}

-(void) cargarPantallaImagenes {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:NOMBRE_MASCOTA_CARGADO];
    [[[InstanciaMascota sharedInstance] getMascota] setNombre:self.txtName.text];
  //  self.nombreMascota = self.txtName.text;
    
    ViewControllerImageGallery* newView = [[ViewControllerImageGallery alloc]initWithNibName:@"ViewControllerImageGallery" bundle:nil];
    
    [self.navigationController pushViewController:newView animated:YES];

}
- (IBAction)txtEndEdt:(id)sender {
  [self.view endEditing:YES];
}

- (BOOL) validateText: (NSString*) name {
    if ([name isEmpty]){
        return NO;
    }
    if ([name length] < 6){
        return NO;
    }
    
   	return [name hasOnlyLetters];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.title = @"";
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (IBAction)clickCargar:(UIButton *)sender {
    [[InstanciaMascota sharedInstance] cargarMascota];
    [self mascotaCargada];
   // [[InstanciaMascota sharedInstance] recibirMascota];
}

-(void)mascotaCargada{
    ViewControllerGameView* newView = [[ViewControllerGameView alloc] initWithNibName:@"ViewControllerGameView" bundle:nil];
    
    [self.navigationController pushViewController:newView animated:YES];
}


@end
