
import Foundation

enum AllertThemes {
    
    case error
    case success
    case warning
    
    var localize: String {
        switch self {
            case .error:
            return "Error".localized
            case .success:
                return "Success".localized
            case .warning:
                return "Warning".localized
        }
    }
   
}
