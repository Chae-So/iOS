import RxSwift
import RxCocoa

class TermsViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let termsText = BehaviorRelay(value: "")
    let firstText = BehaviorRelay(value: "")
    let secondText = BehaviorRelay(value: "")
    let ppText = BehaviorRelay(value: "")
    let ltText = BehaviorRelay(value: "")
    
    let tabItems = BehaviorRelay<[String]>(value: [])

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        termsText.accept(localizationManager.localizedString(forKey: "terms of service"))
        firstText.accept(localizationManager.localizedString(forKey: "privacy policy"))
        secondText.accept(localizationManager.localizedString(forKey: "Location-based service terms and conditions"))
        ppText.accept(localizationManager.localizedString(forKey: "pp"))
        ltText.accept(localizationManager.localizedString(forKey: "lt"))
        
        Observable.combineLatest(firstText,secondText)
            .subscribe(onNext: { [weak self] a, b in
                self?.tabItems.accept([a,b])
            })
            .disposed(by: disposeBag)

    }

}
