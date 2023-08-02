import UIKit
import SnapKit

class ContentTableViewCell: UITableViewCell {
    
    let photo = UIImageView()
    let nameLabel = UILabel()
    let categoryLabel = UILabel()
    private let firstSepaLabel = UILabel()
    let distanceLabel = UILabel()
    let onOffLabel = UILabel()
    private let secondSepaLabel = UILabel()
    let timeLabel = UILabel()
    private let starImageView = UIImageView()
    let pointLabel = UILabel()
    private let bookmarkButton = UIButton()
    private let menuButton = UIButton()
    private let shareButton = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        
        photo.layer.cornerRadius = 8
        firstSepaLabel.text = "|"
        secondSepaLabel.text = "|"
        
        bookmarkButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

        bookmarkButton.setTitle("북마크", for: .normal)
        menuButton.setTitle("메뉴", for: .normal)
        shareButton.setTitle("공유", for: .normal)
        
        photo.backgroundColor = .black
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        categoryLabel.textColor = UIColor(hexCode: "757575")
        
        firstSepaLabel.textAlignment = .center
        firstSepaLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        firstSepaLabel.textColor = UIColor(hexCode: "757575")
        
        distanceLabel.textAlignment = .center
        distanceLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        distanceLabel.textColor = UIColor(hexCode: "757575")
        
        onOffLabel.textAlignment = .center
        onOffLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        onOffLabel.textColor = UIColor(named: "gray20")
        
        secondSepaLabel.textAlignment = .center
        secondSepaLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        secondSepaLabel.textColor = UIColor(named: "gray20")
        
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        timeLabel.textColor = UIColor(named: "gray20")
        
        pointLabel.textAlignment = .center
        pointLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        pointLabel.textColor = UIColor(named: "gray20")
        
        starImageView.image = UIImage(named: "starFill")
        
        //MARK: bookmarkButton Attribute
        bookmarkButton.adjustsImageWhenHighlighted = false
        bookmarkButton.titleLabel?.textAlignment = .center
        bookmarkButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        bookmarkButton.setTitleColor(UIColor.black, for: .normal)
        bookmarkButton.layer.cornerRadius = 11
        bookmarkButton.layer.borderWidth = 1
        bookmarkButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        bookmarkButton.backgroundColor = UIColor.white
        
        //MARK: menuButton Attribute
        menuButton.adjustsImageWhenHighlighted = false
        menuButton.titleLabel?.textAlignment = .center
        menuButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        menuButton.setTitleColor(UIColor.black, for: .normal)
        menuButton.layer.cornerRadius = 11
        menuButton.layer.borderWidth = 1
        menuButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        menuButton.backgroundColor = UIColor.white
        
        //MARK: shareButton Attribute
        shareButton.adjustsImageWhenHighlighted = false
        shareButton.titleLabel?.textAlignment = .center
        shareButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        shareButton.setTitleColor(UIColor.black, for: .normal)
        shareButton.layer.cornerRadius = 11
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        shareButton.backgroundColor = UIColor.white
        
        
    }
    
    private func layout(){
        [photo,nameLabel,categoryLabel,firstSepaLabel,distanceLabel,onOffLabel,secondSepaLabel,timeLabel,starImageView,pointLabel,bookmarkButton,menuButton,shareButton]
            .forEach { UIView in
                addSubview(UIView)
            }
        
        photo.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(100*Constants.standardHeight)
            make.leading.equalToSuperview().offset(20*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        nameLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalTo(photo.snp.trailing).offset(21*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        categoryLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(photo.snp.trailing).offset(21*Constants.standardWidth)
            make.top.equalTo(nameLabel.snp.bottom).offset(2*Constants.standardHeight)
        }
        
        firstSepaLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(nameLabel.snp.bottom).offset(2*Constants.standardHeight)
        }
        
        distanceLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(firstSepaLabel.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(nameLabel.snp.bottom).offset(2*Constants.standardHeight)
        }
        
        onOffLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(photo.snp.trailing).offset(21*Constants.standardWidth)
            make.top.equalTo(categoryLabel.snp.bottom).offset(4*Constants.standardHeight)
        }
        
        secondSepaLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(onOffLabel.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(categoryLabel.snp.bottom).offset(4*Constants.standardHeight)
        }
        
        timeLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(secondSepaLabel.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(categoryLabel.snp.bottom).offset(4*Constants.standardHeight)
        }
        
        starImageView.snp.makeConstraints { make in
            make.width.equalTo(13*Constants.standardWidth)
            make.height.equalTo(13*Constants.standardHeight)
            make.leading.equalTo(photo.snp.trailing).offset(21*Constants.standardWidth)
            make.top.equalTo(onOffLabel.snp.bottom).offset(7*Constants.standardHeight)
        }
        
        pointLabel.snp.makeConstraints { make in
            //make.width.equalTo(14*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(starImageView.snp.trailing).offset(4*Constants.standardWidth)
            make.top.equalTo(onOffLabel.snp.bottom).offset(7*Constants.standardHeight)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            //make.width.equalTo(50*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(photo.snp.trailing).offset(21*Constants.standardWidth)
            make.top.equalTo(pointLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        menuButton.snp.makeConstraints { make in
            make.width.equalTo(39*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(bookmarkButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(pointLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(39*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(menuButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(pointLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
    }

}
