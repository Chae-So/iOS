import UIKit
import RxCocoa
import RxSwift
import SnapKit

class YourViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let buttonTapRelay = PublishRelay<Void>()
    let restoreTapRelay = PublishRelay<Void>()
    
    var shouldStartAnimation: Observable<Void> {
        return buttonTapRelay.asObservable()
    }
    
    var shouldRestoreViews: Observable<Void> {
        return restoreTapRelay.asObservable()
    }
    
    let button1 = UIButton().then{
        $0.backgroundColor = .red
    }
    let button2 = UIButton().then{
        $0.backgroundColor = .green
    }
    let button3 = UIButton().then{
        $0.backgroundColor = .black
    }
    
    let view1 = UIView().then{
        $0.backgroundColor = .red
    }
    let view2 = UIView().then {
        $0.backgroundColor = .green
    }
    let view3 = UIView().then{
        $0.backgroundColor = .black
    }
    
    var view2TopConstraint: Constraint? // view2의 top 제약 조건을 동적으로 변경하기 위한 참조 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    private func setupViews() {
        view2.isHidden = true
    }
    
    private func setupConstraints() {
        [button1,button2,button3,view1,view2,view3]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        button1.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(151*Constants.standardHeight)
        }
        
        button2.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalToSuperview().offset(66*Constants.standardWidth)
            make.top.equalToSuperview().offset(151*Constants.standardHeight)
        }
        
        button3.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalToSuperview().offset(116*Constants.standardWidth)
            make.top.equalToSuperview().offset(151*Constants.standardHeight)
        }
        
        view1.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(button3.snp.bottom).offset(50*Constants.standardHeight)
        }
        
//        view2.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.height.equalTo(50*Constants.standardHeight)
//            make.leading.equalTo(view.snp.trailing)
//            make.top.equalTo(view1.snp.bottom)
//        }
        
        view2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(view1.snp.bottom)
        }
        
        view3.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(view1.snp.bottom)
        }
    }
    
    private func setupBindings() {
        button1.rx.tap.bind(to: buttonTapRelay).disposed(by: disposeBag)
        button2.rx.tap.bind(to: restoreTapRelay).disposed(by: disposeBag)
        button3.rx.tap.bind(to: restoreTapRelay).disposed(by: disposeBag)
        
        button1.rx.tap.subscribe(onNext: {
            print("Button 1 tapped!")
        }).disposed(by: disposeBag)

        buttonTapRelay.subscribe(onNext: {
            print("buttonTapRelay received event!")
        }).disposed(by: disposeBag)

        
        shouldStartAnimation.subscribe(onNext: { [weak self] in
            self?.slideView2In()
            print(123)
        }).disposed(by: disposeBag)
        
        shouldRestoreViews.subscribe(onNext: { [weak self] in
            self?.slideView2Out()
        }).disposed(by: disposeBag)
    }
    
    private func slideView2In() {
        UIView.animate(withDuration: 0.5) { [self] in
            self.view2.transform = CGAffineTransform(translationX: -self.view2.bounds.width, y: 0)
            self.view3.transform = CGAffineTransform(translationX: 0, y: self.view3.bounds.height)
            self.view.layoutIfNeeded()
        }
    }

    private func slideView2Out() {
        UIView.animate(withDuration: 0.5){ [self] in
            self.view2.transform = CGAffineTransform(translationX: self.view2.bounds.width, y: 0)
            self.view3.transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.layoutIfNeeded()
        }
    }

}
