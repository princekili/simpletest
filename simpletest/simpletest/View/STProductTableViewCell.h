//
//  STProductTableViewCell.h
//  simpletest
//
//  Created by Prince Wang on 2021/3/8.
//

#import <UIKit/UIKit.h>

@class STProductDataObject;

@interface STProductTableViewCell : UITableViewCell

- (void)setup:(STProductDataObject *) product;

//@property (nonatomic, strong) STProductDataObject *prodcut;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellingQtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellingStartDateTimeLabel;

@end
