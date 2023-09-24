import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class WithdrawViewController: UIViewController {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var withdrawViewModel: WithdrawViewModel

    lazy var titleLabel = UILabel()
    lazy var leftButton = UIButton()
    lazy var separateView = UIView()
    lazy var firstLabel = UILabel()
    lazy var secondLabel = UILabel()
    lazy var thirdLabel = UILabel()
    lazy var withdrawButton = UIButton()
    
    init(withdrawViewModel: WithdrawViewModel) {
        self.withdrawViewModel = withdrawViewModel
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
        
        withdrawViewModel.withdrawText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        withdrawViewModel.firstText
            .bind(to: firstLabel.rx.text)
            .disposed(by: disposeBag)
        
        withdrawViewModel.secondText
            .bind(to: secondLabel.rx.text)
            .disposed(by: disposeBag)
        
        withdrawViewModel.thirdText
            .bind(to: thirdLabel.rx.text)
            .disposed(by: disposeBag)
        
        withdrawViewModel.withdrawText
            .bind(to: withdrawButton.rx.title())
            .disposed(by: disposeBag)
    }
    
    func attribute(){
        view.backgroundColor = .white
        
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
                
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")

        firstLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 20*Constants.standartFont)
            $0.numberOfLines = 0
        }
        
        secondLabel.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        
        thirdLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.textColor = .red
            $0.numberOfLines = 0
        }
        
    
        withdrawButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.backgroundColor = UIColor(named: "prColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }
        
    }
    
    func layout(){
        [titleLabel,leftButton,separateView,firstLabel,secondLabel,thirdLabel,withdrawButton]
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
        
        firstLabel.snp.makeConstraints { make in
            make.width.equalTo(317*Constants.standardWidth)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(separateView.snp.bottom).offset(24*Constants.standardHeight)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(firstLabel.snp.bottom).offset(50*Constants.standardHeight)
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(secondLabel.snp.bottom).offset(5*Constants.standardHeight)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.bottom.equalToSuperview().offset(-Constants.tabBarHeight*Constants.standardHeight)
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
