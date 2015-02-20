//
//  DataBase.m
//  lugareslab07
//
//  Created by Ricardo Vera on 17/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import "DataBase.h"

UIAlertView     *alert;

@interface DataBase ()

@end

@implementation DataBase

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Get all Values of class in parse core.
    
    //----------------------------------------------------------------------------------------------------
    //agregar para banner paso 01.
    [self cfgiAdBanner];
    //----------------------------------------------------------------------------------------------------
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"DataBase Screen";
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

- (IBAction)BtnGuardar:(id)sender {
    //Implementacion de Parse
    PFObject *testObject = [PFObject objectWithClassName:@"Lugar"];
    
    if ([self.TxtNombre.text isEqualToString:@""]|| [self.TxtDescripcion.text isEqualToString:@""] || [self.TxtLatitud.text isEqualToString:@""] || [self.TxtLongitud.text isEqualToString:@""])
            
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                               message:@"Tienes que llenar todos los campos"
                                              delegate:self
                                     cancelButtonTitle:@"Cancelar"
                                     otherButtonTitles:nil];
            [alert show];
        }
    
        else
    {
        
    testObject[@"name"] = self.TxtNombre.text;
    testObject[@"descripcion"] = self.TxtDescripcion.text;
    testObject[@"Latitud"] = self.TxtLatitud.text;
    testObject[@"Longitud"] = self.TxtLongitud.text;
       [testObject saveInBackground];
    
    
    self.TxtDescripcion.text = nil;
    self.TxtLatitud.text = nil;
    self.TxtLongitud.text = nil;
    self.TxtNombre.text = nil;
    }
    
    [self performSegueWithIdentifier:@"SegueDataBaseToIndex" sender:self];
    
}


- (IBAction)BtnInicio:(id)sender {
    [self performSegueWithIdentifier:@"SegueDataBaseToIndex" sender:self];
}


@end
