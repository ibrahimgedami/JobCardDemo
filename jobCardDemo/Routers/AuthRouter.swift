
import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    
    case login(body : LoginViewModel)

    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "client/login"
        }
    }
    
    var parameters: [String : Any]?  {
        switch self {
        case .login(body : let body):
            return body.getBody()
        }
    }
}
