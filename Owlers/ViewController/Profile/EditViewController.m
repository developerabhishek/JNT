//
//  EditViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 30/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "EditViewController.h"
#import "ProfileViewController.h"
@interface EditViewController ()

@property(nonatomic,strong) NSDictionary *dataDict;
@property(nonatomic,strong) IBOutlet    UITextField *userName;
@property(nonatomic,strong) IBOutlet    UITextField *email;
@property(nonatomic,strong) IBOutlet    UITextField *phone;

@end

@implementation EditViewController

- (id)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        _dataDict = [[NSDictionary alloc] initWithDictionary:dict];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showDataOnView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDataOnView{
    _userName.text=[_dataDict  objectForKey:@"name"];
    _email.text=[_dataDict objectForKey:@"email"];
    _phone.text=[_dataDict objectForKey:@"phone"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)updateProfile:(id)sender{

}
@end
