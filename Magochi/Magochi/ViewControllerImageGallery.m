//
//  ViewControllerImageGallery.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerImageGallery.h"

@interface ViewControllerImageGallery ()
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIImageView *imgMascota;
@property (strong, nonatomic) IBOutlet UIScrollView *scrImages;


@end

@implementation ViewControllerImageGallery

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnClick:(UIButton*)boton {
    switch (boton.tag) {
        case MascotaCiervo:
            self.imgMascota.image = [UIImage imageNamed:@"ciervo_comiendo_2"];
            break;
        case MascotaGato:
            self.imgMascota.image = [UIImage imageNamed:@"gato_comiendo_2"];
            break;
        case MascotaJirafa:
            self.imgMascota.image = [UIImage imageNamed:@"jirafa_comiendo_2"];
            break;
        case MascotaLeon:
            self.imgMascota.image = [UIImage imageNamed:@"leon_comiendo_2"];
            break;
        default:
            break;
    }
    //self.imgMascota.image = boton.currentBackgroundImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scrImages.contentSize = CGSizeMake(600,128);
    if (self.nombreMascota){
        self.lblNombre.text = self.nombreMascota;
    }
}

@end
