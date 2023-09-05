import Foundation
import RxSwift
import RxCocoa
import UIKit

class MyPageViewModel: PhotoViewModelProtocol {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    var myChaesoText: String{
        return localizationManager.localizedString(forKey: "My Chaeso")
    }
    let titleText = BehaviorRelay<String>(value: "")
    
    let nicknameButtonTapped = PublishSubject<Void>()
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])

    
    // Output
    let items: Observable<[TableViewItem]> = Observable.just([
        
        TableViewItem(title: "내가 쓴 글", icon: UIImage(named: "right")),
        TableViewItem(title: "북마크", icon: UIImage(named: "right")),
        
        TableViewItem(title: "공지사항", icon: nil),
        TableViewItem(title: "문의하기", icon: nil),
        TableViewItem(title: "약관 및 정책", icon: nil),
        TableViewItem(title: "언어 설정", icon: nil),
        
        TableViewItem(title: "로그아웃", icon: nil),
        TableViewItem(title: "회원탈퇴", icon: nil)
        
    ])
    let sectionHeaders: Observable<[CGFloat]> = Observable.just([5, 5, 0])
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        //titleText.accept(localizationManager.localizedString(forKey: "My Chaeso"))
        
        LocalizationManager.shared.rxLanguage
            .subscribe(onNext: { [weak self] language in
                let newTitle = localizationManager.localizedString(forKey: "My Chaeso")
                self?.titleText.accept(newTitle)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func updateLocalization() {

    }
}

