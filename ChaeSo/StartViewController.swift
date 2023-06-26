import UIKit
import SnapKit
import RxSwift
import RxCocoa

class StartViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private lazy var imageView = UIImageView()
    private let chaesoLabel = UILabel()
    private let startButton = UIButton()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: ViewModel){

        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let loginViewController = LoginViewController()
                loginViewController.bind(viewModel)
                self.navigationController?.pushViewController(loginViewController, animated: true)
            })
            .disposed(by: disposeBag)
                    
    }
    
    func attribute(){
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        chaesoLabel.text = "CHAESO"
        chaesoLabel.textColor = .black
        chaesoLabel.font = UIFont(name: "Barriecito-Regular", size: 40)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        let attributedText = NSMutableAttributedString(string: "chaeso", attributes: [NSAttributedString.Key.kern: 4, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        chaesoLabel.attributedText = attributedText
        
        
        startButton.setTitle("Start", for: .normal)
        startButton.tintColor = .white
        startButton.backgroundColor = UIColor(named: "prColor")
        startButton.layer.cornerRadius = 8
    }
    
    func layout(){
        let mainWidth = UIScreen.main.bounds.size.width
        let mainHeight = UIScreen.main.bounds.size.height
        
        print(mainWidth)
        print(mainHeight)
        
        [imageView,chaesoLabel,startButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(251)
            make.height.equalTo(242)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(259)
            
        }
        
        chaesoLabel.snp.makeConstraints { make in
            make.width.equalTo(151)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(515)
        }
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(721)
        }
        
    }
    

}


