import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PlaceView: UIView {
    let disposeBag = DisposeBag()
    let placeViewModel: PlaceViewModel
    
    private lazy var restaurantButton = UIButton()
    private lazy var caffeButton = UIButton()
    private lazy var storeButton = UIButton()
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
        
        placeViewModel.caffeText
            .asDriver(onErrorDriveWith: .empty())
            .drive(caffeButton.rx.title(for: .normal))
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
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(restaurantButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        caffeButton.rx.tap
            .bind(to: placeViewModel.restaurantButtonTapped)
            .disposed(by: disposeBag)
        
        placeViewModel.selectedCaffe
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(restaurantButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        storeButton.rx.tap
            .bind(to: placeViewModel.restaurantButtonTapped)
            .disposed(by: disposeBag)
        
        placeViewModel.selectedStore
            .asDriver(onErrorDriveWith: .empty())
            .map{ $0 ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor }
            .drive(restaurantButton.rx.borderColor)
            .disposed(by: disposeBag)
        
        
        
    }
    
    private func attribute(){
        //MARK: restaurantButton attribute
        restaurantButton.adjustsImageWhenHighlighted = false
        restaurantButton.titleLabel?.textAlignment = .center
        restaurantButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        restaurantButton.setTitleColor(UIColor.black, for: .normal)
        restaurantButton.layer.cornerRadius = 30
        restaurantButton.layer.borderWidth = 1
        restaurantButton.layer.borderColor = UIColor.clear.cgColor
        restaurantButton.backgroundColor = UIColor.white
        
        //MARK: caffeButton attribute
        caffeButton.adjustsImageWhenHighlighted = false
        caffeButton.titleLabel?.textAlignment = .center
        caffeButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        caffeButton.setTitleColor(UIColor.black, for: .normal)
        caffeButton.layer.cornerRadius = 30
        caffeButton.layer.borderWidth = 1
        caffeButton.layer.borderColor = UIColor.clear.cgColor
        caffeButton.backgroundColor = UIColor.white
        
        //MARK: storeButton attribute
        storeButton.adjustsImageWhenHighlighted = false
        storeButton.titleLabel?.textAlignment = .center
        storeButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        storeButton.setTitleColor(UIColor.black, for: .normal)
        storeButton.layer.cornerRadius = 30
        storeButton.layer.borderWidth = 1
        storeButton.layer.borderColor = UIColor.clear.cgColor
        storeButton.backgroundColor = UIColor.white
    }
    
    private func layout(){
        [restaurantButton,caffeButton,storeButton,contentTableView]
            .forEach { UIView in
                addSubview(UIView)
            }
        
        restaurantButton.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            make.height.equalTo(33*Constants.standardHeight)
            make.leading.equalToSuperview().offset(22*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        caffeButton.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            make.height.equalTo(33*Constants.standardHeight)
            make.leading.equalTo(restaurantButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        storeButton.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            make.height.equalTo(33*Constants.standardHeight)
            make.leading.equalTo(caffeButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        contentTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(restaurantButton.snp.bottom).offset(16*Constants.standardHeight)
        }
        
    }

    
}
