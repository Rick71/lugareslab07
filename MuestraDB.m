//
//  MuestraDB.m
//  lugareslab07
//
//  Created by Ricardo Vera on 18/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import "MuestraDB.h"
#import "cellOaxaca.h"

NSMutableArray *Nombre;
NSMutableArray *Image;
NSMutableArray *Descripcion;
NSMutableArray *objetos;


@interface MuestraDB ()

@end

@implementation MuestraDB

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reload];
}

-(void)reload{
    NSLog(@"Load");
    
    // Do any additional setup after loading the view.
    // Inicializa la Base de Datos.
    Nombre = [[NSMutableArray alloc] init];
    Image = [[NSMutableArray alloc] init];
    Descripcion = [[NSMutableArray alloc] init];
    //nos trae la Información de Parse.
    PFQuery *query = [PFQuery queryWithClassName:@"Lugar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         objetos = [NSMutableArray arrayWithArray:objects];;
         [self.TblMain reloadData];
         //for (id object in objects){
         //[Nombre addObject:object[@"name"]];
         //[Image addObject:object[@"foto"]];
         //[Descripcion addObject:object[@"descripcion"]];
         //NSLog(@"%@", object[@"name"]);
         //NSLog(@"%@", object[@"descripcion"]);
         //NSLog(@"%@", object[@"Latitud"]);
         //NSLog(@"%@", object[@"Longitud"]);
         
         //}
         
     }];
    NSLog(@"%lu", (unsigned long)[objetos count]);
    NSLog(@"Exit load");
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //[self.TblMain reloadData];
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




/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)[objetos count]);
    return [objetos count];
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellOaxaca");
    static NSString *CellIdentifier = @"CellOaxaca";
    
    cellOaxaca *cell = (cellOaxaca *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellOaxaca alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.LblNombre.text       = objetos[indexPath.row][@"name"];
    cell.LblDescripcion.text  = objetos[indexPath.row][@"descripcion"];
    //cell.ImageLugar.image      = [UIImage imageNamed:Image[indexPath.row]];
    
    return cell;
}



- (IBAction)BtnInicio:(id)sender {
}

- (IBAction)BtnMapa:(id)sender {
    [self performSegueWithIdentifier:@"SageMuestraDBToMapas" sender:self];
}

- (IBAction)BtnRefresh:(id)sender {
    [self reload];
}
    
@end


