//
//  STProductNetworking.m
//  simpletest
//
//  Created by Prince Wang on 2021/3/6.
//

#import <Foundation/Foundation.h>
#import "STProductNetworking.h"
#import "STProductDataObject.h"

@interface STProductNetworking ()

@property (nonatomic, readwrite, strong) NSMutableArray *categoryIds;
@property (nonatomic, readwrite, strong) NSMutableArray *products;
@property (nonatomic, readwrite ,strong) dispatch_group_t group;

//@property (nonatomic, copy) NSMutableArray *categoryIds;
//@property (nonatomic, copy) NSMutableArray *products;

@end

@implementation STProductNetworking

- (instancetype)init {
    if (self != nil) {
        self.categoryIds = [NSMutableArray new];
        self.products = [NSMutableArray new];
        self.group = dispatch_group_create();
    }
    return self;
}

    // MARK: - get Product Info

- (void)getCategoryIds {
    dispatch_group_enter(self.group);
    
    NSURL *url = [NSURL URLWithString: @"https://blooming-oasis-01056.herokuapp.com/category"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"------ Error fetching categoryIds: %@ ------", error);
            return;
        }
        
        if (!data) {
            NSLog(@"------ No data returned from data task ------");
            return;
        }
        
        // MARK: Parse JSON/Data to Dictionary
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"------ Error deserializing JSON: %@ ------", error);
            return;
        }
        
        NSMutableArray *categoryIds = [NSMutableArray new];
        
        NSDictionary *dataDictionary = dictionary[@"data"];
        NSDictionary *shopCategoryListDictionary = dataDictionary[@"shopCategoryList"];
        NSArray *categoryListDictionaries = shopCategoryListDictionary[@"categoryList"];
        
        for (int i = 0; i < categoryListDictionaries.count; i++) {
            NSDictionary *categoryListDictionary = categoryListDictionaries[i];
            NSNumber *categoryId = categoryListDictionary[@"id"];
            
            [categoryIds addObject: categoryId];
        }
        self.categoryIds = categoryIds;
        
        dispatch_group_leave(self.group);
    }];
    
    [dataTask resume];
}

- (void)getProductInfoPartOne {
    dispatch_group_enter(self.group);
    
    for (NSString *categoryId in self.categoryIds) {
        
        NSString *urlString = [NSString stringWithFormat:@"https://blooming-oasis-01056.herokuapp.com/product?id=%@", categoryId];
        
        NSURL *url = [NSURL URLWithString: urlString];
        NSLog(@"------ URL: %@ ------", url);
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
        
        NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"------ Error fetching ProductInfoPartOne: %@ ------", error);
                return;
            }
            
            if (!data) {
                NSLog(@"------ No data returned from data task ------");
                return;
            }
            
            // MARK: Parse JSON/Data to Dictionary
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
                NSLog(@"------ Error deserializing JSON: %@ ------", error);
                return;
            }
            
            NSMutableArray *products = [NSMutableArray new];
            
            NSDictionary *dataDictionary = dictionary[@"data"];
            NSDictionary *shopCategoryDictionary = dataDictionary[@"shopCategory"];
            NSDictionary *salePageListDictionary = shopCategoryDictionary[@"salePageList"];
            NSArray *salePageListDictionaries = salePageListDictionary[@"salePageList"];
            
            for (NSDictionary *productData in salePageListDictionaries) {
                STProductDataObject *productDataObject = [[STProductDataObject alloc] initWithJSONObject:productData];
                
                [products addObject: productDataObject];
            }
            self.products = products;
            
            dispatch_group_leave(self.group);
        }];
        
        [dataTask resume];
    }
}

- (void)getProductInfoPartTwo {
    dispatch_group_enter(self.group);
    
    for (NSString *categoryId in self.categoryIds) {
        
        NSString *urlString = [NSString stringWithFormat:@"https://blooming-oasis-01056.herokuapp.com/sale?id=%@", categoryId];
        
        NSURL *url = [NSURL URLWithString: urlString];
        NSLog(@"------ URL: %@ ------", url);
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
        
        NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"------ Error fetching ProductInfoPartOne: %@ ------", error);
                return;
            }
            
            if (!data) {
                NSLog(@"------ No data returned from data task ------");
                return;
            }
            
            // MARK: Parse JSON/Data to Dictionary
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
                NSLog(@"------ Error deserializing JSON: %@ ------", error);
                return;
            }
            
            NSDictionary *dataDictionary = dictionary[@"data"];
            NSDictionary *shopCategoryDictionary = dataDictionary[@"shopCategory"];
            NSDictionary *salePageListDictionary = shopCategoryDictionary[@"salePageList"];
            NSArray *salePageListDictionaries = salePageListDictionary[@"salePageList"];
            
            for (NSDictionary *productData in salePageListDictionaries) {
                
                for (STProductDataObject *product in self.products) {
                    if (product.salePageId == [productData[@"salePageId"] integerValue]) {
                        product.sellingQty = [productData[@"sellingQty"] integerValue];
                        product.sellingStartDateTime = [productData[@"sellingStartDateTime"] integerValue];
                        product.isSoldOut = [productData[@"isSoldOut"] boolValue];
                        product.isComingSoon = [productData[@"isComingSoon"] boolValue];
                    }
                }
            }
            dispatch_group_leave(self.group);
        }];
        
        [dataTask resume];
    }
}

    // MARK: - for STProductViewController

- (void)getProducts: (void (^)(NSArray *))completion {
    [self getCategoryIds];
    dispatch_group_wait(self.group, DISPATCH_TIME_FOREVER);
    [self getProductInfoPartOne];
    dispatch_group_wait(self.group, DISPATCH_TIME_FOREVER);
    [self getProductInfoPartTwo];
    dispatch_group_notify(self.group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        completion(self.products);
    });
}

@end
