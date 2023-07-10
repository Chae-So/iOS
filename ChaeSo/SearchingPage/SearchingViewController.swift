import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Lottie

class SearchingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var searchingViewModel: SearchingViewModel!
    
    private lazy var animationView = LottieAnimationView(name: "FlowTomato")
    private lazy var searchingLabel = UILabel()
    
    init(searchingViewModel: SearchingViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.searchingViewModel = searchingViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        
        
        
        animationView.loopMode = .loop
        animationView.play() // 애미메이션뷰 실행
        
        bind()
        attribute()
        layout()
        
        
    }
    
    func bind(){
        searchingViewModel.searchingText
            .asDriver(onErrorDriveWith: .empty())
            .drive(searchingLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func attribute(){
        
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: searchingLabel Attribute
        searchingLabel.textColor = UIColor.black
        searchingLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        //searchingLabel.textAlignment = .center
    }
    
    func layout(){
        [animationView,searchingLabel]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        animationView.snp.makeConstraints { make in
            make.width.equalTo(251*Constants.standardWidth)
            make.height.equalTo(242*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(242*Constants.standardHeight)
        }
        
        searchingLabel.snp.makeConstraints { make in
            make.height.equalTo(21*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(530*Constants.standardHeight)
        }
    }

}

#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {

    // 여기 ViewController를 변경해주세요
    func makeUIViewController(context: Context) -> UIViewController {
        SearchingViewController(searchingViewModel: SearchingViewModel(localizationManager: LocalizationManager.shared))
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
