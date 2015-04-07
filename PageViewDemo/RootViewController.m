//
//  RootViewController.m
//  PageViewDemo
//
//  Created by abruzzim on 4/6/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "RootViewController.h"
#import "ModelController.h"
#import "DataViewController.h"

@interface RootViewController ()

@property (readonly, strong, nonatomic) ModelController *modelController;

@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%%RootViewController-I-TRACE, -viewDidLoad: called.");
    
    /* Configure the page view controller and add it as a child view controller. */
    
    // Instantiate a UIPageViewController.
    //
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    // Declare the delegate object.
    //
    self.pageViewController.delegate = self;

    // Declare the starting data view controller.
    //
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0
                                                                                  storyboard:self.storyboard];
    
    // Add the starting data view controller to an array.
    //
    NSArray *viewControllers = @[startingViewController];
    
    // Set the data view controller(s) to be displayed.
    // The data view controllers passed to this method are those that will be visible after the animation has completed.
    //
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];

    // Declare he object that provides view controllers to provide additional view controllers to which users will navigate.
    //
    self.pageViewController.dataSource = self.modelController;
    
    // Add the page view controller as a child of the root view controller.
    //
    [self addChildViewController:self.pageViewController];
    
    // Add the page view controller's view to the end of the root view controller's list of subviews.
    //
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    //
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 20.0, 20.0);
    }
    self.pageViewController.view.frame = pageViewRect;

    // Called after the view controller is added or removed from a container view controller.
    //
    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    //
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Return the model controller object, creating it if necessary.
// In more complex implementations, the model controller may be passed to the view controller.
//
- (ModelController *)modelController {
    
    NSLog(@"%%RootViewController-I-TRACE, -modelController: called.");
    
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

// Return the spine location.
//
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];
        
        self.pageViewController.doubleSided = NO;
        
        return UIPageViewControllerSpineLocationMin;
    }

    // In landscape orientation: Set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    
    DataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;

    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController
                                                      viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController
                                                         viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];

    return UIPageViewControllerSpineLocationMid;
}

@end
