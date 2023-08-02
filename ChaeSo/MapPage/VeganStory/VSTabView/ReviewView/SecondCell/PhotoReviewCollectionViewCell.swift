import UIKit
import SnapKit

class PhotoReviewCollectionViewCell: UICollectionViewCell {
    let photo = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        backgroundColor = UIColor(hexCode: "F5F5F5")
        photo.layer.cornerRadius = 8
    }
    
    func layout(){
        addSubview(photo)
        photo.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
