import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel!

    
    private lazy var imageView = UIImageView()
    
    private let appleLoginButton = UIButton()
    private let cacaoLoginButton = UIButton()
    private let lineView = UIView()
    private let isFirstVisitLabel = UILabel()
    private let signupButton = UIButton()
    
    private let mainWidth = UIScreen.main.bounds.size.width
    private let mainHeight = UIScreen.main.bounds.size.height
    
    private let standardWidth = UIScreen.main.bounds.size.width / 375.0
    private let standardHeight = UIScreen.main.bounds.size.height / 812.0
    
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
        loginViewModel.isFirstVisitLabelText
            .asObservable()
            .bind(to: isFirstVisitLabel.rx.text) // isFirstVisitLabel의 text에 값을 바인딩
            .disposed(by: disposeBag)
        
        loginViewModel.signupButtonText
            .asDriver(onErrorDriveWith: .empty())
            .drive(signupButton.rx.title())
            .disposed(by: disposeBag)

        signupButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let signUpViewModel = SignUpViewModel()
                let signUpViewController = SignUpViewController(signUpViewModel: signUpViewModel)
                self.navigationController?.pushViewController(signUpViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    

    
    func attribute(){
        //MARK: 바탕색
        self.title = "로그인"
        
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        
        lineView.backgroundColor = UIColor(hexCode: "#DEDEDE")
        
        //MARK: isFirstVisitLabel attribute
        isFirstVisitLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        isFirstVisitLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        isFirstVisitLabel.textAlignment = .center
        //isFirstVisitLabel.text = NSLocalizedString("Is_this_your_first_visit_to_CHAESO?", comment: "")
        
        
        //MARK: signupButton attribute
        signupButton.titleLabel?.textAlignment = .center
        signupButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        signupButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        //signupButton.setTitle(NSLocalizedString("Sign_Up", comment: ""), for: .normal)
        signupButton.layer.cornerRadius = 8
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor(named: "prColor")?.cgColor

        //MARK: nextButton attribute
//        nextButton.titleLabel?.textAlignment = .center
//        nextButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
//        nextButton.setTitleColor(UIColor.white, for: .normal)
//        nextButton.setTitle("next", for: .normal)
//        nextButton.backgroundColor = UIColor(named: "prColor")
//        nextButton.layer.cornerRadius = 8
                
    }
    
    func layout(){
        [imageView,appleLoginButton,cacaoLoginButton,lineView,isFirstVisitLabel,signupButton]
            .forEach {
                view.addSubview($0)
            }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(341*Constants.standardWidth)
            make.height.equalTo(1*Constants.standardHeight)
            make.leading.equalToSuperview().offset(17*Constants.standardWidth)
            make.top.equalToSuperview().offset(662*Constants.standardHeight)
        }
        
        
        isFirstVisitLabel.snp.makeConstraints { make in
            //make.width.equalTo(155*standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(17*Constants.standardWidth)
            make.top.equalToSuperview().offset(686*Constants.standardHeight)
        }
        
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
//        LoginViewController(loginViewModel: LoginViewModel())
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
