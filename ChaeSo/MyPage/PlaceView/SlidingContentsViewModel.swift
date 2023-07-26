import RxSwift
import RxCocoa

class SlidingContentsViewModel {
    var didEndDecelerating: Observable<Void>
    var contentOffset: Observable<CGPoint>
    
    init(didEndDecelerating: Observable<Void>, contentOffset: Observable<CGPoint>) {
        self.didEndDecelerating = didEndDecelerating
        self.contentOffset = contentOffset
    }
}
