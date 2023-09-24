import Foundation
import RxSwift
import RxCocoa
import UIKit

class MyPageViewModel: PhotoViewModelProtocol {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let titleText = BehaviorRelay<String>(value: "")
    let editProfileText = BehaviorRelay<String>(value: "")
    
    let myPostText = BehaviorRelay<String>(value: "")
    let bookmarkText = BehaviorRelay<String>(value: "")
    let notificationText = BehaviorRelay<String>(value: "")
    let termsText = BehaviorRelay<String>(value: "")
    let languageSettingText = BehaviorRelay<String>(value: "")
    let logoutText = BehaviorRelay<String>(value: "")
    let withdrawText = BehaviorRelay<String>(value: "")
    
    let alertTitleText = BehaviorRelay<String>(value: "")
    let alertCancelText = BehaviorRelay<String>(value: "")
    let alertLogoutText = BehaviorRelay<String>(value: "")
    
    let nicknameButtonTapped = PublishSubject<Void>()
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])

    let tabItems = BehaviorRelay<[String]>(value: [])
    let sectionHeaders: Observable<[CGFloat]> = Observable.just([5, 5, 0])
    
    let logoutButtonTapped = PublishSubject<Void>()
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(myPostText,bookmarkText,notificationText,termsText,languageSettingText,logoutText,withdrawText)
            .subscribe(onNext: { [weak self] a, b, c, d, e, f, g in
                self?.tabItems.accept([a,b,c,d,e,f,g])
            })
            .disposed(by: disposeBag)
        
        logoutButtonTapped
            .subscribe(onNext: {
                print(123123123123)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func updateLocalization() {
        LocalizationManager.shared.rxLanguage
            .subscribe(onNext: { [weak self] language in
                let newTitle = self?.localizationManager.localizedString(forKey: "My Chaeso")
                self?.titleText.accept(newTitle!)
                
                let a = self?.localizationManager.localizedString(forKey: "edit profile")
                let b = self?.localizationManager.localizedString(forKey: "my post")
                let c = self?.localizationManager.localizedString(forKey: "bookmark")
                let d = self?.localizationManager.localizedString(forKey: "notification")
                let e = self?.localizationManager.localizedString(forKey: "terms of service")
                let f = self?.localizationManager.localizedString(forKey: "language setting")
                let g = self?.localizationManager.localizedString(forKey: "logout")
                let h = self?.localizationManager.localizedString(forKey: "withdraw")
                
                self?.editProfileText.accept(a!)
                self?.myPostText.accept(b!)
                self?.bookmarkText.accept(c!)
                self?.notificationText.accept(d!)
                self?.termsText.accept(e!)
                self?.languageSettingText.accept(f!)
                self?.logoutText.accept(g!)
                self?.withdrawText.accept(h!)
                
                let alertTitle = self?.localizationManager.localizedString(forKey: "Would you like to logout?")
                let alertCancel = self?.localizationManager.localizedString(forKey: "cancel")
                let alertLogout = self?.localizationManager.localizedString(forKey: "logout")
                
                self?.alertTitleText.accept(alertTitle!)
                self?.alertCancelText.accept(alertCancel!)
                self?.alertLogoutText.accept(alertLogout!)
                
            })
            .disposed(by: disposeBag)
        
        
    }
}

