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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view controllers
        let communityVC = CommunityViewController(viewModel: viewModel.communityViewModel)
        let mapVC = MapViewController(viewModel: viewModel.mapViewModel)
        let profileVC = MyPageViewController(viewModel: viewModel.myPageViewModel)
        
        communityVC.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(systemName: "house"), tag: 0)
        mapVC.tabBarItem = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [communityVC, mapVC, profileVC]
        
        // Bind the selected index to the view model
        rx.didSelect
            .map { $0.view.tag }
            .bind(to: viewModel.selectedIndex)
            .disposed(by: disposeBag)
    }
}
