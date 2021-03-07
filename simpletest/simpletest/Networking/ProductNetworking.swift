//
//  ProductNetworking.swift
//  simpletest
//
//  Created by prince on 2021/1/23.
//

import Foundation

final class ProductNetworking {
    
    let group = DispatchGroup()
    
    var categoryIds: [Int] = []
    
    var products: [SalePageListItem] = []
    
    // MARK: for ProductViewController
    
    func getProducts(completion: @escaping ([SalePageListItem]) -> Void) {
        getCategoryIds()
        group.wait()
        getProductInfoPartOne()
        group.wait()
        getProductInfoPartTwo()
        group.notify(queue: .global(qos: .userInteractive)) {
            completion(self.products)
        }
    }
}

private extension ProductNetworking {
    
    // MARK: get Product Info
    
    func getCategoryIds() {
        
        guard let url = URL(string: "https://blooming-oasis-01056.herokuapp.com/category") else {
            print("------ Error -> Invalid URL ------")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        group.enter()
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                print("------ Error -> Invalid Data ------")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("------ Error -> Invalid HTTP Response Code ------")
                return
            }
            
            do {
                let categoryList = try JSONDecoder().decode(CategoryList.self, from: data)
                
                for category in categoryList.data.shopCategoryList.categoryList {
                    self.categoryIds.append(category.id)
                }
                self.group.leave()
                
            } catch {
                print("------ Error -> \(error.localizedDescription) ------")
            }
        }
        
        task.resume()
    }
    
    func getProductInfoPartOne() {
        
        for id in categoryIds {
            guard let url = URL(string: "https://blooming-oasis-01056.herokuapp.com/product?id=\(id)") else {
                print("------ Error -> Invalid URL ------")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            group.enter()
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data else {
                    print("------ Error -> Invalid Data ------")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("------ Error -> Invalid HTTP Response Code ------")
                    return
                }
                
                do {
                    let salePageList = try JSONDecoder().decode(SalePageList.self, from: data)
                    
                    for item in salePageList.data.shopCategory.salePageList.salePageList {
                        self.products.append(item)
                    }
                    self.group.leave()
                    
                } catch {
                    print("------ Error -> \(error.localizedDescription) ------")
                }
            }
            
            task.resume()
        }
    }
    
    func getProductInfoPartTwo() {
        
        for id in categoryIds {
            guard let url = URL(string: "https://blooming-oasis-01056.herokuapp.com/sale?id=\(id)") else {
                print("------ Error -> Invalid URL ------")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            group.enter()
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data else {
                    print("------ Error -> Invalid Data ------")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("------ Error -> Invalid HTTP Response Code ------")
                    return
                }
                
                do {
                    let salePageList = try JSONDecoder().decode(SalePageList.self, from: data)
                    
                    for item in salePageList.data.shopCategory.salePageList.salePageList {
                        if let index = self.products.firstIndex(where: { $0.salePageID == item.salePageID }) {
                            self.products[index].sellingQty = item.sellingQty
                            self.products[index].sellingStartDateTime = item.sellingStartDateTime
                            self.products[index].isSoldOut = item.isSoldOut
                            self.products[index].isComingSoon = item.isComingSoon
                        }
                    }
                    self.group.leave()
                    
                } catch {
                    print("------ Error -> \(error.localizedDescription) ------")
                }
            }
            
            task.resume()
        }
    }
}
