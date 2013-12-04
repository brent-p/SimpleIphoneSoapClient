//
//  BCMPostalXMLParserDelegate.m
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BCMPostalXMLParserDelegate.h"

@implementation BCMPostalXMLParserDelegate
@synthesize address;
@synthesize addressArray;
@synthesize newaddress;
@synthesize postCode;
@synthesize suburb;
@synthesize state;

-(id)init
{
    addressArray = [[NSMutableArray alloc] init];
    return self;
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    postCode = FALSE;
    state = FALSE;
    suburb = FALSE;
    if([elementName isEqualToString:@"Postcode"] && [attributeDict count] > 0)
    {
        //Start of a new PostCode set, so create new Address Obj
        address = [[BCMAddress alloc] init];
    }
    else if([elementName isEqualToString:@"Postcode"])
    {
        address.postCode = [[NSMutableString alloc] init];
        postCode = TRUE;
    }
    else if([elementName isEqualToString:@"Suburb"])
    {
        address.suburb = [[NSMutableString alloc] init];
        suburb = TRUE;
    }
    else if([elementName isEqualToString:@"Suburb"])
    {
        address.state = [[NSMutableString alloc] init];
        state = TRUE;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(postCode)
    {
        [address.postCode appendString:string];
    }
    else if(suburb)
    {
        [address.suburb appendString:string];
    }
    else if(state)
    {
        [address.state appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
    if([elementName isEqualToString:@"Postcode"] && !postCode)
    {
        [addressArray addObject:address];
    }
    NSLog(@"Address Array count:%i",[addressArray count]);
}
@end
