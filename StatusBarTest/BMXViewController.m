//
//  BMXViewController.m
//  StatusBarTest
//
//  Created by Massimiliano Bigatti on 19/06/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

#import "BMXViewController.h"
#import "CENatGeoAnimationController.h"

@implementation BMXViewController {
    CENatGeoAnimationController *_animationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _animationController = [[CENatGeoAnimationController alloc] init];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


#pragma mark - Mail

- (IBAction)sendMail:(UIBarButtonItem *)sender
{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    
    [controller setSubject: @"Test Mail"];
    
    [controller setMessageBody: @"Mail body"
                        isHTML: NO];
    
    [self presentViewController: controller
                       animated: YES
                     completion: nil];
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *controller = (UIViewController*)segue.destinationViewController;
    
    // this line cause the bug
    //controller.modalPresentationStyle = UIModalPresentationCustom;
    
    controller.transitioningDelegate = self;
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
}


#pragma mark - Transitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    _animationController.reverse = NO;
    return _animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _animationController.reverse = YES;
    return _animationController;
}

@end
