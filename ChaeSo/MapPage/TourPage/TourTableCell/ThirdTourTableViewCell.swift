import UIKit
import SnapKit

class ThirdTourTableViewCell: UITableViewCell {
    
    private let contentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont(name: "Pretendard-Regular", size: 16*Constants.standartFont)
        
        
        contentView.addSubview(contentLabel)
        
        
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-15*Constants.standardHeight)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(content: String) {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.41 * Constants.standardHeight
        contentLabel.attributedText = NSMutableAttributedString(string: content, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
}
