import UIKit
import SnapKit

class SecondInfoTableViewCell: UITableViewCell {
    
    private let firstImageView = UIImageView()
    private let firstLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        firstImageView.contentMode = .scaleAspectFit
        firstLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        
        [firstImageView,firstLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        firstImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(13*Constants.standardWidth)
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(firstImageView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ItemB) {
        if(model.image == UIImage(named: "phone")){
            firstImageView.snp.updateConstraints{ make in
                make.width.equalTo(18*Constants.standardWidth)
                make.height.equalTo(18*Constants.standardHeight)
                make.leading.equalToSuperview().offset(17*Constants.standardWidth)
                make.top.equalToSuperview().offset(14*Constants.standardHeight)
                
            }
        }
        firstImageView.image = model.image
        firstLabel.text = model.text
        
    }
    
}
