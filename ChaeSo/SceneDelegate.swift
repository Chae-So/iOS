import UIKit
import CoreLocation
import RxKakaoSDKAuth
import KakaoSDKAuth
import Photos
import GoogleSignIn
import AuthenticationServices


class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        //let rootViewController = LoginViewController(loginViewModel: LoginViewModel(localizationManager: LocalizationManager.shared))
        //let rootViewController = StartViewController(startViewModel: StartViewModel(localizationManager: LocalizationManager.shared))
        let rootViewController = SearchingViewController(searchingViewModel: SearchingViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared))

        //let rootViewController = VeganViewController(veganViewModel: VeganViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = VeganStoryViewController(veganStoryViewModel: VeganStoryViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = TabBarController(tabBarViewModel: TabBarViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = NicknameViewController(nicknameViewModel: NicknameViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = MainPTCollectionViewController(mainPTCollectionViewModel: MainPTCollectionViewModel())
        
        //let rootViewController = WriteReviewViewController(writeReviewViewModel: WriteReviewViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = WriteChaesoLogViewController(writeChaesoLogViewModel: WriteChaesoLogViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = CommunityViewController(communityViewModel: CommunityViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = CommentViewController(commentViewModel: CommentViewModel(localizationManager: LocalizationManager.shared))
        
        //let rootViewController = MapViewController(mapViewModel: MapViewModel(localizationManager: LocalizationManager.shared) )
        
        //let rootViewController = BBBBB()
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        window?.makeKeyAndVisible()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        //MARK: appleAutoLogin
//        if let userID = UserDefaults.getAppleUserID() {
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            appleIDProvider.getCredentialState(forUserID: userID) { [weak self] (credentialState, error) in
//                guard let self = self else { return }
//                switch credentialState {
//                case .authorized:
//                    print("authorized")
//                    DispatchQueue.main.async {
////                        let rootViewController = MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared), ptCollectionViewModel: PTCollectionViewModel())
////                        self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
////                        self.window?.makeKeyAndVisible()
//                        let loginViewController = TestViewController()
//                        let navigationController = UINavigationController(rootViewController: loginViewController)
//
//                        self.window?.rootViewController = navigationController
//                        self.window?.makeKeyAndVisible()
//                    }
//                case .revoked:
//                    print("revoked")
//                    let rootViewController = StartViewController(startViewModel: StartViewModel(localizationManager: LocalizationManager.shared))
//                    self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
//                    self.window?.makeKeyAndVisible()
//
//                case .notFound:
//                    print("notFound")
//                    let rootViewController = StartViewController(startViewModel: StartViewModel(localizationManager: LocalizationManager.shared))
//                    self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
//                    self.window?.makeKeyAndVisible()
//                default:
//                    break
//                }
//            }
//        }
//
//        //MARK: googleAutoLogin
//        GIDSignIn.sharedInstance.restorePreviousSignIn { [self] user, error in
//            if error != nil || user == nil {
//                // Show the app's signed-out state.
//                print("구글자동로그인 불가")
//                let rootViewController = StartViewController(startViewModel: StartViewModel(localizationManager: LocalizationManager.shared))
//                self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
//                self.window?.makeKeyAndVisible()
//
//            } else {
//                // Show the app's signed-in state.
//                print("구글자동로그인")
//                let loginViewController = TestViewController()
//                let navigationController = UINavigationController(rootViewController: loginViewController)
//
//                self.window?.rootViewController = navigationController
//                self.window?.makeKeyAndVisible()
//
//            }
//        }
        
    }
    
   

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .restricted, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showSettingsAlert()
        @unknown default:
            return
        }
    }

    
    
    func photoAuthorization(){
        switch PHPhotoLibrary.authorizationStatus() {
        case .denied:
            print("거부")
            showSettingsAlert()
        case .authorized:
            print("허용")
        case .limited:
            print("선택 사진 허용")
            
        case .notDetermined, .restricted:
            print("아직 결정하지 않은 상태")
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] (state) in
                if state == .authorized || state == .limited{
                    
                } else {
                    if let rootVC = self!.window?.rootViewController {
                        rootVC.dismiss(animated: true)
                    }
                }
            }
        default:
            break
        }
    }
    
    func showSettingsAlert() {
        let alert = UIAlertController(title: "알림", message: "사진 권한이 필요합니다. 설정에서 변경해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "설정", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        if let rootVC = window?.rootViewController {
            rootVC.present(alert, animated: true, completion: nil)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

