//
//  STProductDataObject.m
//  simpletest
//
//  Created by Prince Wang on 2021/3/5.
//

#import <Foundation/Foundation.h>
#import "STProductDataObject.h"

//@interface STProductDataObject ()
//
//@property (nonatomic, readwrite, strong) NSString *title;
//
//@property (nonatomic, readwrite) NSInteger salePageId;
//@property (nonatomic, readwrite) NSInteger price;
//@property (nonatomic, readwrite) NSInteger suggestPrice;
//@property (nonatomic, readwrite) NSInteger sellingQty;
//@property (nonatomic, readwrite) NSInteger sellingStartDateTime;
//
//@property (nonatomic, readwrite) BOOL isSoldOut;
//@property (nonatomic, readwrite) BOOL isComingSoon;
//
//@end

@implementation STProductDataObject

- (instancetype)initWithJSONObject:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.title = json[@"title"];
        self.salePageId = [json[@"salePageId"] integerValue];
        self.price = [json[@"price"] integerValue];
        self.suggestPrice = [json[@"suggestPrice"] integerValue];
        self.sellingQty = [json[@"sellingQty"] integerValue];
        self.sellingStartDateTime = [json[@"sellingStartDateTime"] integerValue];
        self.isSoldOut = [json[@"isSoldOut"] boolValue];
        self.isComingSoon = [json[@"isComingSoon"] boolValue];
    }
    return self;
}

@end
