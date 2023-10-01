
import UIKit
import NVActivityIndicatorView

protocol LoaderViewProtocol {
    func startLoading()
    func stopLoading()
    func enableUserAction()
    func disableUserAction()
}

extension LoaderViewProtocol where Self: UIViewController {
    
    func startLoading(){
        let activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .MainGradientFirstColor, padding: .zero)
        //        activityIndicatorView
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        activityIndicatorView.startAnimating()
//        self.view.isUserInteractionEnabled = false
//        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            if let indicator = self.view.subviews.first(where: {$0 is NVActivityIndicatorView }) as? NVActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
//                self.view.isUserInteractionEnabled = true
//                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
    }
    
    func enableUserAction(){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
        }
    }
    func disableUserAction(){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
        }
    }
}
protocol MRActivityIndicatorProtocol {
    func show()
    func hide()
}

class MRActivityIndicator: UIView, MRActivityIndicatorProtocol {
    
    static let loader = MRActivityIndicator()
    
    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    private var spinnerBehavior: UIDynamicItemBehavior?
    private var animator: UIDynamicAnimator?
    private var imageView: UIImageView?
    private var loaderImageName = "logo_splach"
        
    func show() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            guard let self = self else {return}
            if self.imageView == nil {
                self.setupView()
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    self.showLoadingActivity()
                }
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.stopAnimation()
        }
    }
    
    private func setupView() {
        center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        let theImage = UIImage(named: loaderImageName)
        imageView = UIImageView(image: theImage)
        imageView?.frame = CGRect(x: self.center.x - 20, y: self.center.y - 20, width: 50, height: 80)
        
        if let imageView = imageView {
            self.spinnerBehavior = UIDynamicItemBehavior(items: [imageView])
        }
        animator = UIDynamicAnimator(referenceView: self)
    }
    
    private func showLoadingActivity() {
        if let imageView = imageView {
            addSubview(imageView)
            startAnimation()
            UIApplication.shared.windows.first?.addSubview(self)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    private func startAnimation() {
        guard let imageView = imageView,
              let spinnerBehavior = spinnerBehavior,
              let animator = animator else { return }
        if !animator.behaviors.contains(spinnerBehavior) {
            spinnerBehavior.addAngularVelocity(5.0, for: imageView)
            animator.addBehavior(spinnerBehavior)
        }
    }
    
    private func stopAnimation() {
        animator?.removeAllBehaviors()
        imageView?.removeFromSuperview()
        imageView = nil
        self.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
