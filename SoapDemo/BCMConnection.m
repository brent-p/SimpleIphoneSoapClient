//
//  BCMConnection.m
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BCMConnection.h"

@implementation BCMConnection
@synthesize connection;
@synthesize dataRecieved;
@synthesize parserDelegate;

-(id)initWithParserDelegate:(id<NSXMLParserDelegate>)delegate
{
    parserDelegate = delegate;
    return self;
}

-(void)createRequestWithURL: (NSURL *)url soapAction:(NSString *)action body:(NSString *)body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [body length]];
    [request addValue:action forHTTPHeaderField: @"SOAPAction"];
	[request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField: @"Content-Type"];	
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
	[request setHTTPMethod: @"POST"];
	[request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
	[request setCachePolicy: NSURLRequestReloadIgnoringCacheData];
	
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Recieved Response from web service");
    dataRecieved = [[NSMutableData alloc] initWithLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    NSString *dataString = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"data recieved:%@",dataString);
    [dataRecieved appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection Error");
    NSLog(@"error was:%@",error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"All Data Received");
    //NSData *tempdata = [dataRecieved mutableBytes];
   // NSString *dataString = [NSString stringWithUTF8String:[dataRecieved bytes]];
   // NSLog(@"All data recieved String:%@",dataString);
    
    NSString *xmlToBeParsed = [[NSString alloc] initWithBytes:[dataRecieved mutableBytes] length:[dataRecieved length] encoding:NSUTF8StringEncoding];
    NSLog(xmlToBeParsed);
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:dataRecieved];
    [xmlParser setDelegate:parserDelegate];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"finishedSoapProcessing" object: nil];
    
}

@end
