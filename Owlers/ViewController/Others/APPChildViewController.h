//
//  APPChildViewController.h
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPChildViewController : UIViewController
{
    IBOutlet UIImageView *slider_image;
    IBOutlet UILabel *screenNumber;
}

@property (assign, nonatomic) NSInteger index;

@end
