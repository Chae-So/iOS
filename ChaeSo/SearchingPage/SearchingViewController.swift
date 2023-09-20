import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Lottie

class SearchingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var searchingViewModel: SearchingViewModel
    
    var animationView = LottieAnimationView(name: "AniTomato")
    lazy var searchingLabel = UILabel()
    
    init(searchingViewModel: SearchingViewModel) {
        self.searchingViewModel = searchingViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        animationView.loopMode = .loop
        animationView.play() 
        
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
        
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        searchingLabel.textColor = UIColor.black
        searchingLabel.font = UIFont(name: "Pretendard-Bold", size: 20*Constants.standartFont)
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
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(530*Constants.standardHeight)
        }
    }

}

//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        SearchingViewController(searchingViewModel: SearchingViewModel(localizationManager: LocalizationManager.shared))
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
