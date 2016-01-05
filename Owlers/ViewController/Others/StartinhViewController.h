//
//  StartinhViewController.h
//  Owlers
//
//  Created by Biprajit Biswas on 24/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "SignupViewController.h"
@interface StartinhViewController : UIViewController<UIPageViewControllerDataSource>
{
    
    NSArray *arr_images ,*arr_labels;
   // IBOutlet UIScrollView *scrollView;
    BOOL check_images;
    IBOutlet UIImageView *myimageview;
    IBOutlet NSLayoutConstraint *leftViewHorizondalRightPadding;
    IBOutlet  NSLayoutConstraint *rightViewHorizondalRightPadding;

  //  IBOutlet UIPageControl *pageControl;
//    IBOutlet UIImage *image1, *image2, *image3, *image4;
//    BOOL gombsar_check;
}

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) UIPageViewController *pageController;

@property (strong, nonatomic) IBOutlet UILabel *labels;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIImageView *myimageview;

- (IBAction)loginBtnaction:(id)sender;
- (IBAction)signinbtnaction:(id)sender;
- (IBAction)skipbtnaction:(id)sender;
- (IBAction)pageControl:(UIPageControl *)sender;


- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender;

@end
