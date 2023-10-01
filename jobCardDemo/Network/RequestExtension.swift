
import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("====================******************===================")
        debugPrint(self)
        debugPrint("====================******************===================")
        #endif
        return self
    }
}
