//
//  Product.swift
//  ios
//
//  Created by S. Matthew English on 12/17/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

public struct Product {
  
    //var id_year: String?
    //var id_month: String?
    //self.id_year = "002"
    //self.id_month = "001"
    
  public static let SwiftShopping = "io.bahlsenwitz.tschess.001"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [Product.SwiftShopping]

  public static let store = InAppPurchase(productIds: Product.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
