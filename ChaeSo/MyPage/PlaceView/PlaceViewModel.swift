import UIKit
import RxCocoa
import RxSwift

class PlaceViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let restaurantText = BehaviorRelay<String>(value: "")
    let caffeText = BehaviorRelay<String>(value: "")
    let storeText = BehaviorRelay<String>(value: "")
    
    let restaurantButtonTapped = PublishRelay<Void>()
    let caffeButtonTapped = PublishRelay<Void>()
    let storeButtonTapped = PublishRelay<Void>()
    
    var selectedRestaurant = PublishRelay<Bool>()
    var selectedCaffe = PublishRelay<Bool>()
    var selectedStore = PublishRelay<Bool>()
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        restaurantButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedRestaurant.accept(true)
                self.selectedCaffe.accept(false)
                self.selectedStore.accept(false)
            })
            .disposed(by: disposeBag)
        
        caffeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedRestaurant.accept(false)
                self.selectedCaffe.accept(true)
                self.selectedStore.accept(false)
            })
            .disposed(by: disposeBag)
        
        storeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedRestaurant.accept(false)
                self.selectedCaffe.accept(false)
                self.selectedStore.accept(true)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func updateLocalization() {
        restaurantText.accept(localizationManager.localizedString(forKey: "Restaurant"))
        caffeText.accept(localizationManager.localizedString(forKey: "Caffe"))
        storeText.accept(localizationManager.localizedString(forKey: "Store"))
    }
    
}
