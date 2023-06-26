import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private lazy var imageView = UIImageView()
    private let emailLabel = UILabel()
    private lazy var emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private lazy var passwordTextField = UITextField()
    
    private let orLabel = UILabel()
    private let appleLoginButton = UIButton()
    private let cacaoLoginButton = UIButton()
    
    private let isFirstVisitLabel = UILabel()
    private let signupButton = UIButton()
    private let nextButton = UIButton()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.hidesBackButton = true
//        //bind(ViewModel())
//        attribute()
//        layout()
//    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        //bind(ViewModel())
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func bind(_ viewModel: ViewModel){
        signupButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let accountInfoViewController = AccountInfoViewController()
                self.navigationController?.pushViewController(accountInfoViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    
    func attribute(){
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        
        //MARK: emailLabel attribute
        emailLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        emailLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        emailLabel.textAlignment = .center
        emailLabel.text = "E-mail"
        
        
        //MARK: emailTextField attribute
        emailTextField.alpha = 0.56
        emailTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        emailTextField.layer.cornerRadius = 8
        emailTextField.addLeftPadding()
        emailTextField.placeholder = "이메일을 입력해 주세요."
        
        //MARK: passwordLabel attribute
        passwordLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        passwordLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        passwordLabel.text = "password"
        
        
        //MARK: passwordTextField attribute
        passwordTextField.alpha = 0.56
        passwordTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "비밀번호를 입력해 주세요."
        
        //MARK: orLabel attribute
        orLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        orLabel.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        orLabel.text = "or"
        
        //MARK: isFirstVisitLabel attribute
        isFirstVisitLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        isFirstVisitLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        isFirstVisitLabel.textAlignment = .center
        isFirstVisitLabel.text = "채소에 첫 방문이신가요?"
        
        //MARK: signupButton attribute
        signupButton.titleLabel?.textAlignment = .center
        signupButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        signupButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        signupButton.setTitle("회원가입하기", for: .normal)
        signupButton.layer.cornerRadius = 8
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        
        //MARK: nextButton attribute
        nextButton.titleLabel?.textAlignment = .center
        nextButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.setTitle("next", for: .normal)
        nextButton.backgroundColor = UIColor(named: "prColor")
        nextButton.layer.cornerRadius = 8
                
    }
    
    func layout(){
        [imageView,emailLabel,emailTextField,passwordLabel,passwordTextField]
            .forEach {
                view.addSubview($0)
            }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(96.41)
            make.centerX.equalToSuperview().offset(0.5)
            make.top.equalToSuperview().offset(97)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(250)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(285)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(365)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(400)
        }
        
        [orLabel,appleLoginButton,cacaoLoginButton,isFirstVisitLabel,signupButton,nextButton]
            .forEach {
                view.addSubview($0)
            }
        
        orLabel.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(19)
            make.centerX.equalToSuperview().offset(0.5)
            make.top.equalToSuperview().offset(478)
        }
        
        isFirstVisitLabel.snp.makeConstraints { make in
            make.width.equalTo(155)
            make.height.equalTo(19)
            make.centerX.equalToSuperview().offset(-91)
            make.top.equalToSuperview().offset(608)
        }
        
        signupButton.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(57)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(643)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(57)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(720)
        }
        
        
    }

}

