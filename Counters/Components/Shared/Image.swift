import Foundation
import UIKit

/// Represents the authorized icons in app
public enum Image {
    case number(value: Int)
    case people
    case lightBulb
    case trash
    case share
    case circleCheckMark
    case circle
    case minus
    case plus
    
    ///UIImage representation of Image cases in a type-safe style
    public var imageRepresentation: UIImage {
        let name: String
        switch self {
        case .number(let value):
            name = "\(value).circle.fill"
            return UIImage(systemName: name,
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold))!
        case .people:
            name = "person.2.fill"
        case .lightBulb:
            name = "lightbulb.fill"
        case .trash:
            name = "trash"
        case .share:
            name = "square.and.arrow.up"
        case .circle:
            name = "circle"
        case .circleCheckMark:
            name = "checkmark.circle"
        case .minus:
            name = "minus"
        case .plus:
            name = "plus"
        }
        return UIImage(systemName: name)!
    }
}
