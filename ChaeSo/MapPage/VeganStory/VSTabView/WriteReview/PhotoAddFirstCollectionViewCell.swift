import UIKit
import SnapKit


class PhotoAddFirstCollectionViewCell: UICollectionViewCell {

    var localizationManager = LocalizationManager.shared
    
    private lazy var photo = UIImageView()
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexCode: "F5F5F5")
        layer.cornerRadius = 8*Constants.standardHeight
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "gray10")?.cgColor
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        photo.image = UIImage(named: "photo")
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        titleLabel.text = localizationManager.localizedString(forKey: "Add")
    }
    
    func layout(){
        [photo,titleLabel].forEach{ addSubview($0) }
        
        photo.snp.makeConstraints { make in
            make.width.equalTo(48*Constants.standardHeight)
            make.height.equalTo(48*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photo.snp.bottom).offset(4*Constants.standardHeight)
        }
    }
}
