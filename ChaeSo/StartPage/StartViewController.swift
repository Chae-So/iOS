import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import DropDown
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser

class StartViewController: UIViewController {
    let disposeBag = DisposeBag()
    var languageButtonDisPoseBag = DisposeBag()
    var startViewModel: StartViewModel
    
    lazy var imageView = UIImageView()
    let chaesoLabel = UILabel()
    let languageButton = UIButton()
    let downButton = UIButton()
    let startButton = UIButton()
    
    let languages = ["한국어", "English"]
    let dropDown = DropDown()
    
    init(startViewModel: StartViewModel) {
        self.startViewModel = startViewModel
        super.init(nibName: nil, bundle: nil)
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
        
        startViewModel.startText
            .asDriver(onErrorDriveWith: .empty())
            .drive(startButton.rx.title())
            .disposed(by: disposeBag)
        
        startViewModel.selectLanguageText
            .asDriver(onErrorDriveWith: .empty())
            .drive(languageButton.rx.title())
            .disposed(by: languageButtonDisPoseBag)
        
        dropDown.rx.itemSelected
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] index, item in
                self?.languageButtonDisPoseBag = DisposeBag()
                self?.languageButton.setTitle(item, for: .normal)
                self?.startViewModel.languageSelected.onNext(item)
            })
            .disposed(by: disposeBag)
        
        startViewModel.startButtonEnable
            .bind(to: startButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        startViewModel.startButtonEnable
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(startButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        startViewModel.startButtonEnable
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(startButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        languageButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dropDown.show()
            })
            .disposed(by: disposeBag)
        
        downButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dropDown.show()
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
        
        chaesoLabel.do{
            $0.textColor = .black
            $0.font = UIFont(name: "Barriecito-Regular", size: 40*Constants.standartFont)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1
            let attributedText = NSMutableAttributedString(string: "CHAESO", attributes: [NSAttributedString.Key.kern: 4, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            $0.attributedText = attributedText
        }
        
        languageButton.do{
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor(red: 0.117, green: 0.117, blue: 0.117, alpha: 1), for: .normal)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16*Constants.standardWidth, bottom: 0, right: 0)
            $0.backgroundColor = UIColor(named: "slColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
        }
        
        downButton.do{
            $0.setImage(UIImage(named: "down"), for: .normal)
        }
        
        dropDown.do{
            $0.anchorView = languageButton
            $0.dataSource = languages
            $0.bottomOffset = CGPoint(x: 0, y: 58 * Constants.standardHeight)
            $0.cornerRadius = 8*Constants.standardHeight
            $0.shadowColor = .clear
            $0.backgroundColor = UIColor(named: "slColor")
        }
        
        startButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
            $0.isEnabled = false
        }
    }
    
    func layout(){
        
        
        [imageView,chaesoLabel,languageButton,downButton,startButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(251*Constants.standardHeight)
            make.height.equalTo(242*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(230*Constants.standardHeight)
        }
        
        chaesoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(112*Constants.standardWidth)
            make.top.equalToSuperview().offset(486*Constants.standardHeight)
        }
        
        languageButton.snp.makeConstraints { make in
            make.width.equalTo(342*Constants.standardWidth)
            make.height.equalTo(48*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(548*Constants.standardHeight)
        }
        
        downButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.trailing.equalTo(languageButton.snp.trailing)
            make.centerY.equalTo(languageButton)
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

