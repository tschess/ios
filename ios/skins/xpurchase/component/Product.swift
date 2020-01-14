//
//  Skins.swift
//  ios
//
//  Created by Matthew on 11/11/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

public struct Product {
  
  public static let SwiftShopping = "io.bahlsenwitz.tschess.iapetus"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [Product.SwiftShopping]

  public static let store = InAppPurchase(productIds: Product.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
