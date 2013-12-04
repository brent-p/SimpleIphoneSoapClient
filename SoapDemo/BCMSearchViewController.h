//
//  BCMSearchViewController.h
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMMasterViewController.h"

@interface BCMSearchViewController : UIViewController
@property (nonatomic,retain) BCMMasterViewController *childController;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *suburbTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
- (IBAction)searchButtonClick:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)suburbCloseKeyboard:(id)sender;
- (IBAction)stateCloseKeyboard:(id)sender;


@end
