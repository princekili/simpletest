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
    
    var products: [SalePageListItem] = []
    
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
    
    // MARK: - get Products
    
    private func fetchProducts() {
        activityIndicator.startAnimating()

        ProductNetworking().getProducts { (products) in
            self.products = products
            self.reloadData()
        }
    }
    
    // MARK: - @IBAction
    
    // To sort items
    @IBAction func segmentedControlDidTap(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        
        case 0:
            // Price: H -> L
            break
            
        case 1:
            // Price: L -> H
            break
            
        case 2:
            // Start-selling Time: new -> old
            break
            
        case 3:
            // Start-selling Time: old -> new
            break
            
        default:
            break
        }
    }
    
    // To filter items
    @IBAction func isSoldOutSwitchDidTap(_ sender: UISwitch) {
        if sender.isOn {
            // Show sold-out items
        } else {
            // Turn off the filter
        }
    }
    
    // To filter items
    @IBAction func isComingSoonSwitchDidTap(_ sender: UISwitch) {
        if sender.isOn {
            // Show coming-soon items
        } else {
            // Turn off the filter
        }
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseId, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        let product = products[indexPath.row]
        cell.setup(with: product)
        
        return cell
    }
}
