//
//  TermsUseViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "TermsUseViewController.h"
#import "SettingViewController.h"
@interface TermsUseViewController ()

@end

@implementation TermsUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backbtnAction:(id)sender {
    
    SettingViewController *startView=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
    
}
@end
