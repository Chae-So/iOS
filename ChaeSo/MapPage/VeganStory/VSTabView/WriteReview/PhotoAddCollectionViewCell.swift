import UIKit
import SnapKit

class PhotoAddCollectionViewCell: UICollectionViewCell {
    var photoImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexCode: "F5F5F5")
        layer.cornerRadius = 8*Constants.standardHeight
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        photoImage.contentMode = .scaleAspectFit
    }
    
    func layout(){
        addSubview(photoImage)
        photoImage.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }

   
}
