//
//  ProductViewController.swift
//  simpletest
//
//  Created by prince on 2021/1/22.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: -
    
    var products: [SalePageListItem] = []
    
    var filteredProducts: [SalePageListItem] = []
    
    var isSoldOut: Bool = false
    
    var isComingSoon: Bool = false
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        activityIndicator.hidesWhenStopped = true
        fetchProducts()
    }
    
    // MARK: -
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func fetchProducts() {
        activityIndicator.startAnimating()

        ProductNetworking().getProducts { [weak self] (products) in
            self?.products = products
            self?.reloadData()
        }
    }
    
    private func handleFilters() {
        filteredProducts = products.filter { $0.isSoldOut == isSoldOut && $0.isComingSoon == isComingSoon }
        reloadData()
    }
    
    private func priceDescending() {
        // Price: H -> L
        products.sort {
            guard let priceZero = $0.price,
                  let priceOne = $1.price
            else { return false }
            return priceZero > priceOne
        }
    }
    
    private func priceAscending() {
        // Price: L -> H
        products.sort {
            guard let priceZero = $0.price,
                  let priceOne = $1.price
            else { return false }
            return priceZero < priceOne
        }
    }
    
    private func timeDescending() {
        // Start-selling Time: new -> old
        products.sort {
            guard let timeZero = $0.sellingStartDateTime,
                  let timeOne = $1.sellingStartDateTime
            else { return false }
            return timeZero > timeOne
        }
    }
    
    private func timeAscending() {
        // Start-selling Time: old -> new
        products.sort {
            guard let timeZero = $0.sellingStartDateTime,
                  let timeOne = $1.sellingStartDateTime
            else { return false }
            return timeZero < timeOne
        }
    }
    
    // MARK: - @IBAction
    
    // To sort items
    @IBAction func segmentedControlDidTap(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {

        case 0: priceDescending()

        case 1: priceAscending()

        case 2: timeDescending()

        case 3: timeAscending()

        default: break
        }
        
        reloadData()
    }
    
    // To filter items
    @IBAction func isSoldOutSwitchDidTap(_ sender: UISwitch) {
        isSoldOut = sender.isOn
        handleFilters()
    }
    
    // To filter items
    @IBAction func isComingSoonSwitchDidTap(_ sender: UISwitch) {
        isComingSoon = sender.isOn
        handleFilters()
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isFiltered = isSoldOut == true || isComingSoon == true
        return isFiltered ? filteredProducts.count : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseId, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        let isFiltered = isSoldOut == true || isComingSoon == true
        let product = isFiltered ? filteredProducts[indexPath.row] : products[indexPath.row]
        cell.setup(with: product)
        
        return cell
    }
}
