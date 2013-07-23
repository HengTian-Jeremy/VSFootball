//
//  VSFNetwork.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

// server address
#define ERNETWORK_SERVER_HTTPS @"https://"
#define ERNETWORK_SERVER_HTTP @"http://"

/*!
    @class ERNetwork
 
    @abstract network process interface
 
    @discussion network process interface
*/
@interface VSFNetwork : NSObject {
    // net waiting flag
    BOOL networkIndicator;
    
    // target object
    id targetObj;
    // selector
    SEL targetSelector;
    
    ASIHTTPRequest *asiReq;
    
    BOOL isInterract;
}

/*!
    @method initWithTarget:selector:
    @abstract class init
    @discussion init object with target and selector
    @param target 
    @param selector  
    @result  id class object
*/
- (id)initWithTarget:(id)target selector:(SEL)selector;

/*!
    @method startRequest:activeIndicator:httpsUrl:
    @abstract class init
    @discussion init object with target and selector
    @param strParam 
    @param activeIndicator
    @param isHttps
    @result  void
*/
- (void)startRequest:(ASIHTTPRequest *)requestObj activeIndicator:(BOOL)activeIndicator needInteract:(BOOL)needInteract parent:(id)parent;

@end
