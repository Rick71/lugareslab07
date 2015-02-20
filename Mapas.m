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

NSMutableArray *Nombre;
NSMutableArray *Image;
NSMutableArray *Descripcion;
NSMutableArray *Lat;
NSMutableArray *Lng;
NSMutableArray *objetos;

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
    [self Consulta];
    mapView.delegate = self;
    // Do any additional setup after loading the view.

    //------------------------------------------------------------------------------------------------------
    //agregar para banner paso 01.
    [self cfgiAdBanner];
    //----------------------------------------------------------------------------------------------------
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Mapas Screen";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Consulta{
    Nombre = [[NSMutableArray alloc] init];
    Image = [[NSMutableArray alloc] init];
    Descripcion = [[NSMutableArray alloc] init];
    Lat = [[NSMutableArray alloc] init];
    Lng = [[NSMutableArray alloc] init];
    //nos trae la Información de Parse.
    PFQuery *query = [PFQuery queryWithClassName:@"Lugar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         objetos = [NSMutableArray arrayWithArray:objects];
         for (int a=0;a<[objetos count];a++){
             GMSMarker *marker = [[GMSMarker alloc] init];
             marker.position = CLLocationCoordinate2DMake([objetos[a][@"Latitud"] floatValue], [objetos[a][@"Longitud"] floatValue]);
             marker.title = objetos[a][@"name"];
             marker.snippet = @"Click aqui para indicarte como llegar";
             marker.map = mapView;
         }
         
         
     }];
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
    markerInicio.icon = [UIImage imageNamed:@"1424439603_1_26.png"];
    markerInicio.map = mapView;
    
    [self.Mapa addSubview:mapView];
    [self localiza];
}

- (void)localiza{
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         float mapLat = self.locationManager.location.coordinate.latitude;
         float mapLng = self.locationManager.location.coordinate.longitude;
         mapView.camera = [GMSCameraPosition cameraWithLatitude:mapLat longitude:mapLng zoom:16];
     }];
}

//Escucha el evento de tap en el infowindow enviando a google maps
-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    NSLog(@"%@", marker.title);
    CLLocationCoordinate2D posicion =  marker.position;
    float markerLat = posicion.latitude;
    float markerLng = posicion.longitude;
    NSLog(@"%.8f",markerLat);
    NSString *direccion = [NSString stringWithFormat:@"comgooglemaps://?saddr=%.8f,%.8f&daddr=%.8f,%.8f&directionsmode=driving", markerLat, markerLng,mlatitude,mlongitude];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:direccion]];
    } else {
        NSLog(@"Can't use comgooglemaps://");
    }
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

/**********************************************************************************************
 Localization
 **********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
    //NSLog( @"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             NSString *addressName = [placemark name];
             NSString *city = [placemark locality];
             NSString *administrativeArea = [placemark administrativeArea];
             NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             //NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             //NSLog(@"gstrUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         //[mUserDefaults setObject: [[NSNumber numberWithFloat:mlatitude] stringValue] forKey: pmstrLatitude];
         mlongitude = self.locationManager.location.coordinate.longitude;
         //[mUserDefaults setObject: [[NSNumber numberWithFloat:mlatitude] stringValue] forKey: pmstrLatitude];
         //NSLog(@"mlatitude = %f", mlatitude);
         //NSLog(@"mlongitude = %f", mlongitude);
         markerInicio.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
     }];
}
    


@end
