//
//  BCMMasterViewController.h
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMAddress.h"
#import "BCMPostalXMLParserDelegate.h"

@class BCMDetailViewController;

@interface BCMMasterViewController : UITableViewController

@property (strong, nonatomic) BCMDetailViewController *detailViewController;
@property (nonatomic,retain) NSMutableArray *addressArray;
@property (nonatomic,retain)BCMPostalXMLParserDelegate *postalParserDelegate;
@property (nonatomic,retain)BCMAddress *searchAddress;

-(void)reloadDataAndRefreshView;
@end
