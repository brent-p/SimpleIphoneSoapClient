//
//  BCMSearchViewController.m
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BCMSearchViewController.h"
#import "BCMMasterViewController.h"

@implementation BCMSearchViewController
@synthesize postCodeTextField;
@synthesize suburbTextField;
@synthesize stateTextField;
@synthesize childController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.navigationItem.title = @"Post Code Verify";
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPostCodeTextField:nil];
    [self setSuburbTextField:nil];
    [self setStateTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)searchButtonClick:(id)sender {
    BCMAddress *searchAddress = [[BCMAddress alloc] init];
    searchAddress.postCode = [NSMutableString stringWithString:postCodeTextField.text];
    searchAddress.suburb = [NSMutableString stringWithString:suburbTextField.text];
    searchAddress.state = [NSMutableString stringWithString:stateTextField.text];
    childController = [BCMMasterViewController alloc];
    childController.searchAddress = searchAddress;
    childController = [childController initWithNibName:@"BCMMasterViewController" bundle:nil];
    [self.navigationController pushViewController:self.childController animated:YES];
}

- (IBAction)closeKeyboard:(id)sender 
{
    [sender resignFirstResponder];
}

- (IBAction)suburbCloseKeyboard:(id)sender 
{
    [sender resignFirstResponder];
}

- (IBAction)stateCloseKeyboard:(id)sender 
{
    [sender resignFirstResponder];
}

@end
