import Foundation

public enum Language {
    
    ///Contains all the copy texts used on Welcome Screen
    public enum Welcome: String, Localizable {
        case title
        case subtitle
        case addAlmostAnything
        case addAlmostAnythingValue
        case countToSelf
        case countToSelfValue
        case countYourToughts
        case countYourToughtsValue
        case continueButton
        
        public var sectionName: String {
            return "welcome.\(self.rawValue)"
        }
    }
   
    /// Contains all the copy texts used on Main Screen
    public enum Main: String, Localizable {
        public typealias RawValue = String
        
        case appName
        case search
        case totalCount
        case edit
        case errorLoadingCounters
        case errorInternetConnection
        case retry
        case errorNoCountersYet
        case errorNoCountersYetDescription
        case errorUpdatingValue
        case createACounter
        case cancel
        case searchNoResults
        case done
        case selectAll
        
        public var sectionName: String {
            return "main.\(self.rawValue)"
        }
        
    }
    
    /// Contains all the copy texts used on Edit mode for Main Screen
    public enum Edit: String, Localizable {
//        case deleteCounters(count: Int)
        case cancel
        case selectCall
        case errorDeletion
        
        public var sectionName: String {
            return "edit.\(self.rawValue)"
        }
    }
    
    /// Contains all the copy texts used on Create a counter Screen
    public enum CreateACounter: String, Localizable  {
        case title
        case cancel
        case save
        case suggestionText
        case examples
        case errorCreatingCounter
        case errorInternetConnection
        case dismiss
        
        public var sectionName: String {
            return "create.\(self.rawValue)"
        }
    }
    
    /// Contains all the copy texts used on Create a counter Screen
    public enum Examples: String, Localizable {
        case title
        case subtitle
        
        public var sectionName: String {
            return "example.\(self.rawValue)"
        }
    }
    
    func testing(parameter: Localizable) -> String {
        return parameter.localizedValue
    }
}

public protocol Localizable {
    var sectionName: String { get }
    var localizedValue: String { get }
}
extension Localizable {
    public var localizedValue: String {
        return NSLocalizedString(sectionName, comment: sectionName)
    }
}
