import UIKit
import SnapKit
import RxSwift
import RxCocoa
import DropDown

class StartViewController: UIViewController {
    private let disposeBag = DisposeBag()
    //var startViewModel: StartViewModel!
    var loginViewModel: LoginViewModel!
    
    private lazy var imageView = UIImageView()
    private let chaesoLabel = UILabel()
    private lazy var languageButton = UIButton()
    private let startButton = UIButton()
    
    let languages = ["한국어", "English"]
    let dropDown = DropDown()
    
    private let mainWidth = UIScreen.main.bounds.size.width
    private let mainHeight = UIScreen.main.bounds.size.height
    
    private let standardWidth = UIScreen.main.bounds.size.width / 375.0
    private let standardHeight = UIScreen.main.bounds.size.height / 812.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
        dropDown.rx.itemSelected
            .asDriver(onErrorDriveWith: .empty())
            .
            .subscribe(onNext: { [weak self] index, item in
                // 선택된 언어 처리
                self?.languageButton.setTitle(item, for: .normal)
                
                // 선택된 언어를 다른 곳에서 사용하려면 여기에 추가 코드 작성
            })
            .disposed(by: disposeBag)
        
        languageButton.rx.tap
            .subscribe(onNext: { [weak dropDown] in
                // Dropdown 표시
                dropDown?.show()
            })
            .disposed(by: disposeBag)

        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let loginViewController = LoginViewController()
                loginViewController.bind(self.loginViewModel)
                self.navigationController?.pushViewController(loginViewController, animated: true)
            })
            .disposed(by: disposeBag)
                    
    }
    
    func attribute(){
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        chaesoLabel.textColor = .black
        chaesoLabel.font = UIFont(name: "Barriecito-Regular", size: 40*standardWidth)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        let attributedText = NSMutableAttributedString(string: "CHAESO", attributes: [NSAttributedString.Key.kern: 4, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        chaesoLabel.attributedText = attributedText
        
        languageButton.setTitle("select Language", for: .normal)
        languageButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        languageButton.setTitleColor(UIColor(red: 0.117, green: 0.117, blue: 0.117, alpha: 1), for: .normal)
        languageButton.contentHorizontalAlignment = .left
        languageButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        languageButton.backgroundColor = UIColor.white
        languageButton.layer.cornerRadius = 8
        
        
        dropDown.anchorView = languageButton
        dropDown.dataSource = languages
        dropDown.bottomOffset = CGPoint(x: 0, y: 58 * standardHeight)
        dropDown.cornerRadius = 8
        dropDown.shadowColor = .clear
        dropDown.backgroundColor = UIColor.white
        
        startButton.setTitle("Start", for: .normal)
        startButton.tintColor = .white
        startButton.backgroundColor = UIColor(named: "prColor")
        startButton.layer.cornerRadius = 8
    }
    
    func layout(){
        
        
        [imageView,chaesoLabel,languageButton,startButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(251*standardWidth)
            make.height.equalTo(242*standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(230*standardHeight)
            
        }
        
        chaesoLabel.snp.makeConstraints { make in
            make.width.equalTo(161*standardWidth)
            make.height.equalTo(48*standardHeight)
            make.leading.equalToSuperview().offset(112*standardWidth)
            make.top.equalToSuperview().offset(486*standardHeight)
        }
        
        languageButton.snp.makeConstraints { make in
            make.width.equalTo(342*standardWidth)
            make.height.equalTo(48*standardHeight)
            make.leading.equalToSuperview().offset(16*standardWidth)
            make.top.equalToSuperview().offset(548*standardHeight)
        }
        
        
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(343*standardWidth)
            make.height.equalTo(56*standardHeight)
            make.leading.equalToSuperview().offset(16*standardWidth)
            make.top.equalToSuperview().offset(721*standardHeight)
        }
        
    }
}

extension Reactive where Base: DropDown {
    var itemSelected: ControlEvent<(Int, String)> {
        let source = Observable<(Int, String)>.create { [weak base] observer in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            base.selectionAction = { index, item in
                observer.onNext((index, item))
            }
            
            return Disposables.create {
                // Optional: Dispose 처리를 위해 Dropdown에서 selectionAction을 해제
                base.selectionAction = nil
            }
        }
        
        return ControlEvent(events: source)
    }
}






#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {

    // 여기 ViewController를 변경해주세요
    func makeUIViewController(context: Context) -> UIViewController {
        StartViewController()
    }

    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
}

struct ViewController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Preview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))

        Preview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPhoneX"))

    }
}
#endif

