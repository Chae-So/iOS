import Foundation
import RxSwift
import RxCocoa

class CommunityViewModel {
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    private let font = UIFont(name: "Pretendard-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)

    
    let chaesoLogText = BehaviorRelay<String>(value: "")
    let recommendText = BehaviorRelay<String>(value: "")
    let latestText = BehaviorRelay<String>(value: "")
    let tabItems = BehaviorRelay<[String]>(value: [])
    
    let currentTab: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    let imagesArr = [UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato")]
    
    let contents = "ㅇㄹㄴ울 ㅟㄴㅇㄹ ㅣㅜㅇㄴ ㅜㅏㅓㄴㅇddddㅇ123456334ㅇㅁㅈㅜㅏㅓㄴㅇddddㅇ123456334ㅇㅁㅈ40ㅜㅏㅓㄴㅇddddㅇ123456334ㅇㅁㅈㅜㅏㅓㄴㅇddddㅇ123456334ㅇㅁㅈ40ㅜㅏㅓㄴㅇddddㅇ123456334ㅇㅁㅈㅜㅏㅓㄴㅇddddㅇ123456334ㅇㅁㅈ40글자"
    
    lazy var chaesoLog: Driver<[ChaesoLog]> = Driver.just([ChaesoLog(userImage: UIImage(named: "tomato")!, nickname: "asdasd", imagesArr: imagesArr, likeNum: 10, contents: contents,commentNum: 5, commentImage: UIImage(named: "tomato")!, comment: "fdgnndfgdfgnkdjfngjkdfkn"),ChaesoLog(userImage: UIImage(named: "tomato")!, nickname: "asdasd", imagesArr: imagesArr, likeNum: 10, contents: "123456789012345",commentNum: 5, commentImage: UIImage(named: "tomato")!, comment: "123456789012345678901234567890213131241234567890"),ChaesoLog(userImage: UIImage(named: "tomato")!, nickname: "asdasd", imagesArr: imagesArr, likeNum: 10, contents: contents,commentNum: 5, commentImage: UIImage(named: "tomato")!, comment: "fdgnndfgdfgnkdjfngjkdfkn"),ChaesoLog(userImage: UIImage(named: "tomato")!, nickname: "asdasd", imagesArr: imagesArr, likeNum: 10, contents: contents,commentNum: 5, commentImage: UIImage(named: "tomato")!, comment: "fdgnndfgdfgnkdjfngjkdfkn"),ChaesoLog(userImage: UIImage(named: "tomato")!, nickname: "asdasd", imagesArr: imagesArr, likeNum: 10, contents: "123456789012345",commentNum: 5, commentImage: UIImage(named: "tomato")!, comment: "123456789012345678901234567890213131241234567890"),ChaesoLog(userImage: UIImage(named: "tomato")!, nickname: "asdasd", imagesArr: imagesArr, likeNum: 10, contents: contents,commentNum: 5, commentImage: UIImage(named: "tomato")!, comment: "fdgnndfgdfgnkdjfngjkdfkn")])
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(recommendText,latestText)
            .subscribe(onNext: { [weak self] reco, latest in
                self?.tabItems.accept([reco, latest])
            })
            .disposed(by: disposeBag)
    }
    
    private func updateLocalization() {
        chaesoLogText.accept(localizationManager.localizedString(forKey: "CheasoLog"))
        recommendText.accept(localizationManager.localizedString(forKey: "Recommend"))
        latestText.accept(localizationManager.localizedString(forKey: "Latest"))
    }
    
    func heightForRow(text: String, width: CGFloat) -> CGFloat {
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            let boundingBox = text.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
            return ceil(boundingBox.height) + 20 // 여기서 20은 패딩 값입니다.
        }
    
    
    
}
