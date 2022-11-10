//
//  Enums.swift
//  littleReaders
//
//  Created by mymac on 08/11/22.
//

import Foundation
import UIKit

enum CustomFont: String{
    case gardenHouseRom = "GardenHouseRom"
    case futuraStdCondensed = "FuturaStd-Condensed"
    case futuraStdCondensedBold = "FuturaStd-CondensedBold"
    case futuraStdLight = "FuturaStd-Light"
    case futuraStdMedium = "FuturaStd-Medium"
}

extension CustomFont{
    func font(size: CGFloat) -> UIFont{
        switch self{
        case .gardenHouseRom:
            return UIFont(name: "GardenHouseRom", size: size) ?? .systemFont(ofSize: size)
        case .futuraStdCondensed:
            return UIFont(name: "FuturaStd-Condensed", size: size) ?? .systemFont(ofSize: size)
        case .futuraStdCondensedBold:
            return UIFont(name: "FuturaStd-CondensedBold", size: size) ?? .systemFont(ofSize: size)
        case .futuraStdLight:
            return UIFont(name: "FuturaStd-Light", size: size) ?? .systemFont(ofSize: size)
        case .futuraStdMedium:
            return UIFont(name: "FuturaStd-Medium", size: size) ?? .systemFont(ofSize: size)
        }
    }
}

enum AppFontSize: CGFloat {
    case size12 = 12
    case size14 = 14
    case size16 = 16
    case size18 = 18
    case size20 = 20
    case size22 = 22
    case size24 = 24
    case size26 = 26
    case size28 = 28
    case size30 = 30
    case size32 = 32
    case size34 = 34
    case size36 = 36
    case size38 = 38
    case size40 = 40

    var size: CGFloat {
        let size = self.rawValue * (UIScreen.main.bounds.height / 896)
        return size
    }
}

extension UIFont {

    class func setAppFont(fontName: CustomFont, fontSize: AppFontSize) -> UIFont? {
        return UIFont(name: fontName.rawValue, size: fontSize.size)
    }

}
