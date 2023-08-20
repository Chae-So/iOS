import UIKit
import SnapKit

class MenuTableViewCell: UITableViewCell {
    
    private let menuImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        menuImageView.layer.cornerRadius = 8 * Constants.standardHeight
        nameLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        priceLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        priceLabel.textColor = UIColor(named: "prColr")
        
        [menuImageView,nameLabel,priceLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        menuImageView.snp.makeConstraints { make in
            make.width.equalTo(60*Constants.standardWidth)
            make.height.equalTo(60*Constants.standardHeight)
            make.leading.equalToSuperview().offset(24*Constants.standardWidth)
            make.top.equalToSuperview().offset(8*Constants.standardHeight)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(menuImageView.snp.trailing).offset(17*Constants.standardWidth)
            make.top.equalToSuperview().offset(17*Constants.standardHeight)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(menuImageView.snp.trailing).offset(17*Constants.standardWidth)
            make.top.equalTo(nameLabel.snp.bottom).offset(6*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-17*Constants.standardHeight)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Menu) {
        menuImageView.image = model.menuImage
        nameLabel.text = model.menuName
        priceLabel.text = model.menuPrice
        
    }
    
}
