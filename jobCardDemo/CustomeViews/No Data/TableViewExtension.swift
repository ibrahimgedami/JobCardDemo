
import Foundation
import UIKit

extension UITableView {
    
    func setEmptyData(title: String) {
        let vc = NoDataViewController(frame: .zero)
        vc.setData(image: "logo_splach", description: description, title: title)
        backgroundView = vc
    }
   
    func removeBackGroundView() {
        backgroundView = nil
    }
    
}

extension UICollectionView {
    
    func setEmptyData(description: String? = nil, title:String? = nil) {
        let vc = NoDataViewController(frame: .zero)
        vc.setData(image: "logo_splach", description: description ?? "", title: title ?? "")
        backgroundView = vc
    }
    
    func removeBackGroundView() {
        backgroundView = nil
    }
    
}

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
}
