//
//  DataBase.m
//  lugareslab07
//
//  Created by Ricardo Vera on 17/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import "DataBase.h"


@interface DataBase ()

@end

@implementation DataBase

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Get all Values of class in parse core.
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



- (IBAction)BtnGuardar:(id)sender {
    //Implementacion de Parse
    PFObject *testObject = [PFObject objectWithClassName:@"Lugar"];
    testObject[@"name"] = self.TxtNombre.text;
    testObject[@"descripcion"] = self.TxtDescripcion.text;
    testObject[@"Latitud"] = self.TxtLatitud.text;
    testObject[@"Longitud"] = self.TxtLongitud.text;
       [testObject saveInBackground];
}


@end
