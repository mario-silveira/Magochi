//
//  ViewControllerTablaComidas.m
//  Magochi
//
//  Created by Mario Silveira on 11/20/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerTablaComidas.h"
#import "Comida.h"
#import "CellComida.h"

@interface ViewControllerTablaComidas ()
@property (weak, nonatomic) IBOutlet UITableView *tblComidas;
@property NSMutableArray *arrayComidas;
@end

@implementation ViewControllerTablaComidas

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.arrayComidas = [[NSMutableArray alloc]init];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:0]: @"Torta" : @"comida_0"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:1]: @"Pastel": @"comida_1"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:2]: @"Helado": @"comida_2"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:3]: @"Pollo": @"comida_3"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:4]: @"Hamburguesa": @"comida_4"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:5]: @"Pescado": @"comida_5"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:6]: @"Manzana": @"comida_6"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:7]: @"Chorizo": @"comida_7"]];
    [self.arrayComidas addObject:[[Comida alloc] initWithData:[[NSNumber alloc] initWithInt:8]: @"Pan": @"comida_8"]];
    
    
    [self.tblComidas registerNib:[UINib nibWithNibName:@"CellComida" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"CellComida"];
    
    [self.tblComidas reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identificador = @"CellComida";
    CellComida* cComida = [tableView dequeueReusableCellWithIdentifier: identificador];
    
    if (!cComida){
        cComida = [[CellComida alloc]init];
    }
    
    Comida *comida = (Comida*) self.arrayComidas[indexPath.row];
    [cComida setData: comida];
    return cComida;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Comida *comida = (Comida*) self.arrayComidas[indexPath.row];
    [self.delegate setearComida:comida];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(double) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
