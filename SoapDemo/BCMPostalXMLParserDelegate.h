//
//  BCMPostalXMLParserDelegate.h
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCMAddress.h"

@interface BCMPostalXMLParserDelegate : NSObject<NSXMLParserDelegate>
@property (nonatomic,retain) BCMAddress *address;
@property (nonatomic,retain) NSMutableArray *addressArray;
@property (nonatomic) BOOL postCode;
@property (nonatomic) BOOL suburb;
@property (nonatomic) BOOL state;
@property (nonatomic) BOOL newaddress;
@end
