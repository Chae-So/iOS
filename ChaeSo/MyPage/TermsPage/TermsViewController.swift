import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class TermsViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var termsViewModel: TermsViewModel

    lazy var titleLabel = UILabel()
    lazy var leftButton = UIButton()
    lazy var separateView = UIView()
    lazy var tableView = UITableView()
    
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
        
        termsViewModel.tabItems
            .bind(to: tableView.rx.items(cellIdentifier: "MyPageTableViewCell", cellType: MyPageTableViewCell.self)){ [weak self] (row, element, cell) in
                cell.hideSeparator()
                cell.titleLabel.text = element
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                let row = index.row
                switch row{
                case 0:
                    let ppVC = PpViewController(termsViewModel: self.termsViewModel)
                    self.navigationController?.pushViewController(ppVC, animated: true)
                case 1:
                    let ltVC = LtViewController(termsViewModel: self.termsViewModel)
                    self.navigationController?.pushViewController(ltVC, animated: true)
                default:
                    break
                }
                
            })
            .disposed(by: disposeBag)

    }
    
    func attribute(){
        view.backgroundColor = .white
        
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
                
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")

        tableView.do{
            $0.isScrollEnabled = false
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 20*Constants.standardWidth, bottom: 0, right: 20*Constants.standardWidth)
            $0.separatorColor = UIColor(hexCode: "D9D9D9")
            $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        }
        
    }
    
    func layout(){
        [titleLabel,leftButton,separateView,tableView]
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
        
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom)
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
