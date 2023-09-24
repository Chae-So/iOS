import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class LtViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var termsViewModel: TermsViewModel

    lazy var titleLabel = UILabel()
    lazy var leftButton = UIButton()
    lazy var separateView = UIView()
    let scrollView = UIScrollView()
    lazy var ltLabel = UILabel()
    lazy var contentLabel = UILabel()
    
    init(termsViewModel: TermsViewModel) {
        self.termsViewModel = termsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
        leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        termsViewModel.termsText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        termsViewModel.secondText
            .bind(to: ltLabel.rx.text)
            .disposed(by: disposeBag)
        
        termsViewModel.ltText
            .bind(to: contentLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){
        view.backgroundColor = .white
        
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
                
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")

        ltLabel.font = UIFont(name: "Pretendard-Bold", size: 16*Constants.standartFont)
        
        contentLabel.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        contentLabel.numberOfLines = 0
        
    }
    
    func layout(){
        [titleLabel,leftButton,separateView,scrollView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(54*Constants.standardHeight)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardHeight)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardHeight)
            make.centerY.equalTo(titleLabel)
        }
        
        separateView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(84*Constants.standardHeight)
        }
        
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom)
            make.bottom.equalTo(-Constants.tabBarHeight*Constants.standardHeight)
        }
        
        [ltLabel,contentLabel]
            .forEach { UILabel in
                scrollView.addSubview(UILabel)
            }
        
        ltLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24*Constants.standardHeight)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(340*Constants.standardWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(ltLabel.snp.bottom).offset(15*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-20*Constants.standardHeight)
        }
        
    }
}




//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared), ptCollectionViewModel: PTCollectionViewModel())
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

