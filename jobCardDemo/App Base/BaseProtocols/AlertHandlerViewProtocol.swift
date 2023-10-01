
import UIKit

protocol AlertHandlerViewProtocol: AnyObject {
    func showAlert(with message: String, title: AllertThemes)
}

extension AlertHandlerViewProtocol where Self: UIViewController {
    func showAlert(with message: String, title: AllertThemes) {
        AlertViewHandler().showAlert(message: message, title: title)
    }
}

