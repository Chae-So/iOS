import UIKit
import RxCocoa
import RxSwift

class PlaceViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let restaurantText = BehaviorRelay<String>(value: "")
    let cafeText = BehaviorRelay<String>(value: "")
    let storeText = BehaviorRelay<String>(value: "")
    
    let restaurantButtonTapped = PublishRelay<Void>()
    let cafeButtonTapped = PublishRelay<Void>()
    let storeButtonTapped = PublishRelay<Void>()
    
    var selectedRestaurant = PublishRelay<Bool>()
    var selectedCafe = PublishRelay<Bool>()
    var selectedStore = PublishRelay<Bool>()
    
    let items = Observable<[ContentTableViewCellModel]>.just([
        
        ContentTableViewCellModel(photo: UIImage(named: "tomato"), nameLabel: "비건스토리", categoryLabel: "음식점", distanceLabel: "2.9km", onOffLabel: "영업중", timeLabel: "오후 10시에 영업종료", pointLabel: "4.3 / 5"),
        ContentTableViewCellModel(photo: UIImage(named: "tomato"), nameLabel: "비건스토리", categoryLabel: "음식점", distanceLabel: "2.9km", onOffLabel: "영업중", timeLabel: "오후 10시에 영업종료", pointLabel: "4.3 / 5"),
        ContentTableViewCellModel(photo: UIImage(named: "tomato"), nameLabel: "비건스토리", categoryLabel: "음식점", distanceLabel: "2.9km", onOffLabel: "영업중", timeLabel: "오후 10시에 영업종료", pointLabel: "4.3 / 5"),
        ContentTableViewCellModel(photo: UIImage(named: "tomato"), nameLabel: "비건스토리", categoryLabel: "음식점", distanceLabel: "2.9km", onOffLabel: "영업중", timeLabel: "오후 10시에 영업종료", pointLabel: "4.3 / 5"),
        ContentTableViewCellModel(photo: UIImage(named: "tomato"), nameLabel: "비건스토리", categoryLabel: "음식점", distanceLabel: "2.9km", onOffLabel: "영업중", timeLabel: "오후 10시에 영업종료", pointLabel: "4.3 / 5"),
        ContentTableViewCellModel(photo: UIImage(named: "tomato"), nameLabel: "비건스토리", categoryLabel: "음식점", distanceLabel: "2.9km", onOffLabel: "영업중", timeLabel: "오후 10시에 영업종료", pointLabel: "4.3 / 5")
    ])
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        restaurantButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                print("음식점 눌림")
                self.selectedRestaurant.accept(true)
                self.selectedCafe.accept(false)
                self.selectedStore.accept(false)
            })
            .disposed(by: disposeBag)
        
        cafeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedRestaurant.accept(false)
                self.selectedCafe.accept(true)
                self.selectedStore.accept(false)
            })
            .disposed(by: disposeBag)
        
        storeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedRestaurant.accept(false)
                self.selectedCafe.accept(false)
                self.selectedStore.accept(true)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func updateLocalization() {
        restaurantText.accept(localizationManager.localizedString(forKey: "Restaurant"))
        cafeText.accept(localizationManager.localizedString(forKey: "Cafe"))
        storeText.accept(localizationManager.localizedString(forKey: "Store"))
    }
    
}
