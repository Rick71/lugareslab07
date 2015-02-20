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
    //------------------------------------------------------------------------------------------------------
    //agregar para banner paso 01.
    [self cfgiAdBanner];
    //------------------------------------------------------------------------------------------------------
    
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
         objetos = [NSMutableArray arrayWithArray:objects];
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

//------------------------------------------------------------------------------------------------------
//agregar para Banner paso 02.
- (void)cfgiAdBanner
{
    // Setup iAdView
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    //Set coordinates for adView
    CGRect adFrame      = adView.frame;
    adFrame.origin.y    = self.view.frame.size.height - 50;
    NSLog(@"adFrame.origin.y: %f",adFrame.origin.y);
    adView.frame        = adFrame;
    
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:adView];
    adView.delegate         = self;
    adView.hidden           = YES;
    self->bannerIsVisible   = NO;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self->bannerIsVisible)
    {
        adView.hidden = NO;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        [UIView commitAnimations];
        self->bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self->bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        [UIView commitAnimations];
        adView.hidden = YES;
        self->bannerIsVisible = NO;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction)
    {
        // stop all interactive processes in the app
        // [video pause];
        // [audio pause];
    }
    return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // resume everything you've stopped
    // [video resume];
    // [audio resume];
}
//---------------------------------------------------------------------------------------------------


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

/**********************************************************************************************
Table Functios
 *********************************************************************************************/



- (IBAction)BtnInicio:(id)sender {

    [self performSegueWithIdentifier:@"SegueMuestraDBToIndex" sender:self];
}

- (IBAction)BtnMapa:(id)sender {
    [self performSegueWithIdentifier:@"SagueMuestraDBToMapas" sender:self];
}

- (IBAction)BtnRefresh:(id)sender {
    [self reload];
}
    
@end


