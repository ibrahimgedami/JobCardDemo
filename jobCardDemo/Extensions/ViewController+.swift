//
//  ViewController+.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 5/25/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension UIViewController: UIPopoverPresentationControllerDelegate {
    
    func customPresent(_ vc: UIViewController) {
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc ,animated: true, completion: nil)
    }
    func fullPresent(_ vc: UIViewController) {
        vc.modalPresentationStyle = .overFullScreen
    //    vc.modalTransitionStyle = .crossDissolve
        self.present(vc ,animated: true, completion: nil)
    }
    
    func presentModelyVC(_ vc: UIViewController) {
        vc.definesPresentationContext = true
        if #available(iOS 13, *) {
            // vc.modalPresentationStyle = .fullScreen
        } else {
            vc.modalPresentationStyle = .custom
        }
        present(vc, animated: true, completion: nil)
    }
    
    func animateIn(_ myView: UIView) {
//        self.view.addSubview(view)
        myView.center = self.view.center
        
        myView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        myView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
//            self.visualEffectView.effect = self.effect
            myView.alpha = 1
            myView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut (_ myView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            myView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            myView.alpha = 0
            
//            self.visualEffectView.effect = nil
            
        }) { (success:Bool) in
//                myView.removeFromSuperview()
            self.dismissMePlease()
        }
    }

    
    func popover<ViewController : UIViewController>(_ sender : UIButton ,style : UIModalPresentationStyle , width:Int , height:Int, vc : ViewController.Type , completion : (() -> Void)? = nil) {
        let viewControllerID = String(describing: vc.self)
        let popVC = ViewController(nibName: viewControllerID, bundle: nil)
        popVC.modalPresentationStyle = style
        popVC.preferredContentSize = CGSize(width: width, height: height)
        let navigationVC = UINavigationController(rootViewController: popVC)
        navigationVC.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = navigationVC.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = sender
        self.present(navigationVC, animated: true, completion: completion)
    }
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func push(after: Double,_ vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func popMe() {
        navigationController?.popViewController(animated: true)
    }
    
    func popMeWithDuration(after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func popToRoot(after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func clearNavigationBackButtonTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func navTitle(title: String? = nil) {
        if let title = title, title != "" {
            let titleLabel = UILabel()
            
            titleLabel.font = .cairoRegular(of: 20)
            titleLabel.withHeight(25)
//
            navigationItem.titleView = titleLabel
            titleLabel.leadingAnchorSuperView(constant: 50)
            titleLabel.centerXInSuperview()
        }
    }
    
    func configNavBar(title: String? = nil, isLarge: Bool, backgroundColor: UIColor = .white) {
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = isLarge
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.backgroundColor = backgroundColor
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func showAlertController(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 2) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.tintColor = .MainYellow
        alert.title = title
        alert.message = message
        
        alert.setValue(NSAttributedString(string: title ?? "", attributes: [.foregroundColor : UIColor.MainYellow]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: message ?? "", attributes: [.foregroundColor: UIColor.MainYellow, .font: UIFont.boldSystemFont(ofSize: 14)]), forKey: "attributedMessage")
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok".localized, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
    
    func setTitle(_ title: String , size : Int = 20) {
        navigationItem.title = title
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.proximaBold(of: CGFloat(size)), .foregroundColor: UIColor(hexString: "#FFFFFF")]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func transparentNavBar(backColor: UIColor = .white) {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = backColor
    }
    
    func setStatusBarColor(to color: UIColor = .white) {
        var statusBar: UIView
        
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            let frame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame
            statusBar = UIView(frame: frame ?? .zero)
            keyWindow?.addSubview(statusBar)
        } else {
            statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView ?? UIView()
        }
        
        // statusBar.backgroundColor = color
    }
    
    func customNavigationController() {
        // navigationController?.navigationBar.prefersLargeTitles = true

        transparentNavBar(backColor: .white)
     
//        navigationController?.navigationBar.setGradientBackground(to: self.navigationController!)
//
//        navigationController?.navigationBar.cornerRadiusBottom()
//        tabBarController?.tabBar.applyGradient()
//        tabBarController?.tabBar.cornerRadiusTop()
        
    }
    
    func navbarWithdismiss() {
        let exitButton = UIBarButtonItem(title: "Back".localized, style: .plain, target: self, action: #selector(dismissMePlease))
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc
    func dismissMePlease() {
        dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    func removeNotificationsObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    var toNavigation: UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.barTintColor = .MainWhite
        nav.navigationBar.tintColor = .MainBlack
         var textAttributes = nav.navigationBar.titleTextAttributes
        textAttributes?[NSAttributedString.Key.foregroundColor] = UIColor.MainBlack
            nav.navigationBar.titleTextAttributes = textAttributes
        textAttributes?[NSAttributedString.Key.font] = UIFont.cairoBold(of: 15)
        return nav
    }
    var hideNavigation: UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.setNavigationBarHidden(true, animated: true)
        return nav
    }
}

extension UIViewController {
    func addChildViewController(childViewController: UIViewController, childViewControllerContainer: UIView, comp: (() -> ())? = nil) {
        
        removeChildViewControllers()
        
        addChild(childViewController)
        
        childViewControllerContainer.addSubview(childViewController.view)
        childViewController.view.frame = childViewControllerContainer.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
        comp?()
    }
    
    func addChildViewControllerWithConstraint(childViewController: UIViewController, childViewControllerContainer: UIView, comp: (() -> ())? = nil) {
        removeChildViewControllers()
        
        addChild(childViewController)
        
        childViewControllerContainer.addSubview(childViewController.view)
        let constriants = [
            childViewController.view.topAnchor.constraint(equalTo: childViewControllerContainer.topAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: childViewControllerContainer.bottomAnchor),
            childViewController.view.leadingAnchor.constraint(equalTo: childViewControllerContainer.leadingAnchor),
            childViewController.view.trailingAnchor.constraint(equalTo: childViewControllerContainer.trailingAnchor)]
        childViewControllerContainer.addConstraints(constriants)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewControllerContainer.layoutIfNeeded()
        childViewController.didMove(toParent: self)
        comp?()

    }

    func removeChildViewControllers() {
        if children.count > 0 {
            for i in  children.enumerated() {
                children[i.offset].willMove(toParent: nil)
                children[i.offset].view.removeFromSuperview()
                children[i.offset].removeFromParent()
            }
        }
    }
}


extension UIViewController{
    
    func navigatewithGoogleMap(url: String){
        if let url = URL(string: url) , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }else{
            let aler = UIAlertController(title: "Warning".localized, message: "You not installed Google Map Please Install it First".localized, preferredStyle: .alert)
            self.presentModelyVC(aler)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                aler.dismissMePlease()
                self.openAppStore(id:"585027354")
            }
        }
    }
    
    func openAppStore(id:String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(id)"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                }
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
    
    func navToGoogleMap(sourceLat: Double, sourceLng: Double, destinationLat: Double, destinationLng: Double){
        let url = "http://maps.google.com/maps?saddr=\(sourceLat),\(sourceLng)&daddr=\(destinationLat),\(destinationLng)"
        print(url)
        
        if let url = URL(string: url) , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }else{
            let aler = UIAlertController(title: "Warning".localized, message: "You not installed Google Map Please Install it First".localized, preferredStyle: .alert)
            self.presentModelyVC(aler)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                aler.dismissMePlease()
                self.openAppStore(id:"585027354")
            }
        }
        
    }
}

