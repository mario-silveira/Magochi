//
//  ViewControllerContactos.m
//  Magochi
//
//  Created by Mario Silveira on 12/5/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerContactos.h"
#import <AddressBook/AddressBook.h>
#import "Contacto.h"
#import "InstanciaMascota.h"

@interface ViewControllerContactos ()

@property (nonatomic, strong) NSMutableArray* contactos;
@property (assign) ABAddressBookRef agenda;

@end

@implementation ViewControllerContactos


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.contactos = [[NSMutableArray alloc] init];
    [self cargarContactos];
}

-(void) cargarContactos {
    self.agenda = ABAddressBookCreateWithOptions(nil, nil);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined){
        ABAddressBookRequestAccessWithCompletion(self.agenda, ^(bool granted, CFErrorRef error) {
            NSLog(@"Acceso a los contactos pidiendo autorizacion");
            [self cargarDatos];
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        NSLog(@"Acceso a contactos con autorizacion");
        [self cargarDatos];
    } else {
        NSLog(@"Acceso denegado");
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Acceso a contactos no autorizado" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}


-(void) cargarDatos{
    CFArrayRef refContactos = ABAddressBookCopyArrayOfAllPeople(self.agenda);
    
    CFIndex cantContactos = ABAddressBookGetPersonCount(self.agenda);
    Contacto* contacto;
    for (int i = 0; i < cantContactos ; i++) {
        contacto = [[Contacto alloc] init];
        ABRecordRef c = CFArrayGetValueAtIndex(refContactos, i);
        
        NSString* nombre = (__bridge NSString*)ABRecordCopyValue(c, kABPersonFirstNameProperty);
        NSString* apellido = (__bridge NSString*)ABRecordCopyValue(c, kABPersonLastNameProperty);
        contacto.nombre = [NSString stringWithFormat:@"%@ %@", nombre, apellido];
        
        ABMultiValueRef arrayTel = ABRecordCopyValue(c, kABPersonPhoneProperty);
        contacto.telefono  = ((__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(arrayTel))[0];
        
        ABMultiValueRef arrayEmail = ABRecordCopyValue(c, kABPersonEmailProperty);
        contacto.email = ((__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(arrayEmail))[0];
        
        contacto.trabajo = (__bridge NSString*)ABRecordCopyValue(c, kABPersonOrganizationProperty);
        
        [self.contactos addObject:contacto];
    }
    
    [self cargarTabla];
}

-(void) cargarTabla {
    [self.tblContactos registerNib:[UINib nibWithNibName:@"CellContacto" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"CellContacto"];
    
    [self.tblContactos reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.contactos){
        return self.contactos.count;
    }
    return 0;
}

-(double) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identificador = @"CellContacto";
    CellContacto* cContacto = [tableView dequeueReusableCellWithIdentifier: identificador];
    
    if (!cContacto){
        cContacto = [[CellContacto alloc]init];
    }
    
    cContacto.delegate = self;
    [cContacto setData: [self.contactos objectAtIndex:indexPath.row]];
    
    return cContacto;

}

#pragma mark - Metodos del Protocolo

-(void)llamarContacto:(NSString *)telefono{


    NSString *tel = [NSString stringWithFormat:@"tel://%@",
                     [[telefono componentsSeparatedByCharactersInSet:
                                                              [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                             componentsJoinedByString:@""]];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:tel]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
        NSLog(@"Llamada realizada al telefono %@", tel);
    } else {
        [[[UIAlertView alloc]
          initWithTitle: @"Error"
          message: @"Este dispositivo no puede realizar llamadas"
          delegate: self
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil] show];
        return;
    }
    
    
}



-(void)enviarEmail:(NSString *)email {
    NSString *emailTitle = @"Que app copada";
    NSString *messageBody = [NSString stringWithFormat:@"Buenas! Soy Pepito, cómo va? Quería comentarte que estuve usando la App %@ para comerme todo y está genial. Bajatela YA!!   Saludos!", NSBundle.mainBundle.infoDictionary  [@"CFBundleDisplayName"]];
    NSArray *toRecipents = [NSArray arrayWithObject:email];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:NULL];

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString* mensaje;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            mensaje = @"Mail Cancelado";
            break;
        case MFMailComposeResultSaved:
            mensaje = @"Mail Guardado";
            break;
        case MFMailComposeResultSent:
            mensaje = @"Mail Enviado";
            break;
        case MFMailComposeResultFailed:
            mensaje = @"Fallo en el envio";
            break;
        default:
            break;
    }
    [self showAlert:mensaje];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) showAlert: (NSString*) mensaje {
    [[[UIAlertView alloc]
      initWithTitle: @"Resultado"
      message: mensaje
      delegate: self
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil] show];
}

@end
