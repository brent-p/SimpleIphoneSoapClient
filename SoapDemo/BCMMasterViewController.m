//
//  BCMMasterViewController.m
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BCMMasterViewController.h"

#import "BCMDetailViewController.h"

#import "BCMAddress.h"

#import "BCMPostalXMLParserDelegate.h"

#import "BCMConnection.h"

@implementation BCMMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize addressArray;
@synthesize postalParserDelegate;
@synthesize searchAddress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAndRefreshView) name:@"finishedSoapProcessing" object:nil];
    NSURL *url = [NSURL URLWithString: @"http://webservices.ssw.com.au/ssw/Postcode/PostCodeService.asmx"];
    NSString *action = @"http://www.ssw.com.au/PostcodeWebservice/GetPostcodeAndSuburbForAustralia";
	
	NSString *path = [[NSBundle mainBundle] pathForResource: @"request" ofType: @"txt"];   
    NSString *message = [NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: NULL];
	
	//NSString *text = [p valueForKey: @"text"];
	
	NSString *body = [NSString stringWithFormat:message,searchAddress.suburb,searchAddress.state,searchAddress.postCode];
    postalParserDelegate = [[BCMPostalXMLParserDelegate alloc] init];
    BCMConnection *connection = [[BCMConnection alloc] initWithParserDelegate:postalParserDelegate];
    [connection createRequestWithURL:url soapAction:action body:body];
    self.navigationItem.title = @"Suburbs";
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)reloadDataAndRefreshView
{
    NSLog(@"reloadDataAndRefreshView");
    addressArray = postalParserDelegate.addressArray;
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([addressArray count] > 0)
    {
        return [addressArray count];
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *addressString = @"";
    if([addressArray count] == 0)
    {
        
        addressString = @"loading";
    }
    else
    {
        BCMAddress *tmpAddress = [addressArray objectAtIndex:indexPath.section];
        addressString = [tmpAddress.postCode stringByAppendingFormat:tmpAddress.suburb,tmpAddress.state];
    }
    // Configure the cell.
    NSLog(@"address string:%@",addressString);
    cell.textLabel.text = addressString;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[BCMDetailViewController alloc] initWithNibName:@"BCMDetailViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
