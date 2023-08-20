import UIKit
import SnapKit

class ButtonCollectionViewCell: UICollectionViewCell {
    let tabButton = UIButton()
    let titleLabel = UILabel()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attribute(){
        tabButton.isUserInteractionEnabled = false
        tabButton.adjustsImageWhenHighlighted = false
        tabButton.clipsToBounds = true
        tabButton.titleLabel?.textAlignment = .center
        tabButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14 * Constants.standardWidth)
        tabButton.setTitleColor(UIColor.black, for: .normal)
        tabButton.sizeToFit()
        tabButton.layer.cornerRadius = tabButton.frame.size.height / 2
        tabButton.layer.borderWidth = 1
        tabButton.layer.borderColor = UIColor.clear.cgColor
        tabButton.backgroundColor = UIColor.white
        tabButton.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
        
//        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
//        titleLabel.backgroundColor = .white
//        titleLabel.sizeToFit()
//        titleLabel.layer.cornerRadius = titleLabel.frame.size.height / 2
//        titleLabel.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
    }
    
    func layout(){
        contentView.addSubview(tabButton)
        tabButton.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
//        contentView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
    }
}

#if DEBUG
import SwiftUI

struct CollectionViewCellPreview: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let cell = ButtonCollectionViewCell()
        // 추가적인 셀 구성 ...
        return cell.contentView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // 셀 업데이트는 필요에 따라 구현
    }
}

@available(iOS 13.0, *)
struct CollectionViewCellPreviewProvider: PreviewProvider {
    static var previews: some View {
        CollectionViewCellPreview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))

        CollectionViewCellPreview()
            .previewLayout(.sizeThatFits)
            .frame(height: 253) // 셀의 높이를 설정
    }
}
#endif

