//
//  EarthquakeViewController.m
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//  Copyright (c) 2014 Ning Gu. All rights reserved.
//

#import "EarthquakeViewController.h"
#import "Earthquake.h"
#import "AnzRestfulManager.h"
#import "Util.h"
#import <MapKit/MapKit.h>
#import "CircleButton.h"

#define FRONT_COLOR UIColorFromRGB(0xF36261, 1.0)
#define BACK_COLOR UIColorFromRGB(0x909090, 1.0)

@interface EarthquakeViewController ()

@property (nonatomic, strong) NSArray *earthquakeData;
//we could use array of int to save the row number, but saving index path would give more flexbility for sections.
@property (nonatomic, strong) NSMutableArray *depthIndexPaths;

@end

@implementation EarthquakeViewController

#pragma mark - Property init

- (NSMutableArray *)depthIndexPaths
{
    if (!_depthIndexPaths) {
        _depthIndexPaths = [[NSMutableArray alloc] init];
    }
    
    return _depthIndexPaths;
}

- (void)setearthquakeData:(NSArray *)newData
{
    [newData retain];
    [_earthquakeData release];
    
    _earthquakeData = newData;
}

#pragma mark - ViewController life cycle method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Earthquake Data";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //add auto refreshing control
    self.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
    self.refreshControl.backgroundColor = UIColorFromRGB(0xF0F0F0, 1.0);
    self.refreshControl.tintColor = UIColorFromRGB(0x007CBC, 1.0);
    [self.refreshControl addTarget:self
                            action:@selector(getEarthquakeData)
                  forControlEvents:UIControlEventValueChanged];
    
    
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    [self getEarthquakeData];
}


-(void)dealloc
{
    [_earthquakeData release];
    [_depthIndexPaths release];
    
    [super dealloc];
}

#pragma mark - Networking
/*!
 Make RESTful request for earthquake data
  */
- (void)getEarthquakeData
{
    
    [[AnzRestfulManager sharedInstance] makeRestfulRequest:RestfulApiEarthquackData
                                              onCompletion:^(NSDictionary *response, NSError *error)
     {
         [self.refreshControl endRefreshing];
         
         if (!error) {
             self.earthquakeData = response[@"earthquakes"];
             
             [self.tableView reloadData];
         }
         
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.earthquakeData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //for unknown reason, if not set margins here, the inset will show up again
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    
    cell.layoutMargins = UIEdgeInsetsZero;
    
    NSDictionary *earthquakeData = self.earthquakeData[indexPath.row];
    [earthquakeData retain];

    UILabel *regionLabel = (UILabel *)[cell viewWithTag:10];
    regionLabel.text = earthquakeData[@"region"];
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:11];
    dateLabel.text = earthquakeData[@"timedate"];
    
    UILabel *magnitude = (UILabel *)[cell viewWithTag:12];
    magnitude.text = [self.depthIndexPaths containsObject:indexPath] ? @"depth" : @"mag.";
    
    CircleButton *button = (CircleButton *)[cell viewWithTag:13];
    [button drawCircleButton:FRONT_COLOR];
    
    //need to update button's title based on whether it's showing magnitude or depth.
    [button setTitle: [self.depthIndexPaths containsObject:indexPath] ? earthquakeData[@"depth"] : earthquakeData[@"magnitude"] forState:UIControlStateNormal];
    
    [earthquakeData release];
    
    [button addTarget:self action:@selector(onCircleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        NSDictionary *earthquakeData = self.earthquakeData[indexPath.row];
        [earthquakeData retain];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(((NSString *)earthquakeData[@"lat"]).doubleValue, ((NSString *)earthquakeData[@"log"]).doubleValue);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [placemark release];
        
        [mapItem setName:earthquakeData[@"region"]];
        
        [earthquakeData release];
        [mapItem openInMapsWithLaunchOptions:nil];
        [mapItem release];
    }
    
}

#pragma mark - UITableView Cell Button Event
/*!
 Event selector for round button when clicked. It obtains index path of this button by using bounds convert.
 
 @param id the origin of the event.
 */
- (void)onCircleButtonClick:(id)sender
{
    CircleButton *button = (CircleButton *)sender;
    CGRect buttonFrame = [button convertRect:button.bounds toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonFrame.origin];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UILabel *magnitude = (UILabel *)[cell viewWithTag:12];
    
    NSDictionary *earthquakeData = self.earthquakeData[indexPath.row];
    [earthquakeData retain];
    
    if ([self.depthIndexPaths containsObject:indexPath]) {
        [button setTitle:earthquakeData[@"magnitude"] forState:UIControlStateNormal];
        magnitude.text = @"mag.";
        [self.depthIndexPaths removeObject:indexPath];
    }else {
        [button setTitle:earthquakeData[@"depth"] forState:UIControlStateNormal];
        magnitude.text = @"depth";
        [self.depthIndexPaths addObject:indexPath];
    }
    
    [earthquakeData release];
    
    [UIView transitionWithView:button
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:nil
                    completion:nil];
}




@end
