//
//  SceneDelegate.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/26.
//

import UIKit
import RxKakaoSDKAuth
import KakaoSDKAuth
import Photos
import GoogleSignIn
import AuthenticationServices


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    //var rootViewModel = StartViewModel(localizationManager: LocalizationManager.shared)
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        //let rootViewController = StartViewController(startViewModel: rootViewModel)
        //let rootViewController = MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared), ptCollectionViewModel: PTCollectionViewModel())
        
        var rootViewModel = VeganViewModel(localizationManager: LocalizationManager.shared)
        let rootViewController = VeganViewController(veganViewModel: rootViewModel)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
        
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
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
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

