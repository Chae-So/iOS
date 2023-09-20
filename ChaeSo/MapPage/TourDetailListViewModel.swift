import RxSwift
import RxCocoa

class TourDetailListViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let titleText = BehaviorRelay<String>(value: "")
    
    let placeList: BehaviorRelay<[Place]> = BehaviorRelay(value: [])
    let categoryType: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
   
        Observable.combineLatest(categoryType, LocalizationManager.shared.rxLanguage)
            .map { (type, _) -> String in
                switch type {
                case "a":
                    return localizationManager.localizedString(forKey: "Restaurant")
                case "b":
                    return localizationManager.localizedString(forKey: "Cafe")
                case "c":
                    return localizationManager.localizedString(forKey: "tourist attraction")
                default:
                    return ""
                }
            }
            .bind(to: titleText)
            .disposed(by: disposeBag)
        
        
        
    }
    
}
