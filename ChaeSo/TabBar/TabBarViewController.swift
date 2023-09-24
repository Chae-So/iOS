import UIKit
import RxSwift
import RxCocoa

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let tabBarViewModel: TabBarViewModel
    
    // MARK: - Initializers
    
    init(tabBarViewModel: TabBarViewModel) {
        self.tabBarViewModel = tabBarViewModel
        super.init(nibName: nil, bundle: nil)
        tabBar.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let communityVC = CommunityViewController(communityViewModel: CommunityViewModel(localizationManager: LocalizationManager.shared))
        let communityNavVC = UINavigationController(rootViewController: communityVC)
        communityNavVC.isNavigationBarHidden = true
        
        let mapVC = MapViewController(mapViewModel: MapViewModel(localizationManager: LocalizationManager.shared))
        let mapNavVC = UINavigationController(rootViewController: mapVC)
        mapNavVC.isNavigationBarHidden = true

        
        let myPageVC = MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared))
        let myPageNavVC = UINavigationController(rootViewController: myPageVC)
        myPageNavVC.isNavigationBarHidden = true
        
        communityVC.tabBarItem = UITabBarItem(title: tabBarViewModel.chaesoLogText.value, image: UIImage(named: "cheasoLog"), tag: 0)
        mapNavVC.tabBarItem = UITabBarItem(title: tabBarViewModel.mapText.value, image: UIImage(named: "map"), tag: 1)
        myPageNavVC.tabBarItem = UITabBarItem(title: tabBarViewModel.myPageText.value, image: UIImage(named: "myPage"), tag: 2)
        
        self.viewControllers = [communityNavVC, mapNavVC, myPageNavVC]

        tabBarViewModel.chaesoLogText
            .bind(to: communityNavVC.tabBarItem.rx.title)
            .disposed(by: disposeBag)

        tabBarViewModel.mapText
            .bind(to: mapNavVC.tabBarItem.rx.title)
            .disposed(by: disposeBag)

        tabBarViewModel.myPageText
            .bind(to: myPageNavVC.tabBarItem.rx.title)
            .disposed(by: disposeBag)

        
        rx.didSelect
            .map { $0.view.tag }
            .bind(to: tabBarViewModel.selectedIndex)
            .disposed(by: disposeBag)
        
        tabBarViewModel.selectedIndex
            .subscribe(onNext: { [weak self] index in
                self?.tabBar.tintColor = UIColor(named: "prColor")
            })
            .disposed(by: disposeBag)
        
    }
}

//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        TabBarController(tabBarViewModel: TabBarViewModel(localizationManager: LocalizationManager.shared))
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
