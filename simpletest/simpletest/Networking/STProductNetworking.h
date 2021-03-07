//
//  STProductNetworking.h
//  simpletest
//
//  Created by Prince Wang on 2021/3/6.
//

#import <Foundation/Foundation.h>

//@class STProductDataObject;

@interface STProductNetworking : NSObject

@property (nonatomic, readonly, strong) NSArray *categoryIds;
@property (nonatomic, readonly, strong) NSArray *products;

- (instancetype)init;

    // MARK: get Product Info

- (void)getCategoryIds;

- (void)getProductInfoPartOne;

- (void)getProductInfoPartTwo;

    // MARK: for STProductViewController

- (void)getProducts: (void (^)(NSArray *))completion;

@end
