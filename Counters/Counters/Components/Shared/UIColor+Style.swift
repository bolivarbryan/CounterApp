import Foundation
import UIKit

extension UIColor {
    
    /// Color Pallete for identifying the colors that are being used in app
    struct Pallete {
        static let red = UIColor(red: 1, green: 0.231, blue: 0.188, alpha: 1)
        static let yellow = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
        static let green = UIColor(red: 0.298, green: 0.851, blue: 0.392, alpha: 1)
        static let black = UIColor.black
        
        static let tintColor = UIColor(red: 1, green: 0.584, blue: 0, alpha: 1)
        static let backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        static let borderColor = UIColor(red: 0.533, green: 0.545, blue: 0.565, alpha: 1)
        static let disabledColor = UIColor(red: 0.863, green: 0.863, blue: 0.875, alpha: 1)
        
        /// 74 represents value in a grayscale from 0 to 255
        static let gray74 = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
    }
}
