//
//  Mapas.m
//  lugareslab07
//
//  Created by Ricardo Vera on 19/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import "Mapas.h"

@interface Mapas ()

@end

@implementation Mapas

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)BtnInicio:(id)sender {
    [self performSegueWithIdentifier:@"SegueeMuestraDBToIndex" sender:self];
}

- (IBAction)BtnLista:(id)sender {
    [self performSegueWithIdentifier:@"SegueMapasToMuestraDB" sender:self];}
@end
