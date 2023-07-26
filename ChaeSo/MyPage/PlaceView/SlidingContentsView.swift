import UIKit
import RxSwift
import RxCocoa

class SlidingContentsView: UIView {
    
    private let scrollView = UIScrollView()
    
    private let disposeBag = DisposeBag()
    
    var didEndDecelerating: Observable<Void> {
        return scrollView.rx.didEndDecelerating.asObservable()
    }
    
    var contentOffset: Observable<CGPoint> {
        return scrollView.rx.contentOffset.asObservable()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // ... Add UI Setup for scrollView
    }
}
