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
    UserId= [defaults objectForKey:@"user_id"];
    
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
    
    SettingViewController *setting=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    

    
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
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:Nil message:showMessage delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
else
{
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        [activityIndicator startAnimating];
        [self performSelector:@selector(resetPassword) withObject:Nil afterDelay:0.0f];
    }
}
}
-(void)resetPassword
{
  [activityIndicator startAnimating];
    
    
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
        
            
            NSString *urlString = [NSString stringWithFormat:@"%@/change_pwd.php?userID=%@&oldPwd=%@&newPwd=%@",BaseUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"] ,currnetPassword.text,confirmPassword.text];
            NSURL *url = [[NSURL alloc]initWithString:urlString];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             
             {
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     if (data.length > 0)
                     {
                         parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                         NSLog(@"parsedObject =%@",parsedObject);
                         
                         if ([parsedObject valueForKey:@"message"])
                         {
                             
                             UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:[parsedObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alertView show];
                             
                   
                             
                         }else
                         {
                             
                             UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:[parsedObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alertView show];
                             
                         }
                         
                     }
                     
                     
                 });
             }];
        });
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
//    
//    
//    
//    
//    NSLog(@"User ID :%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"]);
////    
////    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
////    NSObject * object = [prefs objectForKey:@"UserLoginIdSession"];
////    
////    
//    
//   
//    [jsonDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"] forKey:@"userID"];
//    [jsonDict setValue:currnetPassword.text forKeyPath:@"oldPwd"];
//    [jsonDict setValue:confirmPassword.text forKeyPath:@"newPwd"];
//    
//    NSMutableData *body = [NSMutableData data];
//    NSError *writeError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&writeError];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSURL *postUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/change_pwd.php",BaseUrl]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:postUrl];
//    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
//    [request setTimeoutInterval:7.0];
//    [request setHTTPMethod:@"POST"];
//    
//    NSLog(@"data : %@",jsonData);
//    NSLog(@"string : %@",jsonString);
//    
//    NSString *contentType = [NSString stringWithFormat:@"application/json"];
//    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//    [body appendData:[[NSString stringWithFormat:@"%@",jsonString] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:body];
//    
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
//     {
//         dispatch_async(dispatch_get_main_queue(), ^(void)
//                        {
//                            if (data.length !=0)
//                            {
//                                NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                
//                                [saveButton setEnabled:YES];
//                                [activityIndicator stopAnimating];
//                                
//                                NSLog(@"message from server :%@",parsedObject);
//                                
//                                if([parsedObject valueForKey:@"message"]){
//                                    
//                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[parsedObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                    [alertView show];
//                                    
//                                    
//                                
//                                }else{
//                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"No data from server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                    [alertView show];
//                                }
//                                
//                                
//                                
//                                
//                                
//                                
////                                if ([[parsedObject valueForKey:@"success"] integerValue] == 1)
////                                {
////                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Your password is successfully updated." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
////                                    [alertView show];
////                                    
////                                    [self.navigationController popViewControllerAnimated:YES];
////                                }
////                                else if ([[parsedObject valueForKey:@"success"] integerValue] == 0)
////                                {
////                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter correct old password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
////                                    [alertView show];
////                                }
//                            }
//                            else
//                           {
//                                [saveButton setEnabled:YES];
//                                [activityIndicator stopAnimating];
//                                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Unable to communicate with server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                [alertView show];
//                            }
//                            
//                        });
//     }];
    
}

    

#pragma mark UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
