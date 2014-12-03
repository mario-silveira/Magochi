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
#import "ViewControllerRanking.h"
#import "CoreDataHelper.h"

@interface ViewControllerGameView ()

@property (strong, nonatomic) IBOutlet UIImageView *imgComida;
@property BOOL comidaCargada;
@property BOOL ejercitando;
@property (strong, nonatomic)Comida* comida;

@end

@implementation ViewControllerGameView

CLLocationManager* locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.comidaCargada = NO;
    self.ejercitando = NO;
    [self setMascota:[[InstanciaMascota sharedInstance] getMascota]];

    UIBarButtonItem* mailButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mail_image"]  style:UIBarButtonItemStyleDone target:self action:@selector(enviarMail)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects: mailButton, nil];
    
    self.imgMascota.image = [UIImage imageNamed:[self.mascota getImagenMascota]];
    [[[InstanciaMascota sharedInstance] getMascota] guardarMascota];
    [self startUpdates];
    [self cargarLocation];
    
}

#pragma mark - Envio Email

- (void) enviarMail {
    
    NSString *emailTitle = @"Que app copada";
    NSString *messageBody = [NSString stringWithFormat:@"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App %@ para comerme todo y está genial. Bajatela YA!!   Saludos!", self.mascota.nombre, NSBundle.mainBundle.infoDictionary  [@"CFBundleDisplayName"]];
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            [[[UIAlertView alloc]
             initWithTitle: @"Resultado"
             message: @"Mail Cancelado"
             delegate: self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil] show];
            
              break;
        case MFMailComposeResultSaved:
            [[[UIAlertView alloc]
             initWithTitle: @"Resultado"
             message: @"Mail Guardado"
             delegate: self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil] show];
            
            break;
        case MFMailComposeResultSent:
            [[[UIAlertView alloc]
             initWithTitle: @"Resultado"
             message: @"Mail Enviado"
             delegate: self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil] show];
            
            break;
        case MFMailComposeResultFailed:
            [[[UIAlertView alloc]
             initWithTitle: @"Resultado"
             message: @"Error al enviar mail"
             delegate: self
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil] show];
            
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(ViewControllerGameView*) initWithData {
    [[InstanciaMascota sharedInstance] cargarMascota];
    return [[ViewControllerGameView alloc] initWithNibName:@"ViewControllerGameView" bundle:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = self.mascota.nombre;
    [self.imgMascota.layer setBorderWidth:2.0];
    self.imgComida.alpha = 1;
    self.imgComida.center = CGPointMake(281.0f, 572.0f);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refrescarEnergia) name:@"REFRESCAR_ENERGIA"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mascotaExausta)
                                                 name:@"MASCOTA_EXHAUSTA"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recibirNotificacion:)
                                                 name:@"NOTIFICACION_NIVEL"
                                               object:nil];
    
    

    [self refrescarEnergia];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.title = @"";
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) setearComida: (Comida*) comida{
    self.imgComida.image = [UIImage imageNamed:comida.imagenComida];
    self.comida = comida;
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

- (NSArray*) cargarArrayAnimacion:(NSArray *) array{
    
    NSMutableArray* result = [[NSMutableArray alloc] init];
    
    for (NSString* item in array){
        [result addObject:[UIImage imageNamed:item]];
    }
    return [[NSArray alloc]initWithArray:result];
    
}


- (void)comidaEnBoca{
    self.imgComida.alpha = 0;
    [self.imgMascota setAnimationImages:[self cargarArrayAnimacion :[self.mascota getImagenesComiendo]]];
    self.imgMascota.animationRepeatCount = 2;
    self.imgMascota.animationDuration = 0.5;
    
    [[InstanciaMascota sharedInstance] subaEnergia:self.comida.valor];
    
    [self refrescarEnergia];
    [self.imgMascota setImage: [UIImage imageNamed:[[self.mascota getImagenesComiendo] firstObject]]];
    [self.imgMascota startAnimating];
    [self.btnEjercicio setEnabled:YES];
    
}

#pragma mark - Ejercicio

- (IBAction)clickEjercicio:(UIButton *)sender {
    if (self.ejercitando){
        [[InstanciaMascota sharedInstance] pararEjercicio];
        [self pararEjercicio];
        [self.btnEjercicio setTitle:@"Ejercitar" forState:UIControlStateNormal];
        self.ejercitando = NO;
    } else {
        [self.imgMascota setAnimationImages:[self cargarArrayAnimacion :[self.mascota getImagenesEjercitando]]];
        [self.imgMascota setAnimationRepeatCount:0];
        [self.imgMascota setAnimationDuration: 0.5];
        [self.imgMascota startAnimating];
        [InstanciaMascota.sharedInstance iniciarEjercicio];
        [self.btnEjercicio setTitle:@"Parar" forState:UIControlStateNormal];
        self.ejercitando = YES;
    }
    
    
}

- (void) refrescarEnergia {
    
    [self.pgbEnergia setProgress:[[[InstanciaMascota sharedInstance] getEnergia] floatValue] / 100 animated:YES];

}

- (void) pararEjercicio {
    [self.imgMascota stopAnimating];
}

- (void) mascotaExausta {
    
    [self.imgMascota setAnimationImages:[self cargarArrayAnimacion:[self.mascota getImagenesCansado]]];
    [self.imgMascota setAnimationRepeatCount:1];
    [self.imgMascota setAnimationDuration:0.7];
    [self.imgMascota setImage: [UIImage imageNamed:[[self.mascota getImagenesCansado] lastObject]]];
    
    [self.btnEjercicio setEnabled:NO];
    [self.btnEjercicio setTitle:@"Ejercitar" forState:UIControlStateNormal];
    self.ejercitando = false;
    [self.imgMascota startAnimating];
}

- (void) recibirNotificacion: (NSNotification*) data{
   
    NSDictionary* dataMascota = data.userInfo;
    
    if (!([[dataMascota objectForKey:@"code"] isEqualToString:_mascota.codigo])){
    
    NSString* mensaje = [NSString stringWithFormat:@"Nombre: %@, Nivel: %@", [dataMascota objectForKey:@"name"], [dataMascota objectForKey:@"level"]];
        
    [[[UIAlertView alloc]
      initWithTitle: @"Nueva Notificacion"
      message: mensaje
      delegate: self
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil] show];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
- (IBAction)clickRanking:(id)sender {
    
    
    NSArray* datos = [[CoreDataHelper sharedInstance] getMascotasRanking];
    ViewControllerRanking* newView = [[ViewControllerRanking alloc] initWithData:datos];
    
    [self.navigationController pushViewController:newView animated:YES];
    
}

#pragma mark - Location

-(void) cargarLocation {
    CLLocation* location = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
    
    [[InstanciaMascota sharedInstance] setearUbicacion:location];
 //   NSLog(@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
}
-(void)startUpdates{
    if (locationManager == nil){
        locationManager = [[CLLocationManager alloc] init];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 10;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* location = (CLLocation*)locations[0];
    
    [[InstanciaMascota sharedInstance] setearUbicacion:location];
    
    NSLog(@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    
}

#pragma mark - Core Data




@end
