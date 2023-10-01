
import UIKit

class MainButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        makeItDisable()
    }

    func makeItDisable() {
        isEnabled = false
        layer.borderWidth = 0
        isUserInteractionEnabled = false
        tintColor = .MainWhite
        setTitleColor(.MainWhite, for: .normal)
        backgroundColor = .lightGray
//        removeGradient()
    }

    func makeItEnable(gradientType: GradientType = .fromTopToBottom ) {
        isEnabled = true
        layer.borderWidth = 0
        isUserInteractionEnabled = true
        tintColor = .MainWhite
        setTitleColor(.MainYellow, for: .normal)
        backgroundColor = .MainBlack
        layoutIfNeeded()
    }
}
