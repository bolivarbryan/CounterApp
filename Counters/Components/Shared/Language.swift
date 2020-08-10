import Foundation

public enum Language {
    
    ///Contains all the copy texts used on Welcome Screen
    public enum Welcome: String, Localizable, CaseIterable {
        case title
        case subtitle
        case addAlmostAnything
        case addAlmostAnythingValue
        case countToSelf
        case countToSelfValue
        case countYourToughts
        case countYourToughtsValue
        case continueButton
        
        var sectionName: String {
            return "welcome"
        }
        
        public var localizedValue: String {
            let key = "\(sectionName).\(self.rawValue)"
            return NSLocalizedString(key, comment: key)
        }
        
    }
   
    /// Contains all the copy texts used on Main Screen
    enum Main {
        case appName
        case search
        case totalCount(numberOfCounts: Int, total: Int)
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
    }
    
    /// Contains all the copy texts used on Edit mode for Main Screen
    enum Edit {
        case deleteCounters(count: Int)
        case cancel
        case selectCall
        case errorDeletion
    }
    
    /// Contains all the copy texts used on Create a counter Screen
    enum CreateACounter {
        case title
        case cancel
        case save
        case suggestionText
        case examples
        case errorCreatingCounter
        case errorInternetConnection
        case dismiss
    }
    
    /// Contains all the copy texts used on Create a counter Screen
    enum Examples {
        case title
        case subtitle
    }
}

protocol Localizable {
    var sectionName: String { get }
    var localizedValue: String { get }
}
