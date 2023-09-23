import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class TourListTableViewCell: UITableViewCell {
    
    let photo = UIImageView()
    let nameLabel = UILabel()
    let categoryLabel = UILabel()
    private let bookmarkButton = UIButton()
    private let shareButton = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor(named: "sbgColor")
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
    
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 8 * Constants.standardHeight
        
        bookmarkButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

        bookmarkButton.setTitle("북마크", for: .normal)
        shareButton.setTitle("공유", for: .normal)
                
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        categoryLabel.textColor = UIColor(named: "gray20")
       

        //MARK: bookmarkButton Attribute
        bookmarkButton.adjustsImageWhenHighlighted = false
        bookmarkButton.titleLabel?.textAlignment = .center
        bookmarkButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
        bookmarkButton.setTitleColor(UIColor.black, for: .normal)
        bookmarkButton.layer.cornerRadius = 11
        bookmarkButton.layer.borderWidth = 1
        bookmarkButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        bookmarkButton.backgroundColor = UIColor.white
 
        
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
        [photo,nameLabel,categoryLabel,bookmarkButton,shareButton]
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
        
        bookmarkButton.snp.makeConstraints { make in
            //make.width.equalTo(50*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(photo.snp.trailing).offset(21*Constants.standardWidth)
            make.top.equalTo(categoryLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(39*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalTo(bookmarkButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(categoryLabel.snp.bottom).offset(15*Constants.standardHeight)
        }
        
    }

}
