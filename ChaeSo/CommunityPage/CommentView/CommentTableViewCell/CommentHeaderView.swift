import UIKit
import RxSwift
import SnapKit
import Then

class CommentHeaderView: UITableViewHeaderFooterView {
    var disposeBag = DisposeBag()
    
    var userImageView = UIImageView()
    var nicknameLabel = UILabel()
    var commentLabel = UILabel()
    var writeRepliesButton = UIButton()
    var showRepliesButton = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func layout(){
        [userImageView,nicknameLabel,commentLabel,writeRepliesButton,showRepliesButton]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        userImageView.snp.makeConstraints { make in
            make.width.equalTo(32*Constants.standardHeight)
            make.height.equalTo(32*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
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
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4*Constants.standardHeight)
        }
        
        writeRepliesButton.snp.makeConstraints { make in
            //make.width.equalTo(50*Constants.standardHeight)
            //make.height.equalTo(21*Constants.standardHeight)
            make.leading.equalTo(commentLabel.snp.leading)
            make.top.equalTo(commentLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        showRepliesButton.snp.makeConstraints { make in
            //make.width.equalTo(50*Constants.standardHeight)
            //make.height.equalTo(21*Constants.standardHeight)
            make.leading.equalTo(writeRepliesButton.snp.trailing).offset(10*Constants.standardWidth)
            make.top.equalTo(commentLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        contentView.bringSubviewToFront(showRepliesButton)

        
        
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
        
        writeRepliesButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 13)
            $0.setTitleColor(UIColor(named: "gray20"), for: .normal)
        }
        
        showRepliesButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 13)
            $0.setTitleColor(UIColor(named: "gray20"), for: .normal)
            $0.isHidden = true
        }
        
        
        
    }

}
