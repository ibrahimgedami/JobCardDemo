//
//  View+.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 5/25/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

extension UIView {
    
   
    func isVisible() -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        
        return isVisible(view: self, inView: superview)
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        layer.add(animation, forKey: nil)
    }
    
    // parameter angle: angle in degrees
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
    @IBInspectable
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
            // layer.cornerRadius = newValue
            // layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var viewBorderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func applySketchShadow() {
        // #000000 , 2% , 0 , 3 , 16
        layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 0.2, x: 0, y: 3, blur: 16, spread: 0)
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
  
}

extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}

extension UIView {
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorSizeWithConstantAndMultiplier(to view: UIView, constant: CGFloat, multiplier: CGFloat) {
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorWithCenterXY(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor? ,centerY: NSLayoutYAxisAnchor? ,padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func fillSuperviewSafeArea(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: -padding.right).isActive = true
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    @discardableResult
    func centerXInSuperview() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constX = centerXAnchor.constraint(equalTo: superview!.centerXAnchor)
        constX.isActive = true
        return constX
    }
    
    @discardableResult
    func centerX(to constraint: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constX = centerXAnchor.constraint(equalTo: constraint)
        constX.isActive = true
        return constX
    }
    
    @discardableResult
    func centerYInSuperview() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constY = centerYAnchor.constraint(equalTo: (superview?.centerYAnchor)!)
        constY.isActive = true
        return constY
    }
    
    @discardableResult
    func centerY(to constraint: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constY = centerYAnchor.constraint(equalTo: constraint)
        constY.isActive = true
        return constY
    }
    
    @discardableResult
    func widthAnchorWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: multiplier)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func heightAnchorWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = heightAnchor.constraint(equalTo: superview!.heightAnchor, multiplier: multiplier)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func heightAnchorConstant(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = heightAnchor.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func widthAnchorConstant(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = widthAnchor.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = topAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.topAnchor)!, constant: constant)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func bottomAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = bottomAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.bottomAnchor)!, constant: -constant)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func leadingAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: (superview?.leadingAnchor)!, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func trailingAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: (superview?.trailingAnchor)!, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func widthAnchorEqualHeightAnchor() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = widthAnchor.constraint(equalTo: heightAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func heightAnchorEqualWidthAnchor() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = heightAnchor.constraint(equalTo: widthAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topAnchorToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = topAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func bottomAnchorToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func trailingAnchorToView(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func leadingAnchorToView(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func centerYToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func withSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }
    
    @discardableResult
    func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func withHeightToSuperViewWith(_ multiplier: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: superview!.heightAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func withWidthToSuperViewWith(_ multiplier: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    func cornerRadiusTop(value: CGFloat = 15) {
        viewCornerRadius = value
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        applySketchShadow()

    }
    
    func cornerRadiusBottom(value: CGFloat = 20) {
        viewCornerRadius = value
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        applySketchShadow()
        viewBorderColor = .clear
        viewBorderWidth = 0.4
    }
    
    func cornerRadiusMinBottomChatView(value: CGFloat = 20) {
        viewCornerRadius = value
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner]
        applySketchShadow()
        viewBorderColor = .clear
        viewBorderWidth = 0.4
    }
    
    func cornerRadiusMaxBottomChatView(value: CGFloat = 20) {
        viewCornerRadius = value
        clipsToBounds = true
        layer.maskedCorners = [ .layerMaxXMinYCorner]
        applySketchShadow()
        viewBorderColor = .clear
        viewBorderWidth = 0.4
    }
    
        func cornerRadiusViewChatOther() {
            viewCornerRadius = 10
            clipsToBounds = true
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            applySketchShadow()
            viewBorderColor = .clear
            viewBorderWidth = 0.4
        }
    
    func cornerRadiusViewChat(value: CGFloat = 20) {
        viewCornerRadius = value
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        applySketchShadow()
        viewBorderColor = .clear
        viewBorderWidth = 0.4
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.bounds
        blurEffectView.viewCornerRadius = self.viewCornerRadius
        blurEffectView.clipsToBounds = true
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    enum GradientType {
        case fromTopToBottom
        case fromLeftToRight
    }
    
    func applyGradient(firstColor: UIColor, secondColor: UIColor, third: UIColor?, type: GradientType) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        if let third = third {
            gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor, third.cgColor]
        }
        if type == .fromLeftToRight {
            gradientLayer.startPoint = .zero
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = viewCornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradient() {
        for x in layer.sublayers ?? [] {
            if x is CAGradientLayer {
                x.removeFromSuperlayer()
            }
        }
    }
}

extension UIViewController {
    func embed(_ viewController: UIViewController, inView view: UIView) {
        removeSubview()
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func removeSubview() {
        print("Start remove sibview")
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
}

extension UIView {

    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }


    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

class CircleView: UIView {

    override func awakeFromNib() {
        
        layer.cornerRadius = self.frame.size.height/2
        layer.masksToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}

extension UIView {
    static func build<T: UIView>(_ builder: ((T) -> Void)? = nil) -> T {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        builder?(view)

        return view
    }
}

extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    private func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}


extension UIImage {
    convenience init?(named: String) {
        self.init(named: named, in: .resourceBundle, compatibleWith: nil)
    }
}

class LocalBundle {}
extension Bundle {
    static let resourceBundle: Bundle = {
        #if SWIFT_PACKAGE
        return .module
        #else
        return Bundle(for: LocalBundle.self)
        #endif
    }()
}

extension UIColor {
    static let barTintColor = UIColor(named: "color_background")
    static let backgroundColor = UIColor(named: "color_shadow")
    static let tintColor = UIColor(named: "color_indicator")
    
    convenience init?(named: String) {
        self.init(named: named, in: .resourceBundle, compatibleWith: nil)
    }
}

extension UITableView {
    /// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

    /// SwifterSwift: Register UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
}


extension UIColor {
    static let background = UIColor(named: "MainColor")
    static let defaultTint = UIColor(named: "defaultTint")
    static let cell_background = UIColor(hexString: "#C6A283")

    struct Navigation {
        static let background = UIColor(named: "navigation_background")
    }

    struct TabBar {
        static let itemBackground = UIColor(named: "LightGold")
        static let title = UIColor(named: "Orange")
    }
}


@IBDesignable
class DashedLineView : UIView {
    @IBInspectable var perDashLength: CGFloat = 2.0
    @IBInspectable var spaceBetweenDash: CGFloat = 2.0
    @IBInspectable var dashColor: UIColor = UIColor.lightGray


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width

        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }

        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

    private var width : CGFloat {
        return self.bounds.width
    }

    private var height : CGFloat {
        return self.bounds.height
    }
 
}

extension UIView {
    
    func instanceFromNib(name: String) -> UIView {
        let bundle  = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: name , bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight , .flexibleWidth ]
        addSubview(view)
        return view
    }
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self? {
        
        func instanceFromNib<T: UIView>() -> T? {
            return UINib(nibName: "\(self)", bundle: nil).instantiate() as? T
        }
        return instanceFromNib()
    }
    
}
extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}

@IBDesignable
class RoundedTopView: UIView {

       @IBInspectable var cornerRadius: CGFloat {
           
           get{
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
               layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
               //layer.masksToBounds = newValue > 0
           }
       }
       
       @IBInspectable var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }
       
       @IBInspectable var borderColor: UIColor? {
           get {
               return UIColor(cgColor: layer.borderColor!)
           }
           set {
               layer.borderColor = borderColor?.cgColor
           }
       }
}
