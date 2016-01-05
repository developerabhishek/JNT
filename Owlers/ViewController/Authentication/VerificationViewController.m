//
//  VerificationViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 04/11/15.
//  Copyright © 2015 JNT. All rights reserved.
//

#import "VerificationViewController.h"
#import "Connectionmanager.h"
#import "Header.h"
#import "ProductViewController.h"
@interface VerificationViewController ()

// 509181039153-i4mnrf976n999ornrh2eafeeg1cf4oka.apps.googleusercontent.com

@end

@implementation VerificationViewController
NSDictionary *parsedObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"UserLoginIdSession"];
    self.userNameTxtFld.text = [object valueForKey:@"name"];
    self.emailTxtFld.text =  [object valueForKey:@"email"];
    
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

- (IBAction)continueBtnAction:(id)sender {
    
    if ([[ConnectionManager getSharedInstance] isConnectionAvailable])
    {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            
         
            
            NSString *urlString = [[NSString stringWithFormat:@"%@/social_login.php?name=%@&email=%@&image_path= &mobile=%@&source=iPhone&@&mac_addr=4545.7765.767",BaseUrl,self.userNameTxtFld.text,self.emailTxtFld.text,self.mobileTxtFld.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            
            
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             
             {
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     //Run UI Updates
                     if (data.length > 0)
                     {
                         
                         
                         parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                         
                         NSLog(@"parsedObject =%@",parsedObject);
                         
                         
                         if ([[parsedObject valueForKey:@"status"]  isEqual: @"success"])
                         {
                            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                             [user setObject:[parsedObject objectForKey:@"user_id"] forKey:@"userID"];
                             ProductViewController *product = [[ProductViewController alloc]init];
                             [self.navigationController pushViewController:product animated:YES];
                         }
                         else
                         {
                             UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:[parsedObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alertView show];
                         }
                     }
                     
                 });
             }];
        });
        
    }
}

- (IBAction)backBtnAction:(id)sender {

}
@end
