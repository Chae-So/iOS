import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController,ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    private let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel

    private lazy var leftButton = UIButton()
    private lazy var loginLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var appleLoginButton = UIButton()
    private lazy var googleLoginButton = UIButton()
    private lazy var kakaoLoginButton = UIButton()
    private lazy var emailLoginButton = UIButton()
    private lazy var lineView = UIView()
    private lazy var isFirstVisitLabel = UILabel()
    private lazy var signupButton = UIButton()
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        loginViewModel.navigationControllerSubject.onNext(self.navigationController)
        
        leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
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
            .drive(emailLoginButton.rx.title())
            .disposed(by: disposeBag)
                
        loginViewModel.isFirstVisitLabelText
            .asObservable()
            .bind(to: isFirstVisitLabel.rx.text)
            .disposed(by: disposeBag)
        
        loginViewModel.signupButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(signupButton.rx.title())
            .disposed(by: disposeBag)
        
        appleLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let request = appleIDProvider.createRequest()
                request.requestedScopes = [.fullName, .email]
                
                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                authorizationController.delegate = self.loginViewModel
                authorizationController.presentationContextProvider = self
                authorizationController.performRequests()
            })
            .disposed(by: disposeBag)
        
        loginViewModel.loginError
            .subscribe(onNext: { [weak self] error in
                print("login failed - \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
        
        googleLoginButton.rx.tap
            .bind(to: loginViewModel.googleButtonTapped)
            .disposed(by: disposeBag)
        
        kakaoLoginButton.rx.tap
            .bind(to: loginViewModel.kakaoButtonTapped)
            .disposed(by: disposeBag)
        
        emailLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let signUpViewModel = SignUpViewModel(localizationManager: LocalizationManager.shared)
                let idLoginViewController = IdLoginViewController(signUpViewModel: signUpViewModel)
                self.navigationController?.pushViewController(idLoginViewController, animated: true)

            })
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
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        
        loginLabel.do{
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "Pretendard-SemiBold", size: 20*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        appleLoginButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.backgroundColor = UIColor.black
            $0.setImage(UIImage(named: "apple"), for: .normal)
        }
        
        googleLoginButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.backgroundColor = UIColor.white
            $0.setImage(UIImage(named: "google"), for: .normal)
        }
        
        kakaoLoginButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.backgroundColor = UIColor(hexCode: "FEE500")
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.setImage(UIImage(named: "kakao"), for: .normal)
        }

        emailLoginButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.backgroundColor = UIColor.white
            $0.setImage(UIImage(named: "email"), for: .normal)
        }

        lineView.backgroundColor = UIColor(hexCode: "#DEDEDE")
        
        isFirstVisitLabel.do{
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        signupButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
            $0.backgroundColor = UIColor(named: "prColor")
        }

                
    }
    
    func layout(){
        [leftButton,loginLabel,imageView,appleLoginButton,googleLoginButton,kakaoLoginButton,emailLoginButton,lineView,isFirstVisitLabel,signupButton]
            .forEach {
                view.addSubview($0)
            }
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardHeight)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardHeight)
            make.top.equalToSuperview().offset(53*Constants.standardHeight)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftButton.snp.trailing).offset(10*Constants.standardWidth)
            make.centerY.equalTo(leftButton)
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
        emailLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(581*Constants.standardHeight)
        }
        
        emailLoginButton.imageView!.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(26*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        
        emailLoginButton.titleLabel?.snp.makeConstraints { make in
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
