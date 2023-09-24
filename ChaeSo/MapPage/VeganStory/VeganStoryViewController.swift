import UIKit
import RxSwift
import RxCocoa
import SnapKit

class VeganStoryViewController: UIViewController {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var veganStoryViewModel: VeganStoryViewModel
    
    // MARK: - UI Elements
    lazy var leftButton = UIButton()
    private lazy var veganStoryLabel = UILabel()
    private lazy var separateView = UIView()
    private lazy var photoView = PhotoView()
    let vsTabView = VSTabView(vsTabViewModel: VSTabViewModel(localizationManager: LocalizationManager.shared))

    private var tableView = UITableView()
    
    // MARK: - Initializers
    
    init(veganStoryViewModel: VeganStoryViewModel) {
        self.veganStoryViewModel = veganStoryViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bind()
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 구독 설정
        bind()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 구독 해제
        disposeBag = DisposeBag()
    }
    
    
    func bind(){
        leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        veganStoryViewModel.veganStoryText
            .asDriver(onErrorDriveWith: .empty())
            .drive(veganStoryLabel.rx.text)
            .disposed(by: disposeBag)
        
        veganStoryViewModel.veganStoryText
            .subscribe(onNext: { [self] title in
                print(123123123,veganStoryViewModel.localizationManager.language)
                print(title)
            })
            .disposed(by: disposeBag)
     
        
        vsTabView.presentWriteReviewRelay
                .subscribe(onNext: { [weak self] in
                    let writeReviewViewController = WriteReviewViewController(writeReviewViewModel: WriteReviewViewModel(localizationManager: LocalizationManager.shared))
                    writeReviewViewController.modalPresentationStyle = .fullScreen
                    //self?.present(writeReviewViewController, animated: true, completion: nil)
                    self?.show(writeReviewViewController, sender: nil)
                })
                .disposed(by: disposeBag)
        
    }

   
    
    func attribute(){
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        
        //MARK: myChaesoLabel Attribute
        veganStoryLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        veganStoryLabel.text = veganStoryViewModel.aa
        
        //MARK: separateView Attribute
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")
        
        //MARK: photoImage Attribute
        //photoView.backgroundColor = .gray
        
    }
    
    func layout(){
        [veganStoryLabel,leftButton,separateView,photoView,vsTabView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        veganStoryLabel.snp.makeConstraints { make in
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(45*Constants.standardWidth)
            make.top.equalToSuperview().offset(56*Constants.standardHeight)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardWidth)
            make.centerY.equalTo(veganStoryLabel)
        }
        
        separateView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(veganStoryLabel.snp.bottom).offset(12*Constants.standardHeight)
        }
        
        photoView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(249*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom)
        }
        
        vsTabView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            //make.height.equalTo(18*Constants.standardHeight)
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(photoView.snp.bottom)
        }
        
        
    }
}




//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        VeganViewController(veganViewModel: VeganViewModel(localizationManager: LocalizationManager.shared))
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
