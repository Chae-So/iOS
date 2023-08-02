import UIKit
import SnapKit
import RxSwift
import RxCocoa
import DropDown
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser

class StartViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var startViewModel: StartViewModel!
    
    private lazy var imageView = UIImageView()
    private lazy var chaesoLabel = UILabel()
    private lazy var languageButton = UIButton()
    private lazy var startButton = UIButton()
    
    let languages = ["한국어", "English"]
    let dropDown = DropDown()
    
    
    
    init(startViewModel: StartViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.startViewModel = startViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if (AuthApi.hasToken()) {
//            UserApi.shared.rx.accessTokenInfo()
//                .subscribe(onSuccess:{ (token) in
//                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
//                    print("asdasd",token)
//                }, onFailure: {error in
////                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
////                        //로그인 필요
////                    }
////                    else {
////                        //기타 에러
////                    }
//                    print("토큰있고 에러있음",error)
//                })
//                .disposed(by: disposeBag)
//        }
//        else {
//            print("토큰없음")
//            //로그인 필요
//        }
//        UserApi.shared.rx.me()
//            .subscribe (onSuccess:{ user in
//                print("me() success.")
//
//                let nickname = user.kakaoAccount?.profile?.nickname
//                let email = user.kakaoAccount?.email
//
//                print("nickname",nickname)
//                print("email",email)
//                print("useruseruser",user)
//
//            }, onFailure: {error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
        
        bind()
        attribute()
        layout()
    }
    
    
    
    func bind(){
        
        
        dropDown.rx.itemSelected
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] index, item in
                self?.languageButton.setTitle(item, for: .normal)
                self?.startViewModel.languageSelected.onNext(item)
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
                
                let loginViewModel = LoginViewModel(localizationManager: LocalizationManager.shared)
                let loginViewController = LoginViewController(loginViewModel: loginViewModel)
                self.navigationController?.pushViewController(loginViewController, animated: true)
            })
            .disposed(by: disposeBag)
                    
    }
    
    func attribute(){
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        chaesoLabel.textColor = .black
        chaesoLabel.font = UIFont(name: "Barriecito-Regular", size: 40*Constants.standardWidth)
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
        dropDown.bottomOffset = CGPoint(x: 0, y: 58 * Constants.standardHeight)
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
            make.width.equalTo(251*Constants.standardHeight)
            //make.height.equalTo(imageView.snp.width)
            make.height.equalTo(242*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(230*Constants.standardHeight)
        }
        
        chaesoLabel.snp.makeConstraints { make in
            make.width.equalTo(161*Constants.standardWidth)
            make.height.equalTo(48*Constants.standardHeight)
            make.leading.equalToSuperview().offset(112*Constants.standardWidth)
            //make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(486*Constants.standardHeight)
        }
        
        languageButton.snp.makeConstraints { make in
            make.width.equalTo(342*Constants.standardWidth)
            make.height.equalTo(48*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(548*Constants.standardHeight)
        }
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(721*Constants.standardHeight)
        }
    }
    
    
}








//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        StartViewController(startViewModel: StartViewModel(localizationManager: LocalizationManager.shared))
//    }
//
//    func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//    }
//}

//struct ViewController_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhoneX"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
//    }
//}
//#endif

