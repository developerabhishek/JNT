//
//  SettingViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "SettingViewController.h"
#import "ProductViewController.h"
#import "ChangePasswordViewController.h"
#import "TermsUseViewController.h"
#import "NotificationsViewController.h"
#import "BillingDetailViewController.h"
#import "OwlersViewController.h"
@interface SettingViewController ()
@property(nonatomic,strong)UIDocument *documentName;
@end

@implementation SettingViewController
UIButton *button;
@synthesize documentName;
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationItem setRightBarButtonItem:nil];
    self.navigationItem.hidesBackButton = YES;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navbargoldbackarrow.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(-10, 5, 38, 38)];
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
//    [self presentViewController:controller animated:YES completion:nil];
//    
//    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
//                                    UIActivityTypePostToWeibo,
//                                    UIActivityTypeMessage, UIActivityTypeMail,
//                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
//                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
//                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
//    controller.excludedActivityTypes = excludedActivities;
//    
//    [self presentViewController:controller animated:YES completion:nil];
//
//}
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtnAction:(id)sender {
    ProductViewController *produ=[[ProductViewController alloc]initWithNibName:@"ProductViewController" bundle:nil];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];

}

- (IBAction)changePwdBtnAction:(id)sender {
    
    ChangePasswordViewController *change =[[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:change animated:YES];
    
}

- (IBAction)billingbtnAction:(id)sender {
    BillingDetailViewController *bill =[[BillingDetailViewController alloc]init];
    [self.navigationController pushViewController:bill animated:YES];
    
}

- (IBAction)sharebtnAction:(id)sender {
    NSLog(@"shareButton pressed");
    
     NSURL *url = [NSURL URLWithString:@"jfkdljfkjf"];
    NSArray *objectsToShare = @[url];
//    
   UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
//    
//    // Exclude all activities except AirDrop.
//    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
//                                    UIActivityTypePostToWeibo,
//                                    UIActivityTypeMessage, UIActivityTypeMail,
//                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
//                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
//                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
//    controller.excludedActivityTypes = excludedActivities;
//    
//    // Present the controller
    [self presentViewController:controller animated:YES completion:nil];
//
    
      }

//- (NSURL *) fileToURL:(NSString*)filename
//{
//    NSArray *fileComponents = [filename componentsSeparatedByString:@"."];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileComponents objectAtIndex:0] ofType:[fileComponents objectAtIndex:1]];
//    
//    return [NSURL fileURLWithPath:filePath];
//}

- (IBAction)rateusbtnAction:(id)sender {
    
   
    

}

- (IBAction)termsbtnAction:(id)sender {
    TermsUseViewController *terms =[[TermsUseViewController alloc]init];
    [self.navigationController pushViewController:terms animated:YES];

}

- (IBAction)notificationbtnAction:(id)sender {
    
    NotificationsViewController *notification =[[NotificationsViewController alloc]init];
    [self.navigationController pushViewController:notification animated:YES];
}
@end
