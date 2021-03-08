//
//  STProductViewController.h
//  simpletest
//
//  Created by Prince Wang on 2021/3/8.
//

#import <UIKit/UIKit.h>

@class STProductNetworking;

@interface STProductViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite) STProductNetworking *productNetworking;
//@property (nonatomic, copy, readonly) STProductNetworking *productNetworking;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic, readwrite) NSArray *products;
@property (strong, nonatomic, readwrite) NSArray *filteredProducts;

@property (nonatomic, readwrite) BOOL isSoldOut;
@property (nonatomic, readwrite) BOOL isComingSoon;

@end
