import UIKit
import RxCocoa
import RxSwift

protocol PhotoViewModelProtocol {
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> { get set }
}

class WriteReviewViewModel: PhotoViewModelProtocol{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    
    // Input
    var titleText: String {
        return localizationManager.localizedString(forKey: "Write a review")
    }
    let firstText = BehaviorRelay<String>(value: "")
    let secondText = BehaviorRelay<String>(value: "")
    let thirdText = BehaviorRelay<String>(value: "")
    let fourthText = BehaviorRelay<String>(value: "")
    let addText = BehaviorRelay<String>(value: "")
    let placeholderText = BehaviorRelay<String>(value: "")
    
    let aloneText = BehaviorRelay<String>(value: "")
    let friendText = BehaviorRelay<String>(value: "")
    let familyText = BehaviorRelay<String>(value: "")
    let veganText = BehaviorRelay<String>(value: "")
    let lactoText = BehaviorRelay<String>(value: "")
    let ovoText = BehaviorRelay<String>(value: "")
    let polloText = BehaviorRelay<String>(value: "")
    let pescoText = BehaviorRelay<String>(value: "")
    let flexitarian = BehaviorRelay<String>(value: "")
    let nonVeganText = BehaviorRelay<String>(value: "")
    let yesText = BehaviorRelay<String>(value: "")
    let noText = BehaviorRelay<String>(value: "")
    let registerText = BehaviorRelay<String>(value: "")
    
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
        
        
        
        
        
    }
    
    private func updateLocalization() {
        firstText.accept(localizationManager.localizedString(forKey: "How was the place you visited?"))
        secondText.accept(localizationManager.localizedString(forKey: "Did you have a group?"))
        thirdText.accept(localizationManager.localizedString(forKey: "What is the vegetarian type of the group?"))
        fourthText.accept(localizationManager.localizedString(forKey: "Was there any non-vegan food?"))

        addText.accept(localizationManager.localizedString(forKey: "Add"))
        placeholderText.accept(localizationManager.localizedString(forKey: "Please share details of your visit experience."))
        aloneText.accept(localizationManager.localizedString(forKey: "Alone"))
        friendText.accept(localizationManager.localizedString(forKey: "With Friend"))
        familyText.accept(localizationManager.localizedString(forKey: "With Family"))
        veganText.accept(localizationManager.localizedString(forKey: "Vegan"))
        lactoText.accept(localizationManager.localizedString(forKey: "Lacto"))
        ovoText.accept(localizationManager.localizedString(forKey: "Ovo"))
        polloText.accept(localizationManager.localizedString(forKey: "Pesco"))
        pescoText.accept(localizationManager.localizedString(forKey: "Pollo"))
        flexitarian.accept(localizationManager.localizedString(forKey: "Flexitarian"))
        nonVeganText.accept(localizationManager.localizedString(forKey: "Non-Vegan"))
        yesText.accept(localizationManager.localizedString(forKey: "Yes"))
        nonVeganText.accept(localizationManager.localizedString(forKey: "No"))
        registerText.accept(localizationManager.localizedString(forKey: "Register"))
    }
}


