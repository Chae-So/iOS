import UIKit
import RxSwift
import RxCocoa

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: TabBarViewModel
    
    // MARK: - Initializers
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBar.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarHeight = self.tabBar.frame.size.height
            print(tabBarHeight,328468237467)
        
        // Set up the view controllers
        let communityVC = CommunityViewController(communityViewModel: CommunityViewModel(localizationManager: LocalizationManager.shared))
        //let mapVC = VeganStoryViewController(veganStoryViewModel: VeganStoryViewModel(localizationManager: LocalizationManager.shared))
        let mapVC = MapViewController(mapViewModel: MapViewModel(localizationManager: LocalizationManager.shared))

        let myPageVC = MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared))
        
        communityVC.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(systemName: "house"), tag: 0)
        mapVC.tabBarItem = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), tag: 1)
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [communityVC, mapVC,myPageVC]
        
        // Bind the selected index to the view model
        rx.didSelect
            .map { $0.view.tag }
            .bind(to: viewModel.selectedIndex)
            .disposed(by: disposeBag)
    }
}


//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        TabBarController(viewModel: TabBarViewModel(model: TabBarModel(), communityViewModel: CommunityViewModel(model: CommunityModel()), mapViewModel: MapViewModel(), myPageViewModel: MyPageViewModel(localizationManager: LocalizationManager.shared)))
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
