import UIKit

class ActionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = .zero
        layer.cornerRadius = 30
    }
}
