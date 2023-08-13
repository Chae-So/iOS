import UIKit
import RxCocoa
import RxSwift

class WriteChaesoLogViewModel: PhotoViewModelProtocol{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    let showMainPTCollection = PublishSubject<Void>()
    
    // Input
    
    var firstText: String {
        return localizationManager.localizedString(forKey: "카테고리를 선택해 주세요")
    }
    var secondText: String {
        return localizationManager.localizedString(forKey: "채식타입을 선택해 주새요")
    }
    
    
    let restaurantText = BehaviorRelay<String>(value: "")
    let cafeText = BehaviorRelay<String>(value: "")
    let storeText = BehaviorRelay<String>(value: "")
    let veganText = BehaviorRelay<String>(value: "")
    let lactoText = BehaviorRelay<String>(value: "")
    let ovoText = BehaviorRelay<String>(value: "")
    let polloText = BehaviorRelay<String>(value: "")
    let pescoText = BehaviorRelay<String>(value: "")
    let flexitarianText = BehaviorRelay<String>(value: "")
    let textViewPlaceholder = BehaviorRelay<String>(value: "")
    let aloneButtonTapped = PublishRelay<Void>()
   
    
    let firstItems = BehaviorRelay<[String]>(value: [])
    let secondItems = BehaviorRelay<[String]>(value: [])

    let firstSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    let secondSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    
    // Output
    var allValid: Observable<Bool> = Observable.just(false)
    var selectedVegan = PublishRelay<Bool>()
    var selectedLacto = PublishRelay<Bool>()
    var selectedOvo = PublishRelay<Bool>()
    var selectedPesco = PublishRelay<Bool>()
    var selectedPollo = PublishRelay<Bool>()
        
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(restaurantText, cafeText,storeText)
            .subscribe(onNext: { [weak self] rest, cafe, store in
                self?.firstItems.accept([rest, cafe, store])
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(veganText, lactoText, ovoText, polloText, pescoText, flexitarianText)
            .subscribe(onNext: { [weak self] a, b, c, d, e, f in
                self?.secondItems.accept([a, b, c, d, e, f])
            })
            .disposed(by: disposeBag)
        
    }
    
    private func updateLocalization() {
        restaurantText.accept(localizationManager.localizedString(forKey: "Restaurant"))
        cafeText.accept(localizationManager.localizedString(forKey: "Cafe"))
        storeText.accept(localizationManager.localizedString(forKey: "Store"))
        veganText.accept(localizationManager.localizedString(forKey: "Vegan"))
        lactoText.accept(localizationManager.localizedString(forKey: "Lacto"))
        ovoText.accept(localizationManager.localizedString(forKey: "Ovo"))
        polloText.accept(localizationManager.localizedString(forKey: "Pollo"))
        pescoText.accept(localizationManager.localizedString(forKey: "Pesco"))
        flexitarianText.accept(localizationManager.localizedString(forKey: "Flexitarian"))
        textViewPlaceholder.accept(localizationManager.localizedString(forKey: "나누고 싶은 이야기를 공유해 주세요"))
    }
}


