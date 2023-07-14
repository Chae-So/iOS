import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel!

    private lazy var loginLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var appleLoginButton = UIButton()
    private lazy var googleLoginButton = UIButton()
    private lazy var kakaoLoginButton = UIButton()
    private lazy var tomatoLoginButton = UIButton()
    private lazy var lineView = UIView()
    private lazy var isFirstVisitLabel = UILabel()
    private lazy var signupButton = UIButton()
    
    init(loginViewModel: LoginViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.loginViewModel = loginViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        loginViewModel.loginText
            .asDriver(onErrorDriveWith: .empty())
            .drive(loginLabel.rx.text)
            .disposed(by: disposeBag)
        
        loginViewModel.appleLoginButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(appleLoginButton.rx.title())
            .disposed(by: disposeBag)
        
        loginViewModel.googleLoginButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(googleLoginButton.rx.title())
            .disposed(by: disposeBag)
        
        loginViewModel.kakaoLoginButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(kakaoLoginButton.rx.title())
            .disposed(by: disposeBag)
        
        loginViewModel.tomatoLoginButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(tomatoLoginButton.rx.title())
            .disposed(by: disposeBag)
                
        loginViewModel.isFirstVisitLabelText
            .asObservable()
            .bind(to: isFirstVisitLabel.rx.text)
            .disposed(by: disposeBag)
        
        loginViewModel.signupButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(signupButton.rx.title())
            .disposed(by: disposeBag)

        signupButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let signUpViewModel = SignUpViewModel(localizationManager: LocalizationManager.shared)
                let signUpViewController = SignUpViewController(signUpViewModel: signUpViewModel)
                self.navigationController?.pushViewController(signUpViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    

    
    func attribute(){
        //MARK: login Attribute
        loginLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        loginLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        loginLabel.textAlignment = .center
        
        
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView Attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        //MARK: appleLoginButton Attribute
        appleLoginButton.titleLabel?.textAlignment = .center
        appleLoginButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        appleLoginButton.setTitleColor(UIColor.white, for: .normal)
        appleLoginButton.layer.cornerRadius = 8
        appleLoginButton.backgroundColor = UIColor.black
        appleLoginButton.setImage(UIImage(named: "apple"), for: .normal)
        appleLoginButton.adjustsImageWhenHighlighted = false

        //MARK: googleLoginButton Attribute
        googleLoginButton.titleLabel?.textAlignment = .center
        googleLoginButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        googleLoginButton.setTitleColor(UIColor.black, for: .normal)
        googleLoginButton.layer.cornerRadius = 8
        googleLoginButton.backgroundColor = UIColor.white
        googleLoginButton.setImage(UIImage(named: "google"), for: .normal)
        googleLoginButton.adjustsImageWhenHighlighted = false
        
        //MARK: kakaoLoginButton Attribute
        kakaoLoginButton.titleLabel?.textAlignment = .center
        kakaoLoginButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        kakaoLoginButton.setTitleColor(UIColor.black, for: .normal)
        kakaoLoginButton.backgroundColor = UIColor(hexCode: "FEE500")
        kakaoLoginButton.layer.cornerRadius = 8
        kakaoLoginButton.setImage(UIImage(named: "kakao"), for: .normal)
        kakaoLoginButton.adjustsImageWhenHighlighted = false
        
        //MARK: tomatoLoginButton Attribute
        tomatoLoginButton.titleLabel?.textAlignment = .center
        tomatoLoginButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        tomatoLoginButton.setTitleColor(UIColor.black, for: .normal)
        tomatoLoginButton.layer.cornerRadius = 8
        tomatoLoginButton.backgroundColor = UIColor.white
        tomatoLoginButton.setImage(UIImage(named: "tomato"), for: .normal)
        tomatoLoginButton.adjustsImageWhenHighlighted = false
        
        //MARK: lineView Attribute
        lineView.backgroundColor = UIColor(hexCode: "#DEDEDE")
        
        //MARK: isFirstVisitLabel Attribute
        isFirstVisitLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        isFirstVisitLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        isFirstVisitLabel.textAlignment = .center
        
        
        //MARK: signupButton Attribute
        signupButton.titleLabel?.textAlignment = .center
        signupButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        signupButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        signupButton.layer.cornerRadius = 8
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor(named: "prColor")?.cgColor


                
    }
    
    func layout(){
        [loginLabel,imageView,appleLoginButton,googleLoginButton,kakaoLoginButton,tomatoLoginButton,lineView,isFirstVisitLabel,signupButton]
            .forEach {
                view.addSubview($0)
            }
        
        //MARK: login Layout
        loginLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(53*Constants.standardHeight)
        }
        
        //MARK: imageView Layout
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        //MARK: appleLoginButton Layout
        appleLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(365*Constants.standardHeight)
        }
        
        appleLoginButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        
        appleLoginButton.titleLabel?.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        //MARK: googleLoginButton Layout
        googleLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(437*Constants.standardHeight)
        }
        
        googleLoginButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        
        googleLoginButton.titleLabel?.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        //MARK: kakaoLoginButton Layout
        kakaoLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(509*Constants.standardHeight)
        }
        
        kakaoLoginButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        
        kakaoLoginButton.titleLabel?.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        //MARK: tomatoLoginButton Layout
        tomatoLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(581*Constants.standardHeight)
        }
        
        tomatoLoginButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        
        tomatoLoginButton.titleLabel?.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        //MARK: lineView Layout
        lineView.snp.makeConstraints { make in
            make.width.equalTo(341*Constants.standardWidth)
            make.height.equalTo(1*Constants.standardHeight)
            make.leading.equalToSuperview().offset(17*Constants.standardWidth)
            make.top.equalToSuperview().offset(662*Constants.standardHeight)
        }
        
        //MARK: isFirstVisitLabel Layout
        isFirstVisitLabel.snp.makeConstraints { make in
            //make.width.equalTo(155*standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(17*Constants.standardWidth)
            make.top.equalToSuperview().offset(686*Constants.standardHeight)
        }
        
        //MARK: signupButton Layout
        signupButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
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
//        LoginViewController(loginViewModel: LoginViewModel(localizationManager: LocalizationManager.shared))
//    }
//
//    func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//    }
//}
//
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
//    }
//}
//#endif
