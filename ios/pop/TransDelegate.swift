//
//  Transitioner.swift
//  ios
//
//  Created by S. Matthew English on 8/28/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

//presenter.width = 242
//presenter.height = 158
//TransInvalid
class TransDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let width: Int// = 0 //242
    let height: Int// = 0 //158
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController) -> UIPresentationController? {
        
        let presenter: Presenter = Presenter(
            width: self.width,
            height: self.height,
            presentedViewController: presented,
            presenting: presenting) //PresInvalid
        return presenter
    }
}