extension UIImageView {
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
            var gradientImage:UIImage?
            UIGraphicsBeginImageContext(gradientLayer.frame.size)
            if let context = UIGraphicsGetCurrentContext() {
                gradientLayer.render(in: context)
                gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            }
            UIGraphicsEndImageContext()
            return gradientImage
        }
}

extension UINavigationBar {
   
    
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}


extension UIViewController{
    func alertPermisn() {
        let alertController = UIAlertController(title: "Location Permission Required".localized, message: "Please enable location permissions in settings.".localized, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Settings".localized, style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func viewTapped(viewTapped: UIView, action: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        viewTapped.addGestureRecognizer(tap)
    }
    
}

extension UIViewController {
    
    static let preventPageSheetPresentation: Void = {
        if #available(iOS 13, *) {
            _swizzling(forClass: UIViewController.self,
                       originalSelector: #selector(present(_: animated: completion:)),
                       swizzledSelector: #selector(_swizzledPresent(_: animated: completion:)))
        }
    }()
    
    @available(iOS 13.0, *)
    @objc private func _swizzledPresent(_ viewControllerToPresent: UIViewController,
                                        animated flag: Bool,
                                        completion: (() -> Void)? = nil) {
        if viewControllerToPresent.modalPresentationStyle == .pageSheet
            || viewControllerToPresent.modalPresentationStyle == .automatic {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
        }
        _swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}


private func _swizzling(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
       let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
}

extension UIViewController {
    
