//
//  ArchiveRestfulManager.h
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//
//

#import "AnzRestfulManager.h"

NSString *const SERVER_URL = @"http://www.seismi.org/api/eqs/";

@interface AnzRestfulManager ()


@end

@implementation AnzRestfulManager


+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[super alloc] init];
    });
    
    return instance;
}

/*!
    Build full RESTful url based on request API ID
 
    @return The URL of RESTful API.
 */
- (NSURL *)buildRestfulUrl:(RestulApiId)id
{
    NSString *api;
    switch(id)
    {
        case RestfulApiEarthquackData:
        api = @"";
        break;
        
        case RestfulApiWeatherData:
        return nil;
        break;
        
        default:
        return nil;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_URL, api]];
}


- (void)makeRestfulRequest:(RestulApiId)requestId onCompletion:(RequestCompletionHander)complete
{
    NSURL *url = [self buildRestfulUrl:requestId];
    if (!url) {
        [NSError errorWithDomain:@"ANZ" code:-1 userInfo:nil];
        
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:(NSURLRequestReloadIgnoringCacheData) timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *error)
     {
         if (data.length > 0 && error == nil)
         {
             NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             complete(response, error);
         }
     }];
}

@end
