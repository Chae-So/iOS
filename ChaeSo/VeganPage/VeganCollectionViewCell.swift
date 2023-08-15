import UIKit
import SnapKit
import Then

class VeganCollectionViewCell: UICollectionViewCell {
    
    let tabButton = UIButton()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func attribute(){
//        tabButton.isUserInteractionEnabled = false
//        tabButton.adjustsImageWhenHighlighted = false
//        tabButton.clipsToBounds = true
//        tabButton.titleLabel?.textAlignment = .center
//        tabButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
//        tabButton.setTitleColor(UIColor.black, for: .normal)
//        tabButton.sizeToFit()
//        tabButton.layer.cornerRadius = tabButton.frame.size.height / 2
//        tabButton.layer.borderWidth = 1
//        tabButton.layer.borderColor = UIColor.clear.cgColor
//        tabButton.backgroundColor = UIColor.white
//        tabButton.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
//        
        
        tabButton.do{
            $0.isUserInteractionEnabled = false
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 20 * Constants.standardWidth)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
            
            $0.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
            
        }

    }
    
    func layout(){
        contentView.addSubview(tabButton)
        tabButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

    }
}
