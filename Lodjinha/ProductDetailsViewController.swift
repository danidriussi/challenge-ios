//
//  ProductDetailsViewController.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var bottomView: UIView!
    
    @IBOutlet weak private var bookButton: UIButton!
    
    var productId: Int?
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    func setupData() {
        bookButton.isEnabled = false
        
        if let productId = productId {
            DataHandler.instance.getProduct(with: String(productId), sucessBlock: { (responseProduct) in
                self.product = responseProduct
                
                self.bookButton.isEnabled = true
                
                self.tableView.reloadData()
                
            }, failureBlock: { (errorMessage) in
                //
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if product == nil {
            return 1
        }
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if product == nil {
            if indexPath.row == 0 {
                return 90.0
            }
            
            return 0.0
            
        } else {
            if indexPath.row == 0 {
                return 0.0
                
            } else if indexPath.row == 1 {
                return 190.0
                
            } else if indexPath.row == 2 {
                return 50.0
                
            } else if indexPath.row == 3 {
                return 230.0
            }
        }
        
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = product else {
            return tableView.dequeueReusableCell(withIdentifier: "Loading Cell", for: indexPath)
        }
        
        var cell = UITableViewCell()
        
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Upper Product Cell", for: indexPath) as! UpperProductDetailsTableViewCell
            
        } else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Pricing Cell", for: indexPath) as! PrincingTableViewCell
            
        } else if indexPath.row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Bottom Product Cell", for: indexPath) as! BottomProductTableViewCell
        }
        
        cell.customObject = product
        
        return cell
    }
    
    
}