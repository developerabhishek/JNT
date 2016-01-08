//
//  ChangePasswordViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SettingViewController.h"
#import "Header.h"
#import "SharedPreferences.h"
#import "NetworkManager.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController{
NSDictionary *parsedObject;

}
NSString *UserId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserId= [defaults objectForKey:@"userID"];
    
    self.title = @"Change Password";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [confirmPassword setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)]];
    
    UITapGestureRecognizer *keyBoardHideRecognizer = [[UITapGestureRecognizer alloc] init];
    [keyBoardHideRecognizer addTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:keyBoardHideRecognizer];
    
}
-(void)hideKeyBoard
{
    for (UIView *view in [self.view subviews])
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField *)view;
            [textField resignFirstResponder];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backbtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)savebtnAction:(id)sender {
    
    NSString *showMessage = [[NSString alloc] init];
    
    [saveButton setEnabled:NO];
    
    if (currnetPassword.text.length == 0)
    {
        showMessage = @"Please enter old password";
    }
    else if (newpassword.text.length == 0 && confirmPassword.text.length == 0)
    {
        showMessage = @"Please enter new Password!";
    }
    else if(newpassword.text.length == 0 )
    {
        showMessage = @"Please enter new Password!";
    }
    else if(confirmPassword.text.length == 0)
    {
        showMessage = @"Please enter confirm Password!";
    }
    else if(![newpassword.text isEqualToString:confirmPassword.text])
    {
        showMessage = @"Password does not match";
    }
    
    if (showMessage.length != 0)
    {
        [saveButton setEnabled:YES];
        [[SharedPreferences sharedInstance] showCommonAlertWithMessage:showMessage withObject:self];
    }
    else
    {
        [NetworkManager changeOldPassword:currnetPassword.text toNewPassword:confirmPassword.text withComplitionHandler:^(id result, NSError *err) {
            
            if ([result valueForKey:@"message"])
            {
                
                [[SharedPreferences sharedInstance] showCommonAlertWithMessage:[result valueForKey:@"message"] withObject:self];
            }
            
        }];

    }
}

#pragma mark UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{    
    [textField resignFirstResponder];
    return YES;
}

@end
