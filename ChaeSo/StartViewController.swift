import UIKit
import SnapKit
import RxSwift
import RxCocoa

class StartViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private lazy var imageView = UIImageView()
    private let chaesoLabel = UILabel()
    private let startButton = UIButton()
    
    private let mainWidth = UIScreen.main.bounds.size.width
    private let mainHeight = UIScreen.main.bounds.size.height
    
    private let standardWidth = UIScreen.main.bounds.size.width / 375.0
    private let standardHeight = UIScreen.main.bounds.size.height / 812.0

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
        
        chaesoLabel.textColor = .black
        chaesoLabel.font = UIFont(name: "Barriecito-Regular", size: 40*standardWidth)
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
        
        
        [imageView,chaesoLabel,startButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(251*standardWidth)
            make.height.equalTo(242*standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(259*standardHeight)
            
        }
        
        chaesoLabel.snp.makeConstraints { make in
            make.width.equalTo(161*standardWidth)
            make.height.equalTo(48*standardHeight)
            //make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(112*standardWidth)
            make.top.equalToSuperview().offset(515*standardHeight)
        }
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(343*standardWidth)
            //make.width.equalToSuperview().multipliedBy(343*standardWidth)
            make.height.equalTo(56*standardHeight)
            make.leading.equalToSuperview().offset(16*standardWidth)
            make.top.equalToSuperview().offset(721*standardHeight)
        }
        
        
        
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

