import UIKit
import RxCocoa
import RxSwift
import RxKakaoSDKUser
import KakaoSDKUser
import GoogleSignIn

class LoginViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    let navigationControllerSubject = BehaviorSubject<UINavigationController?>(value: nil)

    // Input
    let loginText = BehaviorRelay<String>(value: "")
    let appleLoginButtonText = BehaviorRelay<String>(value: "")
    let googleLoginButtonText = BehaviorRelay<String>(value: "")
    let kakaoLoginButtonText = BehaviorRelay<String>(value: "")
    let tomatoLoginButtonText = BehaviorRelay<String>(value: "")
    let isFirstVisitLabelText = BehaviorRelay<String>(value: "")
    let signupButtonText = BehaviorRelay<String>(value: "")
    
    let googleButtonTapped = PublishRelay<Void>()
    let kakaoButtonTapped = PublishRelay<Void>()
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        googleButtonTapped
            .subscribe(onNext: { [self] in
                guard let navigationController = try? navigationControllerSubject.value() else {
                    // 적절한 navigationController를 찾지 못한 경우 처리
                    return
                }
                let presentingViewController = navigationController.topViewController
                GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController!) { signInResult, error in
                    guard error == nil else { return }
                    guard let signInResult = signInResult else { return }
                    
                    let user = signInResult.user
                    
                    
                    let emailAddress = user.profile?.email
                    
                    let fullName = user.profile?.name
                    let givenName = user.profile?.givenName
                    let familyName = user.profile?.familyName
                    
                    let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                    print("user.refreshToken",user.refreshToken)
                    print("user.accessToken",user.accessToken)
                    print("user.idToken",user.idToken)
                    print("user.userID",user.userID)
                    print("user.profile?.name",user.profile?.name)
                }
            })
            .disposed(by: disposeBag)
        
        kakaoButtonTapped
            .subscribe(onNext: { [self] in
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.rx.loginWithKakaoTalk()
                        .subscribe(onNext:{ [weak self] (oauthToken) in
                            guard let self = self else {return}
                            print("loginWithKakaoTalk() success.")
                        
                            //do something
                            _ = oauthToken
                            print("oauthToken",oauthToken)
                            self.getKakaoUserInfo()
                        }, onError: {error in
                            print(error)
                        })
                    .disposed(by: disposeBag)
                }
                else {

                    // 카톡 없으면 -> 계정으로 로그인
                    UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                        guard let self = self else {return}
                        if let error = error {
                            print(error)
                        } else {
                            print("카카오 계정으로 로그인 성공")
                            
                            _ = oauthToken
                            print("oauthToken",oauthToken)
                            self.getKakaoUserInfo()
                            let testViewController = TestViewController()
                            //self.navigationController?.pushViewController(testViewController, animated: true)
                            // 관련 메소드 추가
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        

        
    }
    
    private func updateLocalization() {
        loginText.accept(localizationManager.localizedString(forKey: "Login"))
        appleLoginButtonText.accept(localizationManager.localizedString(forKey: "Sign in with Apple"))
        googleLoginButtonText.accept(localizationManager.localizedString(forKey: "Sign in with Google"))
        kakaoLoginButtonText.accept(localizationManager.localizedString(forKey: "Sign in with Kakao"))
        tomatoLoginButtonText.accept(localizationManager.localizedString(forKey: "Login in with ID"))

        isFirstVisitLabelText.accept(localizationManager.localizedString(forKey: "Is this your first visit to CHAESO?"))
        signupButtonText.accept(localizationManager.localizedString(forKey: "Sign Up"))
    }
    
    
    private func getKakaoUserInfo() {
        
        
        UserApi.shared.rx.me()
            .subscribe (onSuccess:{ user in
                print("me() success.")
                
                let nickname = user.kakaoAccount?.profile?.nickname
                let email = user.kakaoAccount?.email
                
                print("nickname",nickname)
                print("email",email)
                
                
            }, onFailure: {error in
                print(error)
            })
            .disposed(by: disposeBag)
        
    }
    
}

