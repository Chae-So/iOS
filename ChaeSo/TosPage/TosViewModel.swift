import UIKit
import RxCocoa
import RxSwift

class TosViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    
    //MARK: - Input
    let firstLabelText = BehaviorRelay<String>(value: "")
    let secondLabelText = BehaviorRelay<String>(value: "")
    let allSelectLabelText = BehaviorRelay<String>(value: "")
    let serviceTosLabelText = BehaviorRelay<String>(value: "")
    let infoTosLabelText = BehaviorRelay<String>(value: "")
    
    let allSelectButtonTapped = PublishRelay<Void>()
    let serviceTosButtonTapped = PublishRelay<Void>()
    let infoTosButtonTapped = PublishRelay<Void>()
    
    // MARK: - Output
    var toggleAll = BehaviorRelay<Bool>(value: false)
    var toggleService = BehaviorRelay<Bool>(value: false)
    var toggleInfo = BehaviorRelay<Bool>(value: false)
    
    var allCheck = Observable<Bool>.just(false)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        firstLabelText.accept(localizationManager.localizedString(forKey: "Nice to meet you"))
        secondLabelText.accept(localizationManager.localizedString(forKey: "Please accept the ToS for using the service"))
        
        allSelectLabelText.accept(localizationManager.localizedString(forKey: "To select all"))
        serviceTosLabelText.accept(localizationManager.localizedString(forKey: "Agree to use the service (required)"))
        infoTosLabelText.accept(localizationManager.localizedString(forKey: "Agree with privacy policy (required)"))
        
        allSelectButtonTapped.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if(!self.toggleAll.value){
                self.toggleAll.accept(true)
                if(!self.toggleService.value){
                    self.toggleService.accept(true)
                }
                if(!self.toggleInfo.value){
                    self.toggleInfo.accept(true)
                }
            }
            else{
                self.toggleAll.accept(false)
                self.toggleService.accept(false)
                self.toggleInfo.accept(false)
            }
        }).disposed(by: disposeBag)
        
        
        serviceTosButtonTapped.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.toggleService.accept(!self.toggleService.value)
            if(self.toggleService.value && self.toggleInfo.value){
                self.toggleAll.accept(true)
            }
        }).disposed(by: disposeBag)
        
        infoTosButtonTapped.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.toggleInfo.accept(!self.toggleInfo.value)
            if(self.toggleService.value && self.toggleInfo.value){
                self.toggleAll.accept(true)
            }
        }).disposed(by: disposeBag)
        
        allCheck = Observable.combineLatest(toggleAll,toggleService,toggleInfo) { $0 && $1 && $2 }
        
    }
    
}

