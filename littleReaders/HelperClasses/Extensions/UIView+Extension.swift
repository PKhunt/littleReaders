//
//  UIView+Extension.swift
//  littleReaders
//
//  Created by mymac on 21/10/22.
//

import Foundation
import UIKit

extension UIView{
    /// To set view to round shape.
    func round(){
        self.layer.cornerRadius = max(self.frame.width, self.frame.height)/2
    }
    
    /// To set corner Radius
    func setCornerRadius(_ radius: CGFloat){
        self.layer.cornerRadius = radius
    }
    
    /// To set Border width
    func setBorderWidth(_ width: CGFloat){
        self.layer.borderWidth = width
    }
}

