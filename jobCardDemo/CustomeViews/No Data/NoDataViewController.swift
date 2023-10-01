
import UIKit

class NoDataViewController: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageLogo: UIImageView!

    var count = 0
//    private weak var delegate:NoDataViewControllerDelegate?
    
    func setData(image: String, description: String?,title:String) {
//        imageLogo.image = image
        lblTitle.text = title
        imageLogo.image = UIImage(named: image)
        fadeIn()
    }
    
    func fadeIn(withDuration duration: TimeInterval = 1.0) {
        imageLogo.alpha = 0
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else {return}
            self.imageLogo.alpha = 1.0
            self.lblTitle.fadeTransition(0.4)
            self.count += 1
        })
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        commenInitialization()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commenInitialization()
    }

    func commenInitialization() {
        Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
