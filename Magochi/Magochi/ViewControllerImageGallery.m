//
//  ViewControllerImageGallery.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerImageGallery.h"
#import "ViewControllerGameView.h"
#import "Utils.h"
#import "Mascota.h"
#import "InstanciaMascota.h"

@interface ViewControllerImageGallery ()
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIImageView *imgMascota;
@property (strong, nonatomic) IBOutlet UIScrollView *scrImages;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;

@property Mascota* mascota;

@end

@implementation ViewControllerImageGallery


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.btnDone setEnabled:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton*)boton {
    
    [self.btnDone setEnabled:YES];
    
    self.mascota = (Mascota*) Utils.getMascotas[boton.tag];
  
    self.imgMascota.image = [UIImage imageNamed:self.mascota.imagen];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.title = @"";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imgMascota.layer setBorderWidth:2.0];
    self.scrImages.contentSize = CGSizeMake(600,75);
    if (self.nombreMascota){
        self.title = self.mascota.nombre;
    }
}

- (id)initWithName: (NSString*) name {
    self = [super initWithNibName:@"ViewControllerImageGallery" bundle:nil];
    self.nombreMascota = name;
    return self;
}
- (IBAction)btnClickDone:(id)sender {
    self.mascota.nombre = self.nombreMascota;
    
    [[InstanciaMascota sharedInstance] setMascota:self.mascota];
    
    ViewControllerGameView* newView = [[ViewControllerGameView alloc]init];

    [self.navigationController pushViewController:newView animated:YES];
}




@end
