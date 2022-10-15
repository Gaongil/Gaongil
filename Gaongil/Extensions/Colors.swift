//
//  Colors.swift
//  Gaongil
//
//  Created by Lena on 2022/10/15.
//

import UIKit.UIColor

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    static var customSelectedGreen: UIColor {
        return UIColor(rgb: 0x1C6974)
    }
    
    static var customUnselectedGreen: UIColor {
        return UIColor(rgb: 0xDEE9E8)
    }
    
    static var customBackgroundGreen: UIColor {
        return UIColor(rgb: 0xBDD1D4)
    }
    
    static var customBlack: UIColor {
        return UIColor(rgb: 0x1E1E1E)
    }
    
    static var customLightGray: UIColor {
        return UIColor(rgb: 0xDCDCDC)
    }
}
