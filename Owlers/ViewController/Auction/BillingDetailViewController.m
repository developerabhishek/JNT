//
//  BillingDetailViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "BillingDetailViewController.h"
#import "SettingViewController.h"
@interface BillingDetailViewController ()

@end

@implementation BillingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addcardbtnAction:(id)sender {
    
    
}

- (IBAction)backbtnAction:(id)sender {
    
    SettingViewController *set=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
}
@end
