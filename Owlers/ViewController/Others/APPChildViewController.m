//
//  APPChildViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPChildViewController.h"

@interface APPChildViewController ()

@end

@implementation APPChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *images =[[NSArray alloc]initWithObjects:@"1.png",@"2.png",@"3.png",@"4.png", nil];
    NSArray *label=[[NSArray alloc]initWithObjects:@"",@"Bid for amaging offers, use them on-the-go",@"Get access to the best party locations right from your phone",@"Find the most exciting events in your city", nil];
    //[UIFont fontWithName:@"GothamHTF-Book" size:12];
    
    //self->screenNumber.font = [UIFont fontWithName:@"GothamBook-1" size:25];
    //self->screenNumber.font = UIFont(name: "QuicksandDash-Regular", size: 35)
    
    self->screenNumber.text = [NSString stringWithFormat:@"%@", [label objectAtIndex:(self.index)]];
    slider_image.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    
    UIImage *tempImg2 = [UIImage imageNamed:[images objectAtIndex:(self.index)]];
    self->slider_image.frame = CGRectMake(75, 242, slider_image.frame.size.width, slider_image.frame.size.height);
    self->slider_image.image = tempImg2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
