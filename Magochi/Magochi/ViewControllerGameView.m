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

@property (strong, nonatomic) IBOutlet UIImageView *imgComida;
@property BOOL comidaCargada;

@end

@implementation ViewControllerGameView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.comidaCargada = NO;
    
    
    UIBarButtonItem* mailButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mail_image"]  style:UIBarButtonItemStyleDone target:self action:@selector(enviarMail)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects: mailButton, nil];
    
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = self.mascota.nombre;
    self.imgMascota.image = [UIImage imageNamed:self.mascota.imagen];
    
    self.imgComida.alpha = 1;
    self.imgComida.center = CGPointMake(281.0f, 572.0f);

}

-(void)viewWillDisappear:(BOOL)animated {
    self.title = @"";
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

- (NSArray*) cargarArrayAnimacion:(NSArray *) array{
    
    NSMutableArray* result = [[NSMutableArray alloc] init];
    
    for (NSString* item in array){
        [result addObject:[UIImage imageNamed:item]];
    }
    return [[NSArray alloc]initWithArray:result];
    
}


- (void)comidaEnBoca{
    self.imgComida.alpha = 0;
    [self.imgMascota setAnimationImages:[self cargarArrayAnimacion :self.mascota.imagenesComiendo]];
    self.imgMascota.animationRepeatCount = 2;
    self.imgMascota.animationDuration = 2;
    
    self.pgbEnergia.progress = 100.0f;
    
    [self.imgMascota startAnimating];
    
}

@end
