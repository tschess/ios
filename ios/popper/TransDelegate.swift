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
    
    func presentationController(
        width: Int,
        height: Int,
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController) -> UIPresentationController? {
        
        let presenter: Presenter = Presenter(presentedViewController: presented, presenting: presenting) //PresInvalid
        presenter.width = width
        presenter.height = height
        
        return presenter
    }
}
