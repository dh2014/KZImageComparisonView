//
//  KZViewController.m
//  KZImageComparisonView
//
//  Created by Zhamtsuev Konstantin on 08/02/2017.
//  Copyright (c) 2017 Zhamtsuev Konstantin. All rights reserved.
//

#import "KZViewController.h"
#import <KZImageComparisonView/KZImageComparisonView.h>

@interface KZViewController ()

@end

@implementation KZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    KZImageComparisonView *imageComparisonView = [[KZImageComparisonView alloc] initWithLeftImage:[UIImage imageNamed:@"left"]
                                                                                       rightImage:[UIImage imageNamed:@"right"]
                                                                                  separatingImage:[UIImage imageNamed:@"finger"]];
    imageComparisonView.frame = CGRectMake(0, 0, 300, self.view.frame.size.width);
    imageComparisonView.contentMode = UIViewContentModeScaleAspectFit;
    imageComparisonView.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
    imageComparisonView.clipsToBounds = NO;
    
    [self.view addSubview:imageComparisonView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
