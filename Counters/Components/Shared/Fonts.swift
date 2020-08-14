import Foundation
import UIKit

extension UIFont {
    ///Contains Fonts used in app including variations
    enum CounterFont {
        static let title = UIFont.systemFont(ofSize: 33, weight: .heavy)
        static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let bodyTitle = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let emptyStateTitle = UIFont.systemFont(ofSize: 22, weight: .semibold)
        static let tabBarTitle = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let cellLargeTitle = UIFont.systemFont(ofSize: 24, weight: .semibold)
        static let cellSectionTitle = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
}
