//
//  Mapas.m
//  lugareslab07
//
//  Created by Ricardo Vera on 19/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import "Mapas.h"

NSString    *strUserLocation;
float       mlatitude;
float       mlongitude;

GMSMapView *mapView;
GMSMarker *markerInicio;

@interface Mapas ()

@end

@implementation Mapas

- (void)viewDidLoad {
    [super viewDidLoad];   
    
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager  requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    [self MapaInicio];
    // Do any additional setup after loading the view.

    //------------------------------------------------------------------------------------------------------
    //agregar para banner paso 01.
    [self cfgiAdBanner];
    //----------------------------------------------------------------------------------------------------
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)MapaInicio{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude longitude:mlongitude zoom:16];
    [self.Mapa layoutIfNeeded];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame = CGRectMake(0, 0, self.Mapa.frame.size.width, self.Mapa.frame.size.height);
    mapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    markerInicio = [[GMSMarker alloc] init];
    markerInicio.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    markerInicio.title = @"Usuario";
    markerInicio.snippet = @"Usted esta aqui";
    markerInicio.map = mapView;
    
    [self.Mapa addSubview:mapView];
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


- (IBAction)BtnInicio:(id)sender {
    [self performSegueWithIdentifier:@"SegueMapasToIndex" sender:self];
}

- (IBAction)BtnLista:(id)sender {
    [self performSegueWithIdentifier:@"SegueMapasToMuestraDB" sender:self];
}

- (IBAction)BtnGoogleMaps:(id)sender {
    [self performSegueWithIdentifier:@"SegueMapasToGogleMaps" sender:self];
    
}
    


@end
