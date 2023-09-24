import UIKit
import SnapKit

class MyPageTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "D9D9D9")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        addSubview(titleLabel)
        addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 14*Constants.standartFont)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20*Constants.standardWidth)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSeparator() {
        separatorView.isHidden = false
    }
    
    func hideSeparator() {
        separatorView.isHidden = true
    }
    
}
