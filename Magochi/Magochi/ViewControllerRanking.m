//
//  ViewControllerRanking.m
//  Magochi
//
//  Created by Mario Silveira on 11/29/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerRanking.h"
#import "InstanciaMascota.h"
#import "CellRanking.h"
@interface ViewControllerRanking ()

@property (nonatomic, weak)NSMutableArray* rankingMascotas;
@end

@implementation ViewControllerRanking

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rankingCargado)
                                                 name:@"RANKING_CARGADO"
                                               object:nil];
    
    [[InstanciaMascota sharedInstance] recibirTodasMascotas] ;

}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rankingCargado{
    
    self.rankingMascotas = [[InstanciaMascota sharedInstance] getMascotas];
    
    [self.tblRanking registerNib:[UINib nibWithNibName:@"CellRanking" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"CellRanking"];
    
    [self.tblRanking reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rankingMascotas.count;
}

-(double) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identificador = @"CellRanking";
    CellRanking* cRanking = [tableView dequeueReusableCellWithIdentifier: identificador];
    
    if (!cRanking){
        cRanking = [[CellRanking alloc]init];
    }
    
    Mascota *mascota =  self.rankingMascotas[indexPath.row];
    [cRanking setData: mascota];
    
    if ([mascota.codigo isEqual:[[InstanciaMascota sharedInstance] getMascota].codigo]){
        [cRanking setBackgroundColor:[UIColor greenColor]];
    } else {
        [cRanking setBackgroundColor:[UIColor whiteColor]];
    }
    
    return cRanking;
}


@end
