//
//  Header.swift
//  ios
//
//  Created by S. Matthew English on 11/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Header: UIView {}

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