    func getCurrentLocation() {
        let locManager = CLLocationManager()
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            guard let currentLocation = locManager.location else {
                return
            }
//            let lat = currentLocation.coordinate.latitude
//            let lng = currentLocation.coordinate.longitude
//            AuthService.userData?.lat = lat
//            AuthService.userData?.lng = lng
        }
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        let manager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch manager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    hasPermission = false
                case .authorizedAlways, .authorizedWhenInUse:
                    hasPermission = true
                @unknown default:
                    break
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    func showPopUpPermission() {
        if !hasLocationPermission() {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func convertLatLongToAddress(latitude: Double, longitude: Double) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        var labelText = ""
        var address = ""
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if placeMark != nil {
                if let name = placeMark.name {
                    labelText = name
                }
                if let subThoroughfare = placeMark.subThoroughfare {
                    if (subThoroughfare != placeMark.name) && (labelText != subThoroughfare) {
                        labelText = (labelText != "") ? labelText + "," + subThoroughfare : subThoroughfare
                    }
                }
                if let subLocality = placeMark.subLocality {
                    if (subLocality != placeMark.subThoroughfare) && (labelText != subLocality) {
                        labelText = (labelText != "") ? labelText + "," + subLocality : subLocality
                    }
                }
                
                if let street = placeMark.thoroughfare {
                    if (street != placeMark.subLocality) && (labelText != street) {
                        labelText = (labelText != "") ? labelText + "," + street : street
                    }
                }
                
                if let locality = placeMark.locality {
                    if (locality != placeMark.thoroughfare) && (labelText != locality) {
                        labelText = (labelText != "") ? labelText + "," + locality : locality
                    }
                }
                
                if let city = placeMark.subAdministrativeArea {
                    if (city != placeMark.locality) && (labelText != city) {
                        labelText = (labelText != "") ? labelText + "," + city : city
                    }
                }
                
                if let country = placeMark.country {
                    labelText = (labelText != "") ? labelText + "," + country : country
                }
                ///
                address = labelText
            }
        })
        return address
    }
    
    func getAddress(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation.init(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // check for errors
            guard let placeMarkArr = placemarks else {
                completion("")
                debugPrint(error ?? "")
                return
            }
            // check placemark data existence
            
            guard let placemark = placeMarkArr.first, !placeMarkArr.isEmpty else {
                completion("")
                return
            }
            // create address string
            
            let outputString = [placemark.locality,
                                placemark.subLocality,
                                placemark.thoroughfare,
                                placemark.postalCode,
                                placemark.subThoroughfare,
                                placemark.country].compactMap { $0 }.joined(separator: ", ")
            
            completion(outputString)
        })
    }
}

