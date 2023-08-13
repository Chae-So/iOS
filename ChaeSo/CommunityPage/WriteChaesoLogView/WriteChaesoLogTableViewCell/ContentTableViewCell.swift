import UIKit
import SnapKit

class ContentTableViewCell: UITableViewCell {
    
    private let textView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.height.equalTo(150*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
            make.trailing.equalToSuperview().offset(-24*Constants.standardWidth)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
