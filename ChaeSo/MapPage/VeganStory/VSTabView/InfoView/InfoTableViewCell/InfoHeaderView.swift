import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class InfoHeaderView: UITableViewHeaderFooterView {
    var disposeBag = DisposeBag()
    
    private let imageView = UIImageView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let updownButton = UIButton()
    var toggleAction: (() -> Void)?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        updownButton.rx.tap
            .bind { [weak self] in
                self?.toggleAction?()
            }
            .disposed(by: disposeBag)
        
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with model: HeaderItem) {
        updownButton.setImage(model.isExpanded ? UIImage(named: "up") : UIImage(named: "down"), for: .normal)
        firstLabel.text = model.day
        secondLabel.text = model.time
    }
    
    func layout(){
        
        [imageView,firstLabel,secondLabel,updownButton]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(13*Constants.standardWidth)
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
        }
        
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.centerY.equalTo(imageView)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.centerY.equalTo(imageView)
        }
        
        updownButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(320*Constants.standardWidth)
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
        }
        
    }
    
    func attribute(){
        
        imageView.image = UIImage(named: "clock")
        
        firstLabel.textColor = UIColor(named: "prColr")
        [firstLabel,secondLabel].forEach{ $0.font = UIFont(name: "Pretendard-Regular", size: 13) }
        
        //updownButton.setImage(UIImage(named: "down"), for: .normal)
    }

}
