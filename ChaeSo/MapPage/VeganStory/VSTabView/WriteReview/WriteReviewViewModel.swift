import UIKit
import RxCocoa
import RxSwift

protocol PhotoViewModelProtocol {
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> { get set }
}

class WriteReviewViewModel: PhotoViewModelProtocol{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let selectedStar: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    
    let firstItems = BehaviorRelay<[String]>(value: [])
    let secondItems = BehaviorRelay<[String]>(value: [])
    let thirdItems = BehaviorRelay<[String]>(value: [])
    
    let firstSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    let secondSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    let thirdSelectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    
    // Input
    var titleText: String {
        return localizationManager.localizedString(forKey: "Write a review")
    }
    var firstText: String {
        return localizationManager.localizedString(forKey: "How was the place you visited?")
    }
    var secondText: String {
        return localizationManager.localizedString(forKey: "Did you have a group?")
    }
    var thirdText: String {
        return localizationManager.localizedString(forKey: "What is the vegetarian type of the group?")
    }
    var fourthText: String {
        return localizationManager.localizedString(forKey: "Was there any non-vegan food?")
    }
    var placeholderText: String {
        return localizationManager.localizedString(forKey: "Please share details of your visit experience.")
    }
    
    let aloneText = BehaviorRelay<String>(value: "")
    let friendText = BehaviorRelay<String>(value: "")
    let familyText = BehaviorRelay<String>(value: "")
    let veganText = BehaviorRelay<String>(value: "")
    let lactoText = BehaviorRelay<String>(value: "")
    let ovoText = BehaviorRelay<String>(value: "")
    let polloText = BehaviorRelay<String>(value: "")
    let pescoText = BehaviorRelay<String>(value: "")
    let flexitarianText = BehaviorRelay<String>(value: "")
    let nonVeganText = BehaviorRelay<String>(value: "")
    let yesText = BehaviorRelay<String>(value: "")
    let noText = BehaviorRelay<String>(value: "")
    var registerText: String {
        return localizationManager.localizedString(forKey: "Register")
    }
    
    let aloneButtonTapped = PublishRelay<Void>()
    
    let veganButtonTapped = PublishRelay<Void>()
    let lactoButtonTapped = PublishRelay<Void>()
    let ovoButtonTapped = PublishRelay<Void>()
    let pescoButtonTapped = PublishRelay<Void>()
    let polloButtonTapped = PublishRelay<Void>()
    
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
        
        Observable.combineLatest(aloneText, friendText, familyText)
            .subscribe(onNext: { [weak self] a, b, c in
                self?.firstItems.accept([a, b, c])
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(veganText, lactoText, ovoText, pescoText, polloText, flexitarianText, nonVeganText)
            .subscribe(onNext: { [weak self] a, b, c, d, e, f, g in
                self?.secondItems.accept([a, b, c, d, e, f, g])
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
        nonVeganText.accept(localizationManager.localizedString(forKey: "Non-Vegan"))
        
    }
    
    func didSelectStar(at index: Int) {
        selectedStar.accept(index + 1)
    }
    
}


