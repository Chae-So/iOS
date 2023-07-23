import UIKit
import RxCocoa
import RxSwift

class VeganViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    let veganText = BehaviorRelay<String>(value: "")
    let lactoText = BehaviorRelay<String>(value: "")
    let ovoText = BehaviorRelay<String>(value: "")
    let polloText = BehaviorRelay<String>(value: "")
    let pescoText = BehaviorRelay<String>(value: "")
    let isFirstVisitLabelText = BehaviorRelay<String>(value: "")
    let signupButtonText = BehaviorRelay<String>(value: "")
    
    let veganButtonTapped = PublishRelay<Void>()
    let lactoButtonTapped = PublishRelay<Void>()
    let ovoButtonTapped = PublishRelay<Void>()
    let pescoButtonTapped = PublishRelay<Void>()
    let polloButtonTapped = PublishRelay<Void>()
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    var allValid: Observable<Bool> = Observable.just(false)
    var selectedVegan = PublishRelay<Bool>()
    var selectedLacto = PublishRelay<Bool>()
    var selectedOvo = PublishRelay<Bool>()
    var selectedPesco = PublishRelay<Bool>()
    var selectedPollo = PublishRelay<Bool>()
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        veganButtonTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.selectedVegan.accept(true)
                self.selectedLacto.accept(false)
                self.selectedOvo.accept(false)
                self.selectedPesco.accept(false)
                self.selectedPollo.accept(false)
            })
            .disposed(by: disposeBag)
                
        lactoButtonTapped
            .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.selectedVegan.accept(false)
                    self.selectedLacto.accept(true)
                    self.selectedOvo.accept(false)
                    self.selectedPesco.accept(false)
                    self.selectedPollo.accept(false)
            })
            .disposed(by: disposeBag)
        
        ovoButtonTapped
            .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.selectedVegan.accept(false)
                    self.selectedLacto.accept(false)
                    self.selectedOvo.accept(true)
                    self.selectedPesco.accept(false)
                    self.selectedPollo.accept(false)
            })
            .disposed(by: disposeBag)
        
        pescoButtonTapped
            .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.selectedVegan.accept(false)
                    self.selectedLacto.accept(false)
                    self.selectedOvo.accept(false)
                    self.selectedPesco.accept(true)
                    self.selectedPollo.accept(false)
            })
            .disposed(by: disposeBag)
        
        polloButtonTapped
            .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.selectedVegan.accept(false)
                    self.selectedLacto.accept(false)
                    self.selectedOvo.accept(false)
                    self.selectedPesco.accept(false)
                    self.selectedPollo.accept(true)
            })
            .disposed(by: disposeBag)
        
        allValid = Observable.combineLatest(selectedVegan.asObservable(), selectedLacto.asObservable(), selectedOvo.asObservable(), selectedPesco.asObservable(), selectedPollo.asObservable())
            .map{ $0 || $1 || $2 || $3 || $4}
        
        
    }
    
    private func updateLocalization() {
        veganText.accept(localizationManager.localizedString(forKey: "Vegan"))
        lactoText.accept(localizationManager.localizedString(forKey: "Lacto"))
        ovoText.accept(localizationManager.localizedString(forKey: "Ovo"))
        polloText.accept(localizationManager.localizedString(forKey: "Pollo"))
        pescoText.accept(localizationManager.localizedString(forKey: "Pesco"))

    }
}


