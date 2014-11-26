//
//  ViewControllerDataEntry.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerDataEntry.h"
#import "ViewControllerImageGallery.h"
#import "NSString+Validation.h"
#import "Utils.h"
#import "InstanciaMascota.h"

@interface ViewControllerDataEntry ()

@property NSString* nombreMascota;
@property (strong, nonatomic) IBOutlet UILabel *lblError;

@end


@implementation ViewControllerDataEntry

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [Utils cargarMascotas];
    
    [self.lblError setHidden:YES];
    self.txtName.text = @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnClick:(id)sender {
    BOOL result = [self validateText: self.txtName.text];
    
    if (result){
        self.nombreMascota = self.txtName.text;
        
        ViewControllerImageGallery* newView = [[ViewControllerImageGallery alloc]initWithName:self.nombreMascota];
        
        [self.navigationController pushViewController:newView animated:YES];
    } else {
        [self.lblError setHidden:NO];
    }
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
}

- (IBAction)clickCargar:(UIButton *)sender {
    [[InstanciaMascota sharedInstance] recibirMascota];
}


@end
