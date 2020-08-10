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
    
    var imageRepresentation: UIImage {
        switch self {
        case .number(let value):
            return UIImage(systemName: "\(value).circle.fill")!
        case .people:
            return UIImage(systemName: "person.2.fill")!
        case .lightBulb:
            return UIImage(systemName: "lightbulb.fill")!
        case .trash:
            return UIImage(systemName: "trash")!
        case .share:
            return UIImage(systemName: "square.and.arrow.up")!
        case .circle:
            return UIImage(systemName: "circle")!
        case .circleCheckMark:
            return UIImage(systemName: "checkmark.circle")!
        case .minus:
            return UIImage(systemName: "minus")!
        case .plus:
            return UIImage(systemName: "plus")!
        }
    }
}
