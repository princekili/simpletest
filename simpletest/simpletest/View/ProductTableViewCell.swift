//
//  ProductTableViewCell.swift
//  simpletest
//
//  Created by prince on 2021/1/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let reuseId = "ProductTableViewCell"
    
    // MARK: -

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var suggestPriceLabel: UILabel!
    
    @IBOutlet weak var sellingQtyLabel: UILabel!
    
    @IBOutlet weak var sellingStartDateTimeLabel: UILabel!
    
    // MARK: -
    
    func setup(with product: SalePageListItem) {
        guard let title = product.title,
              let price = product.price,
              let suggestPrice = product.suggestPrice,
              let sellingQty = product.sellingQty
        else { return }
        
        titleLabel.text = title
        priceLabel.textColor = price > 200 ? .red : .label
        priceLabel.text = "NT$\(price)"
        suggestPriceLabel.text = "NT$\(suggestPrice)"
        sellingQtyLabel.text = "\(sellingQty)"
        setupTimeLabel(with: product)
    }
    
    private func setupTimeLabel(with product: SalePageListItem) {
        guard let sellingStartDateTime = product.sellingStartDateTime else { return }
        let StringTimeStamp = String((sellingStartDateTime) / 1000)
        sellingStartDateTimeLabel.text = timeStampToStringDetail(StringTimeStamp)
    }
    
    private func timeStampToStringDetail(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeStamp: TimeInterval = string.doubleValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年 MM月 dd日 HH:MM:SS"
        let date = Date(timeIntervalSince1970: timeStamp)
        return dateFormatter.string(from: date)
    }
}
