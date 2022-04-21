//
//  File.swift
//  Time Reminder
//
//  Created by Maxence Gama on 18/04/2021.
//

import Foundation
import UIKit

class LauchScreenTransition: UIStoryboardSegue {

    override func perform() {
        fade()
    }
    
    func fade() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.alpha = 0
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseInOut, animations: { [self] in
            toViewController.view.alpha = 1
        }, completion: { succes in
            toViewController.modalPresentationStyle = .fullScreen
            fromViewController.present(toViewController, animated: false, completion: nil)
            
        })
    }
}
