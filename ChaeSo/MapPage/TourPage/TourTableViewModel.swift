import RxSwift
import RxCocoa

class TourTableViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let infoText = BehaviorRelay<String>(value: "")
    let parkingText = BehaviorRelay<String>(value: "")
    let toiletText = BehaviorRelay<String>(value: "")


    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
    }
    
    private func updateLocalization() {
        infoText.accept(localizationManager.localizedString(forKey: "Info"))
        parkingText.accept(localizationManager.localizedString(forKey: "parking"))
        toiletText.accept(localizationManager.localizedString(forKey: "toilet"))
    }

}
