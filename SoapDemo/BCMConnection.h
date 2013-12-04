//
//  BCMConnection.h
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCMConnection : NSObject<NSURLConnectionDelegate>
@property (nonatomic,retain) NSURLConnection *connection;
@property (nonatomic,retain) NSMutableData *dataRecieved;
@property (nonatomic,retain) id<NSXMLParserDelegate> parserDelegate;
-(void)createRequestWithURL: (NSURL *)url soapAction:(NSString *)action body:(NSString *)body;
-(id)initWithParserDelegate:(id<NSXMLParserDelegate>)delegate;
@end
