
import Foundation
import Alamofire

class RequestAdapterMiddleware: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        let cacheService = CacheService()
        if let token = cacheService.getUserData()?.token?.accessToken {
            urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue(L102Language.getCurrentLanguage(), forHTTPHeaderField: "Accept-Language")
        
        #if DEBUG
        debugPrint("====================******************===================")
        print(urlRequest)
        print(urlRequest.allHTTPHeaderFields!)
        print(urlRequest.method!)
        debugPrint("====================******************===================")
        #endif
        
        completion(.success(urlRequest))
    }
}

class RequestRetrierMiddleware: RequestRetrier {
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
