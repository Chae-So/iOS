import UIKit
import Photos
import SnapKit

class MainPTCollectionVewCell: UICollectionViewCell {
    var photo: UIImageView!
    var selectionLabel: UILabel!
    var asset: PHAsset? {
        didSet {
            loadAssetImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        photo = UIImageView()
        addSubview(photo)
        photo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // 선택 라벨 초기화 및 레이아웃 설정
        
        selectionLabel = UILabel()
        selectionLabel.layer.borderWidth = 1.0
        selectionLabel.layer.borderColor = UIColor(named: "prColor")?.cgColor
        selectionLabel.layer.cornerRadius = 30*Constants.standardHeight/2  // 라벨의 반지름 (크기에 따라 조정 가능)
        selectionLabel.clipsToBounds = true
        selectionLabel.textAlignment = .center
        selectionLabel.textColor = .white
        selectionLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        addSubview(selectionLabel)
        selectionLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(5*Constants.standardWidth)  // 오른쪽 상단에 위치
            make.width.height.equalTo(30*Constants.standardHeight)  // 라벨 크기 (필요에 따라 조정 가능)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }

    private func loadAssetImage() {
        guard let asset = asset else {
            photo.image = nil
            return
        }

        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFill, options: option, resultHandler: { [weak self] (result, _) in
            self?.photo.image = result
        })
    }
    
    func updateSelection(isSelected: Bool, order: Int = 0) {
        if isSelected {
            selectionLabel.text = "\(order)"
            selectionLabel.backgroundColor = UIColor(named: "prColor")
        } else {
            selectionLabel.text = ""
            selectionLabel.backgroundColor = UIColor.clear
        }
    }
    
    func onlyOneUpdateSelection(isSelected: Bool) {
        if isSelected {
            selectionLabel.text = "1"
            selectionLabel.backgroundColor = UIColor(named: "prColor")
        } else {
            selectionLabel.text = ""
            selectionLabel.backgroundColor = UIColor.clear
        }
    }

}
