import UIKit
import SnapKit

class ButtonCollectionViewCell: UICollectionViewCell {
    let tabButton = UIButton()
    let titleLabel = UILabel()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//            setNeedsLayout()
//            layoutIfNeeded()
//            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//            var frame = layoutAttributes.frame
//            frame.size.height = ceil(size.height)
//            frame.size.width = ceil(size.width)
//            layoutAttributes.frame = frame
//            return layoutAttributes
//        }
    
    func attribute(){
        tabButton.isUserInteractionEnabled = false
        tabButton.adjustsImageWhenHighlighted = false
        tabButton.clipsToBounds = true
        tabButton.titleLabel?.textAlignment = .center
        tabButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        tabButton.setTitleColor(UIColor.black, for: .normal)
        tabButton.sizeToFit()
        tabButton.layer.cornerRadius = tabButton.frame.size.height / 2
        tabButton.layer.borderWidth = 1
        tabButton.layer.borderColor = UIColor.clear.cgColor
        tabButton.backgroundColor = UIColor.white
        tabButton.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
        
//        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
//        titleLabel.backgroundColor = .white
//        titleLabel.sizeToFit()
//        titleLabel.layer.cornerRadius = titleLabel.frame.size.height / 2
//        titleLabel.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
    }
    
    func layout(){
        contentView.addSubview(tabButton)
        tabButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
//        contentView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
    }
}
