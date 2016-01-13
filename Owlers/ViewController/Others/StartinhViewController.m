//
//  StartinhViewController.m
//  Owlers
//
//  Created by Biprajit Biswas on 24/09/15.
//  Copyright (c) 2015 JNT. All rights reserved.
//

#import "StartinhViewController.h"
#import "ProductViewController.h"
#import "APPChildViewController.h"
#import "SharedPreferences.h"
#import "NetworkManager.h"
@interface StartinhViewController ()

@end

@implementation StartinhViewController

@synthesize myimageview ,pageControl ,labels;
UIImage *image;
UIImageView *imgV;
 UILabel *labels;
int currentIndex = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    /************[PAGECONTROLLER FOR SLIDER START]**************/
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    self.pageController.view.frame = CGRectMake(0,-120, self.view.frame.size.width, self.view.frame.size.height);
    APPChildViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    /************[PAGECONTROLLER FOR SLIDER END]**************/

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerCalled) userInfo:nil repeats:YES];
    
}


-(void)timerCalled
{
    if(currentIndex <= 3 || currentIndex >= 0){
        if(currentIndex==3){
            
            currentIndex = 0;
        }else{
            
            currentIndex++;
        }
        
        APPChildViewController *initialViewController = [self viewControllerAtIndex:currentIndex];
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self addChildViewController:self.pageController];
        [[self view] addSubview:[self.pageController view]];
        [self.pageController didMoveToParentViewController:self];
    }
    
}


/*******************[SLIDER IMAGES START]*********************/
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (APPChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    APPChildViewController *childViewController = [[APPChildViewController alloc] initWithNibName:@"APPChildViewController" bundle:nil];
    childViewController.index = index;
    return childViewController;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(APPChildViewController *)viewController index];
    if (index == 0) {
        return nil;
    }
    // Decrease the index by 1 to return
    index--;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(APPChildViewController *)viewController index];
    index++;
    if (index == 4) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}
 /******************[SLIDER IMAGES END]*********************/


- (void)setupScrollView:(UIScrollView*)scrMain {
    NSArray *images =[[NSArray alloc]initWithObjects:@"1.png",@"2.png",@"3.png",@"4.png", nil];
    NSArray *label=[[NSArray alloc]initWithObjects:@"",@"Bid for amaging offers, use them on-the-go",@"Get access to the best party locations right from your phone",@"Find the most exciting events in your city", nil];
    
    for (int i=0; i < images.count; i++) {
        
        labels=[[UILabel alloc]initWithFrame:CGRectMake((i)*scrMain.frame.size.width+23, 342, 275, 88)];
        labels.contentMode =UIViewContentModeScaleToFill;
        
        [scrMain addSubview:labels];
        labels.numberOfLines=0;
        labels.textColor =[UIColor whiteColor];
        labels.textAlignment = NSTextAlignmentCenter;
        labels.text=[label objectAtIndex:i];
        image = [UIImage imageNamed:[images objectAtIndex:i]];
        imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i)*scrMain.frame.size.width+60, 95,200 ,200 )];
        imgV.contentMode=UIViewContentModeScaleToFill;
        [imgV setImage:image];
        [scrMain addSubview:imgV];
    }
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*4, scrMain.frame.size.height)];
    [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}

- (void)scrollingTimer {
    UIScrollView *scrMain = (UIScrollView*) [self.view viewWithTag:1];
    UIPageControl *pgCtr = (UIPageControl*) [self.view viewWithTag:12];
    CGFloat contentOffset = scrMain.contentOffset.x;
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    if( nextPage!=4 )  {
        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=nextPage;
    } else {
        [scrMain scrollRectToVisible:CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=0;
    }
}
- (IBAction)loginBtnaction:(id)sender {
    if ([SharedPreferences isNetworkAvailable]){
        
        LoginViewController *login=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
    else{
        [[SharedPreferences sharedInstance] showCommonAlertWithMessage:@"The network connection is not available" withObject:self];
        
    }
}

- (IBAction)signinbtnaction:(id)sender {
    if ([SharedPreferences isNetworkAvailable]){
        
        SignupViewController *signup=[[SignupViewController alloc]init];
        [self.navigationController pushViewController:signup animated:YES];
    }
    else{
        [[SharedPreferences sharedInstance] showCommonAlertWithMessage:@"The network connection is not available" withObject:self];

    }
}

- (IBAction)skipbtnaction:(id)sender {
    if ([SharedPreferences isNetworkAvailable]){
        ProductViewController * view =[[ProductViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }
    else{
        [[SharedPreferences sharedInstance] showCommonAlertWithMessage:@"The network connection is not available" withObject:self];
    }
}
@end
