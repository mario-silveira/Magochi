//
//  ViewControllerGameView.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerGameView.h"
#import "Utils.h"
@interface ViewControllerGameView ()

@property NSString* nombreMascota;
@property NSString* imagenMascota;

@end

@implementation ViewControllerGameView




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = self.nombreMascota;
    self.imgMascota.image = [UIImage imageNamed:self.imagenMascota];
}

- (id)initWithData: (NSString*) nombre imagen: (NSString*) imagenMascota {
    self = [super initWithNibName:@"ViewControllerGameView" bundle:nil];
    self.nombreMascota = nombre;
    self.imagenMascota = imagenMascota;
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
