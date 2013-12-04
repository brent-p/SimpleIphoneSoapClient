//
//  BCMAddress.h
//  SoapDemo
//
//  Created by Brent Parish on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCMAddress : NSObject
@property (nonatomic,retain)NSMutableString *postCode;
@property (nonatomic,retain)NSMutableString *suburb;
@property (nonatomic,retain)NSMutableString *state;
@end
