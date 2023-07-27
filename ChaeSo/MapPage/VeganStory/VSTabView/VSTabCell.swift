import UIKit
import SnapKit

class VSTabCell: UICollectionViewCell {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    func layout(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

   

}
