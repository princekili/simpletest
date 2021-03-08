//
//  STProductViewController.m
//  simpletest
//
//  Created by Prince Wang on 2021/3/8.
//

//#import <UIKit/UIKit.h>
#import "STProductViewController.h"
#import "STProductTableViewCell.h"
#import "STProductNetworking.h"

@interface STProductViewController ()

@end

@implementation STProductViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.productNetworking = [STProductNetworking new];
        self.products = [NSArray new];
        self.filteredProducts = [NSArray new];
        self.isSoldOut = NO;
        self.isComingSoon = NO;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.productNetworking = [STProductNetworking new];
        self.products = [NSArray new];
        self.filteredProducts = [NSArray new];
        self.isSoldOut = NO;
        self.isComingSoon = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.activityIndicator.hidesWhenStopped = YES;
    [self fetchProducts];
}

    // MARK: -

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
    });
}

- (void)fetchProducts {
    [self.activityIndicator startAnimating];
    
    [self.productNetworking getProducts:^(NSArray *products) {
        self.products = products;
        [self reloadData];
    }];
}

    // MARK: - To do

- (void)handleFilters {
//    for (STProductDataObject *product in self.products) {
//        if (product.isSoldOut == self.isSoldOut && product.isComingSoon == self.isComingSoon) {
//
//        }
//    }
}

- (void)priceDescending {
    
}

- (void)priceAscending {
    
}

- (void)timeDescending {
    
}

- (void)timeAscending {
    
}

    // MARK: -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productNetworking.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STProductTableViewCell *cell = (STProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell" forIndexPath:indexPath];
    
    STProductDataObject *product = self.productNetworking.products[indexPath.row];
    [cell setup:product];
    
    return cell;
}

    // MARK: -

// To sort items
- (IBAction)segmentedControlDidTap:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0: [self priceDescending];
        case 1: [self priceAscending];
        case 2: [self timeDescending];
        case 3: [self timeAscending];
        default: break;
    };
    [self reloadData];
}

// To filter items
- (IBAction)isSoldOutSwitchDidTap:(UISwitch *)sender {
    self.isSoldOut = sender.isOn;
    [self handleFilters];
}

// To filter items
- (IBAction)isComingSoonSwitchDidTap:(UISwitch *)sender {
    self.isComingSoon = sender.isOn;
    [self handleFilters];
}

@end
