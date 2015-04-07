//
//  DataViewController.m
//  PageViewDemo
//
//  Created by abruzzim on 4/6/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%%DataViewController-I-TRACE, -viewDidLoad: called.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%%DataViewController-I-TRACE, -didReceiveMemoryWarning: called.");

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%%DataViewController-I-TRACE, -viewWillAppear: called.");
    //self.dataLabel.text = [self.dataObject description];
    [self.webView loadHTMLString:self.dataObject baseURL:[NSURL URLWithString:@""]];
}

@end
