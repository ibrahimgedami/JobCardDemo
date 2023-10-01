
import UIKit
import SwiftEntryKit

class Alert: UIViewController {
    
    class func showErrorAlert(title : String , body : String){
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .color(color: EKColor(UIColor.MainMagenta))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.7), scale: .init(from: 1, to: 1, duration: 1)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 15, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: ScreenWidth), height: .intrinsic)
        let title = EKProperty.LabelContent(text: title, style: .init(font:UIFont.proximaBold(of: 17), color: .white))
        let description = EKProperty.LabelContent(text: body, style: .init(font: UIFont.proximaRegular(of: 17), color: .white ))
        let image = EKProperty.ImageContent(image: UIImage(named: "logo_splach") ?? UIImage(), size: CGSize(width: 35, height: 45))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
}
