
import Foundation

enum AppResponse <T>  {
    case success(T)
    case error(AppError)
}

enum AppError: Error, LocalizedError {
    case cannotDecode // Handle ComminDate
    case noInternet // ---
    case error(String) // Error.Description
    case tokenExpire // 401
    case internalServerError // 500
    case timeOut
    var errorDescription: String? {
        switch self {
        case .cannotDecode:
            return "cannotDecode"
        case .noInternet:
            return "noInternet"
        case let .error(err):
            return err
        case .tokenExpire:
            return "tokenExpire"
        case .internalServerError:
            return "internalServerError"
        case .timeOut:
            return "timeOut"
        }
    }
   
}
