import RxSwift
import RxCocoa

class ContentViewModel {
    let nickname: String
    let age: Int

    let displayText: Observable<String>
    let showMoreOrLess: Observable<String>
    let toggleContent = PublishSubject<Void>()
    
    let content: String
    private let isExpanded = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    init(user: zxc) {
        self.nickname = user.nickname
        self.age = user.age
        self.content = user.content
        
        displayText = Observable.combineLatest(isExpanded, Observable.just(user.content)).map { isExpanded, text -> String in
            if !isExpanded && text.count > 50 {
                let index = text.index(text.startIndex, offsetBy: 50)
                return String(text[..<index]) + "... "
            }
            return text
        }
        
        showMoreOrLess = isExpanded.map { $0 ? "접기" : "더보기" }
        
        toggleContent
            .withLatestFrom(isExpanded)
            .subscribe(onNext: { expanded in
                self.isExpanded.accept(!expanded)
            })
            .disposed(by: disposeBag)
    }
}

class UserListViewModel {
    let users = PublishRelay<[zxc]>()
    
    init() {
        users.accept([
            zxc(nickname: "John", age: 25, content: "Hello! This is a sample content which is longer than 50 characters so it will be truncated initially."),
            zxc(nickname: "Jane", age: 30, content: "Another sample content."),
            zxc(nickname: "Bob", age: 28, content: "Yet another long sample content for the sake of testing."),
            zxc(nickname: "Alice", age: 24, content: "Short content."),
            zxc(nickname: "Charlie", age: 29, content: "Last sample content.")
        ])
    }
}
