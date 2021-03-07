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
        _productNetworking = [STProductViewController new];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _productNetworking = [STProductViewController new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productNetworking.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
