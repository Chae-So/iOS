import UIKit
import SnapKit
import Then

import UIKit

class CommentTableViewCell: UITableViewCell {

    var userImageView = UIImageView()
    var nicknameLabel = UILabel()
    var commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        [userImageView,nicknameLabel,commentLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        userImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardHeight)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(53*Constants.standardWidth)
            make.top.equalToSuperview().offset(5*Constants.standardHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            //make.width.equalTo(32*Constants.standardHeight)
            //make.height.equalTo(32*Constants.standardHeight)
            make.leading.equalTo(userImageView.snp.trailing).offset(5*Constants.standardWidth)
            make.top.equalTo(userImageView.snp.top)
        }
        
        commentLabel.snp.makeConstraints { make in
            //make.width.equalTo(32*Constants.standardHeight)
            //make.height.equalTo(32*Constants.standardHeight)
            make.leading.equalTo(userImageView.snp.trailing).offset(5*Constants.standardWidth)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(3*Constants.standardHeight)
        }
        
        
        
        
    }
    
    func attribute(){
        
        userImageView.do{
            $0.layer.cornerRadius = $0.bounds.height / 2
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "gray10")?.cgColor
        }
        
        nicknameLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        }
        
        commentLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 13)
            $0.numberOfLines = 0
        }
    }
   


}
