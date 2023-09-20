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
    
    
    private func attribute(){

        tabButton.do{
            $0.isUserInteractionEnabled = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 20 * Constants.standartFont)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
            $0.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4*Constants.standardWidth, bottom: 0, right: -4*Constants.standardWidth)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4*Constants.standardWidth, bottom: 0, right: 4*Constants.standardWidth)
            
        }

    }
    
    private func layout(){
        contentView.addSubview(tabButton)
        tabButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func updateBorderColor(to color: UIColor) {
            tabButton.layer.borderColor = color.cgColor
        }
    
}
