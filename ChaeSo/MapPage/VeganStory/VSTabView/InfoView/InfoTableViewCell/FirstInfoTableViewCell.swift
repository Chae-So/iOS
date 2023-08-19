import UIKit
import SnapKit

class FirstInfoTableViewCell: UITableViewCell {
    
    private let firstImageView = UIImageView()
    private let firstLabel = UILabel()
    private let secondImageView = UIImageView()
    private let secondLabel = UILabel()
    private let thirdImageView = UIImageView()
    private let thirdLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ItemA) {
        firstImageView.image = model.first ? UIImage(named: "checkFill") : UIImage(named: "check")
        secondImageView.image = model.second ? UIImage(named: "checkFill") : UIImage(named: "check")
        thirdImageView.image = model.third ? UIImage(named: "checkFill") : UIImage(named: "check")
    }
    
    private func bind(){
        firstLabel.text = "매장 내 식사"
        secondLabel.text = "테이크아웃"
        thirdLabel.text = "배달서비스"
    }
    
    private func attribute(){
        [firstLabel,secondLabel,thirdLabel]
            .forEach{
                $0.font = UIFont(name: "Pretendard-Medium", size: 13)
            }
        
        [firstImageView,secondImageView,thirdImageView]
            .forEach{
                $0.image = UIImage(named: "check")
                $0.contentMode = .scaleAspectFit
            }
    }
    
    private func layout(){
        [firstImageView,firstLabel,secondImageView,secondLabel,thirdImageView,thirdLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        firstImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(13*Constants.standardWidth)
            //make.top.equalToSuperview().offset(10*Constants.standardHeight)
            make.centerY.equalToSuperview()
        }
        
        secondImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(firstImageView.snp.trailing).offset(99*Constants.standardWidth)
            //make.top.equalToSuperview().offset(10*Constants.standardHeight)
            make.centerY.equalToSuperview()
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(secondImageView.snp.trailing).offset(95*Constants.standardWidth)
            //make.top.equalToSuperview().offset(10*Constants.standardHeight)
            make.centerY.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(firstImageView)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(firstImageView)
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(firstImageView)
        }
        
    }
    
}
