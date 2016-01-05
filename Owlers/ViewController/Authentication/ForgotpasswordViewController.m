//
//  ForgotpasswordViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 24/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "ForgotpasswordViewController.h"
#import "Header.h"
@interface ForgotpasswordViewController ()

@property(nonatomic,strong) IBOutlet UITextField *emailAddress;
@property(nonatomic, strong) IBOutlet UIButton *submit;
@property(nonatomic, strong) IBOutlet UIButton *backToLogin;


@end

@implementation ForgotpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard:(UITapGestureRecognizer *)sender
{
    [self.textfld resignFirstResponder];
}

- (BOOL)validateEmail:(NSString *)email1
{
    NSString *emailRegex = @ "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email1];
}

- (IBAction)submitBtnAction:(id)sender {
    
    if (self.textfld.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if (![self validateEmail:self.textfld.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        self.textfld.text = @"";
    }

    else
    {
        if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
        {
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                //Background Thread
                [self.submit setEnabled:NO];
                
                NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
                [jsonDict setValue:self.emailAddress.text forKey:@"Email"];
                
                
                // Code to send expense data on server
                NSMutableData *body = [NSMutableData data];
                NSError *writeError = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&writeError];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSURL *postUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/forgot.php?",BaseUrl]];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:postUrl];
                [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
                [request setTimeoutInterval:7.0];
                [request setHTTPMethod:@"POST"];
                
                NSString *contentType = [NSString stringWithFormat:@"application/json"];
                [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
                [body appendData:[[NSString stringWithFormat:@"%@",jsonString] dataUsingEncoding:NSUTF8StringEncoding]];
                [request setHTTPBody:body];
                [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^(void){
                         //Run UI Updates
                         [self.submit setEnabled:YES];
                         if (data.length > 0)
                         {
                             NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                             if ([[parsedObject valueForKey:@"success"] integerValue] == 1)
                             {
                                 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Your password sent to your email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                 [alertView show];
                                 
                                 [self dismissViewControllerAnimated:YES completion:NULL];
                             }
                             
//                             if ([[parsedObject valueForKey:@"success"] integerValue] == 0)
//                             {
//                                 UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"This email id is not exist. Please register first." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                 [alertView show];
//                             }
                         }
                         
                     });
                     
                 }];
            });
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)backBtnAction:(id)sender {
    
    LoginViewController *login=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    UINavigationController *navcontroller =self.navigationController;
    [navcontroller popViewControllerAnimated:YES];
    
}
@end
