//
//  ArchiveRestfulManager.h
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//
//

typedef NS_ENUM(NSInteger, RestulApiId) {
    //Earthquake data
    RestfulApiEarthquackData,
    //Weahter data
    RestfulApiWeatherData,
    //add your new request id here
};

typedef void(^RequestCompletionHander) (NSDictionary *, NSError *);

@interface AnzRestfulManager : NSObject

/*!
    Create AnzRestfulManager instance
 
    @return The singleton instance of AnzRestfulManager.
 */
+ (instancetype)sharedInstance;

/*!
    Loads the data for a URL request and executes a handler block on an operation queue when the request completes or fails.

    @param requestId Request API ID.
 
    @param complete The handler block to execute.

    @return The singleton instance of AnzRestfulManager.
 */
- (void)makeRestfulRequest:(RestulApiId)requestId onCompletion:(RequestCompletionHander)complete;

@end
