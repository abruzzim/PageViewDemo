//
//  ModelController.m
//  PageViewDemo
//
//  Created by abruzzim on 4/6/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of HTML pages.
 
 The controller serves as the data source for the page view controller; it therefore implements 
    pageViewController:viewControllerBeforeViewController: and 
    pageViewController:viewControllerAfterViewController:. It also implements a custom method, 
    viewControllerAtIndex: which is useful in the implementation of the data source methods, 
    and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance. Given the data model, 
    these methods create, configure, and return a new view controller on demand.
 */


@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *pageData;

@end

@implementation ModelController

// Initialize the data.
//

- (instancetype)init {
    self = [super init];
    
    NSLog(@"%%ModelController-I-TRACE, -init: called.");
    
    if (self) {
        
        // Create the data model.
        NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
        for (int i = 1; i < 11; i++) {
            NSString *contentString = [[NSString alloc] initWithFormat:@"<html><head></head><body><br><h1>Page %d</h1><p>This is page %d of content displayed using UIPageViewController.</p></body></html>", i, i];
            [pageStrings addObject:contentString];
        }
        _pageData = [[NSArray alloc] initWithArray:pageStrings];
    }
    
    return self;
}

// Return the data view controller for the given index.
//
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    
    NSLog(@"%%ModelController-I-TRACE, -viewControllerAtIndex:storyboard: called.");
    
    // Ensure the page data is in the pageData array.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }

    // Create a new (content) view controller.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    
    // Pass the data view controller its data.
    dataViewController.dataObject = self.pageData[index];
    
    // Return the data view controller for the given idenx.
    return dataViewController;
}

// Return the index of the given data view controller.
//
- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    
    NSLog(@"%%ModelController-I-TRACE, -indexOfViewController: called.");
    
    // This implementation uses a static array of model objects and the view controller stores the model object,
    // therefore the model object is used to identify the index.
    //
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

// Return the view controller BEFORE the given view controller,
// or nil to indicate that there is no previous view controller. (required)
//
// Parameters
//   pageViewController: The page view controller
//   viewController    : The view controller that the user navigated away from.
//
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSLog(@"%%ModelController-I-TRACE, -pageViewController:viewControllerBeforeViewController: called.");
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

// Return the view controller AFTER the given view controller,
// or nil to indicate that there is no previous view controller. (required)
//
// Parameters
//   pageViewController: The page view controller
//   viewController    : The view controller that the user navigated away from.
//
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSLog(@"%%ModelController-I-TRACE, -pageViewController:viewControllerAfterViewController: called.");
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.pageData count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
