//
//  VSFHomeProcess.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFHomeProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@implementation VSFHomeProcess

- (id)init
{
    self = [super init];
    if (self) {
        getGameReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveGetGameServerData:status:)];
    }
    return self;
}

- (void)getGame
{
    NSString *guid = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/games", VSF_SERVER_ADDRESS, guid];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSData* jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    NSLog(@"%@",resultsDictionary);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    NSError *error = [request error];
}

@end
