//
//  ViewController.m
//  Arastta
//
//  Created by Ayhan Dorman on 27/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()
{

    
}

@end

@implementation SliderViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
    
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewDashboard"];
    
}


@end
