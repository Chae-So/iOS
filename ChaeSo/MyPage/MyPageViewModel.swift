import Foundation
import RxSwift
import RxCocoa
import UIKit

class MyPageViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    let myChaesoText = BehaviorRelay<String>(value: "")
    let postText = BehaviorRelay<String>(value: "")
    let followingText = BehaviorRelay<String>(value: "")
    let followerText = BehaviorRelay<String>(value: "")
    
    
    // Output
    let items: Observable<[TableViewItem]> = Observable.just([
        
        TableViewItem(title: "내가 쓴 글", icon: UIImage(named: "right")),
        TableViewItem(title: "북마크", icon: UIImage(named: "right")),
        TableViewItem(title: "좋아요", icon: UIImage(named: "right")),
        
        TableViewItem(title: "공지사항", icon: nil),
        TableViewItem(title: "문의하기", icon: nil),
        TableViewItem(title: "약관 및 정책", icon: nil),
        TableViewItem(title: "설정", icon: nil),
        
        TableViewItem(title: "로그아웃", icon: nil),
        TableViewItem(title: "회원탈퇴", icon: nil)
        
    ])
    let sectionHeaders: Observable<[CGFloat]> = Observable.just([5, 5, 0])
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        
        
    }
    
    private func updateLocalization() {
        myChaesoText.accept(localizationManager.localizedString(forKey: "My Chaeso"))
        postText.accept(localizationManager.localizedString(forKey: "Post"))
        followingText.accept(localizationManager.localizedString(forKey: "Following"))
        followerText.accept(localizationManager.localizedString(forKey: "Follower"))
    }
}

