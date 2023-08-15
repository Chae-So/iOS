import RxSwift
import RxCocoa

class SortTableViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let firstItems = BehaviorRelay<[String]>(value: [])
    let secondItems = BehaviorRelay<[String]>(value: [])
    
    let firstSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    let secondSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    
    
    let aloneText = BehaviorRelay<String>(value: "")
    let friendText = BehaviorRelay<String>(value: "")
    let familyText = BehaviorRelay<String>(value: "")
    let veganText = BehaviorRelay<String>(value: "")
    let lactoText = BehaviorRelay<String>(value: "")
    let ovoText = BehaviorRelay<String>(value: "")
    let polloText = BehaviorRelay<String>(value: "")
    let pescoText = BehaviorRelay<String>(value: "")
    let flexitarianText = BehaviorRelay<String>(value: "")
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(aloneText, friendText, familyText)
            .subscribe(onNext: { [weak self] a, b, c in
                self?.firstItems.accept([a, b, c])
                print(123123123)
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(veganText, lactoText, ovoText, pescoText, polloText, flexitarianText)
            .subscribe(onNext: { [weak self] a, b, c, d, e, f in
                self?.secondItems.accept([a, b, c, d, e, f])
            })
            .disposed(by: disposeBag)

        
    }
    
    private func updateLocalization() {

        aloneText.accept(localizationManager.localizedString(forKey: "Alone"))
        friendText.accept(localizationManager.localizedString(forKey: "With Friend"))
        familyText.accept(localizationManager.localizedString(forKey: "With Family"))
        veganText.accept(localizationManager.localizedString(forKey: "Vegan"))
        lactoText.accept(localizationManager.localizedString(forKey: "Lacto"))
        ovoText.accept(localizationManager.localizedString(forKey: "Ovo"))
        polloText.accept(localizationManager.localizedString(forKey: "Pesco"))
        pescoText.accept(localizationManager.localizedString(forKey: "Pollo"))
        flexitarianText.accept(localizationManager.localizedString(forKey: "Flexitarian"))
        
    }
    
}
