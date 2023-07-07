import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: MyPageViewModel
    
    // MARK: - UI Elements
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let logoutButton = UIButton()
    
    // MARK: - Initializers
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the UI elements
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(logoutButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .systemBlue
        logoutButton.layer.cornerRadius = 10
        
        // Bind the user to the UI elements
//        viewModel.user
//            .drive(onNext: { [weak self] user in
//                guard let self = self else { return }
//                self.profileImageView.image = UIImage(named: user.profileImageName)
//                self.nameLabel.text = user.name
//                self.emailLabel.text = user.email
//            })
//            .disposed(by: disposeBag)
        
        // Bind the logout button to the view model
        logoutButton.rx.tap
            .bind(to: viewModel.logoutTapped)
            .disposed(by: disposeBag)
        
        // Navigate to the login view controller when logged out
//        viewModel.logoutTapped
//            .subscribe(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                let loginVC = LoginViewController(viewModel: LoginViewModel(model: LoginModel()))
//                self.navigationController?.setViewControllers([loginVC], animated: true)
//            })
//            .disposed(by: disposeBag)
        
    }
}
