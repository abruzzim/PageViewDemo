//
//  DataViewController.h
//  PageViewDemo
//
//  Created by abruzzim on 4/6/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak,   nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) id dataObject;

@end

