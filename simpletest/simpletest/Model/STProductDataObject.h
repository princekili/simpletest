//
//  STProductDataObject.h
//  simpletest
//
//  Created by Prince Wang on 2021/3/5.
//

//#ifndef CategoryListDataObject_h
//#define CategoryListDataObject_h
//#endif

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STProductDataObject : NSObject

@property (nonatomic, readwrite, strong) NSString *title;

@property (nonatomic, readwrite) NSInteger salePageId;
@property (nonatomic, readwrite) NSInteger price;
@property (nonatomic, readwrite) NSInteger suggestPrice;
@property (nonatomic, readwrite) NSInteger sellingQty;
@property (nonatomic, readwrite) NSInteger sellingStartDateTime;

@property (nonatomic, readwrite) BOOL isSoldOut;
@property (nonatomic, readwrite) BOOL isComingSoon;

- (instancetype)initWithJSONObject:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
