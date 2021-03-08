//
//  STProductTableViewCell.m
//  simpletest
//
//  Created by Prince Wang on 2021/3/8.
//

//#import <Foundation/Foundation.h>
#import "STProductTableViewCell.h"
#import "STProductDataObject.h"
    
@implementation STProductTableViewCell

- (void)setup:(STProductDataObject *) product {
    if (product) {
        self.titleLabel.text = product.title;
        
        self.priceLabel.text = [NSString stringWithFormat:@"NT$%ld", (long)product.price];
        self.priceLabel.textColor = product.price > 200 ? UIColor.redColor : UIColor.labelColor;
        
        self.suggestPriceLabel.text = [NSString stringWithFormat:@"NT$%ld", (long)product.suggestPrice];
        
        self.sellingQtyLabel.text = [NSString stringWithFormat:@"NT$%ld", (long)product.sellingQty];
        
        // MARK: To fix
        self.sellingStartDateTimeLabel.text = @"Test";
    }
}

// MARK: - Setup time label
/*
 
- (NSString *)timeStampToStringDetail:(NSString *) timeStampString {
//    NSString *string = timeStamp;
//    NSTimeInterval *timeStamp = [timeStampString doubleValue];
}
 */

@end
