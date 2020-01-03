//
//  TransitioningDelegate.swift
//  ios
//
//  Created by Matthew on 8/21/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
