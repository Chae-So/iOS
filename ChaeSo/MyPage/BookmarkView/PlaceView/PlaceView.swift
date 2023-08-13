import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PlaceView: UIView {
    let disposeBag = DisposeBag()
    let placeViewModel: PlaceViewModel
    
    private lazy var restaurantButton = UIButton()
    private lazy var cafeButton = UIButton()
    private lazy var storeButton = UIButton()
    private lazy var separateView = UIView()
    private let contentTableView = UITableView()
    
    init(placeViewModel: PlaceViewModel) {
        self.placeViewModel = placeViewModel
        super.init(frame: .zero)
        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        placeViewModel.restaurantText
            .asDriver(onErrorDriveWith: .empty())
            .drive(restaurantButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        placeViewModel.cafeText
            .asDriver(onErrorDriveWith: .empty())
            .drive(cafeButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        placeViewModel.storeText
            .asDriver(onErrorDriveWith: .empty())
            .drive(storeButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
                
        restaurantButton.rx.tap
            .bind(to: placeViewModel.restaurantButtonTapped)
            .disposed(by: disposeBag)
        
        placeViewModel.selectedRestaurant
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor(named: "gray10")?.cgColor }
            .drive(restaurantButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        cafeButton.rx.tap
            .bind(to: placeViewModel.restaurantButtonTapped)
            .disposed(by: disposeBag)
        
        placeViewModel.selectedCafe
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor(named: "gray10")?.cgColor }
            .drive(restaurantButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        storeButton.rx.tap
            .bind(to: placeViewModel.restaurantButtonTapped)
            .disposed(by: disposeBag)
        
        placeViewModel.selectedStore
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor(named: "gray10")?.cgColor }
            .drive(restaurantButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        placeViewModel.items
            .asDriver(onErrorDriveWith: .empty())
            .drive(contentTableView.rx.items(cellIdentifier: "ContentTableViewCell", cellType: ListTableViewCell.self)){ (row,element,cell) in
                cell.photo.image = element.photo
                cell.nameLabel.text = element.nameLabel
                cell.categoryLabel.text = element.categoryLabel
                cell.distanceLabel.text = element.distanceLabel
                cell.onOffLabel.text = element.onOffLabel
                cell.timeLabel.text = element.timeLabel
                cell.pointLabel.text = element.pointLabel
                
            }
            .disposed(by: disposeBag)
        
    }
    
    private func attribute(){
        //MARK: restaurantButton attribute
        restaurantButton.adjustsImageWhenHighlighted = false
        restaurantButton.titleLabel?.textAlignment = .center
        restaurantButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        restaurantButton.setTitleColor(UIColor.black, for: .normal)
        restaurantButton.layer.cornerRadius = 15
        restaurantButton.layer.borderWidth = 1
        restaurantButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        restaurantButton.backgroundColor = UIColor.white
        
        //MARK: cafeButton attribute
        cafeButton.adjustsImageWhenHighlighted = false
        cafeButton.titleLabel?.textAlignment = .center
        cafeButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        cafeButton.setTitleColor(UIColor.black, for: .normal)
        cafeButton.layer.cornerRadius = 15
        cafeButton.layer.borderWidth = 1
        cafeButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        cafeButton.backgroundColor = UIColor.white
        
        //MARK: storeButton attribute
        storeButton.adjustsImageWhenHighlighted = false
        storeButton.titleLabel?.textAlignment = .center
        storeButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        storeButton.setTitleColor(UIColor.black, for: .normal)
        storeButton.layer.cornerRadius = 15
        storeButton.layer.borderWidth = 1
        storeButton.layer.borderColor = UIColor(named: "gray10")?.cgColor
        storeButton.backgroundColor = UIColor.white
        
        //MARK: separateView Attribute
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")
        
        //MARK: contentTableView Attribute
        contentTableView.separatorStyle = .singleLine
        contentTableView.separatorInset = UIEdgeInsets(top: 0, left: 8*Constants.standardWidth, bottom: 0, right: 24*Constants.standardWidth)
        contentTableView.separatorColor = UIColor(hexCode: "D9D9D9")
        contentTableView.rowHeight = 150*Constants.standardHeight
        contentTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ContentTableViewCell")
    }
    
    private func layout(){
        [restaurantButton,cafeButton,storeButton,separateView,contentTableView]
            .forEach { UIView in
                addSubview(UIView)
            }
        
        restaurantButton.snp.makeConstraints { make in
            make.width.equalTo(69*Constants.standardWidth)
            make.height.equalTo(33*Constants.standardHeight)
            make.leading.equalToSuperview().offset(22*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        cafeButton.snp.makeConstraints { make in
            make.width.equalTo(57*Constants.standardWidth)
            make.height.equalTo(33*Constants.standardHeight)
            make.leading.equalTo(restaurantButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        storeButton.snp.makeConstraints { make in
            make.width.equalTo(69*Constants.standardWidth)
            make.height.equalTo(33*Constants.standardHeight)
            make.leading.equalTo(cafeButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        separateView.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(2*Constants.standardHeight)
            make.leading.equalToSuperview().offset(8*Constants.standardWidth)
            make.trailing.equalToSuperview().offset(-24*Constants.standardWidth)
            make.top.equalTo(restaurantButton.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        contentTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom)
        }
        
    }

    
}
