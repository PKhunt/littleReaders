//
//  NavigationController+Extension.swift
//  littleReaders
//
//  Created by mymac on 21/10/22.
//

import Foundation
import UIKit

public extension UINavigationController {

    /**
     Pop current view controller to previous view controller.

     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func pop(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }

    /**
     Push a new view controller on the view controllers's stack.

     - parameter vc:       view controller to push.
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func push(viewController vc: UIViewController, transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }

    private func addTransition(transitionType type:  CATransitionType, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }

}
