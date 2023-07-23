//
//  TestViewController.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/07/15.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import KakaoSDKUser
import GoogleSignIn

class TestViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var appleEndLinkButton = UIButton()
    private lazy var appleLogoutButton = UIButton()
    private lazy var googleEndLinkButton = UIButton()
    private lazy var googleLogoutButton = UIButton()
    private lazy var kakaoEndLinkButton = UIButton()
    private lazy var kakaoLogoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        [appleLogoutButton,appleEndLinkButton,googleLogoutButton,googleEndLinkButton,kakaoLogoutButton,kakaoEndLinkButton]
            .forEach { UIButton in
                view.addSubview(UIButton)
            }
        
        //MARK: signupButton Attribute
        appleLogoutButton.titleLabel?.textAlignment = .center
        appleLogoutButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        appleLogoutButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        appleLogoutButton.layer.cornerRadius = 8
        appleLogoutButton.layer.borderWidth = 1
        appleLogoutButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        appleLogoutButton.setTitle("애플로그아웃", for: .normal)
        
        //MARK: signupButton Layout
        appleLogoutButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(136*Constants.standardWidth)
            make.top.equalToSuperview().offset(321*Constants.standardHeight)
        }
        
        
        appleEndLinkButton.titleLabel?.textAlignment = .center
        appleEndLinkButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        appleEndLinkButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        appleEndLinkButton.layer.cornerRadius = 8
        appleEndLinkButton.layer.borderWidth = 1
        appleEndLinkButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        appleEndLinkButton.setTitle("애플탈퇴", for: .normal)
        
        //MARK: signupButton Layout
        appleEndLinkButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(321*Constants.standardHeight)
        }
        
        //MARK: signupButton Attribute
        googleLogoutButton.titleLabel?.textAlignment = .center
        googleLogoutButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        googleLogoutButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        googleLogoutButton.layer.cornerRadius = 8
        googleLogoutButton.layer.borderWidth = 1
        googleLogoutButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        googleLogoutButton.setTitle("구글로그아웃", for: .normal)
        
        //MARK: signupButton Layout
        googleLogoutButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(136*Constants.standardWidth)
            make.top.equalToSuperview().offset(521*Constants.standardHeight)
        }
        
        
        googleEndLinkButton.titleLabel?.textAlignment = .center
        googleEndLinkButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        googleEndLinkButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        googleEndLinkButton.layer.cornerRadius = 8
        googleEndLinkButton.layer.borderWidth = 1
        googleEndLinkButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        googleEndLinkButton.setTitle("구글탈퇴", for: .normal)
        
        //MARK: signupButton Layout
        googleEndLinkButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(521*Constants.standardHeight)
        }
        
        //MARK: signupButton Attribute
        kakaoEndLinkButton.titleLabel?.textAlignment = .center
        kakaoEndLinkButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        kakaoEndLinkButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        kakaoEndLinkButton.layer.cornerRadius = 8
        kakaoEndLinkButton.layer.borderWidth = 1
        kakaoEndLinkButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        kakaoEndLinkButton.setTitle("카카오회원탈퇴", for: .normal)
        
        //MARK: signupButton Layout
        kakaoEndLinkButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(721*Constants.standardHeight)
        }
        
        
        kakaoLogoutButton.titleLabel?.textAlignment = .center
        kakaoLogoutButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        kakaoLogoutButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        kakaoLogoutButton.layer.cornerRadius = 8
        kakaoLogoutButton.layer.borderWidth = 1
        kakaoLogoutButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        kakaoLogoutButton.setTitle("카카오로그아웃", for: .normal)
        
        //MARK: signupButton Layout
        kakaoLogoutButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(136*Constants.standardWidth)
            make.top.equalToSuperview().offset(721*Constants.standardHeight)
        }
        
        appleEndLinkButton.rx.tap
            .subscribe(onNext: {
                
                print("애플로그인언링크 성공")
            })
            .disposed(by: disposeBag)
        
        googleLogoutButton.rx.tap
            .subscribe(onNext: {
                GIDSignIn.sharedInstance.signOut()
                print("구글로그아웃 성공")
            })
            .disposed(by: disposeBag)
        
        googleEndLinkButton.rx.tap
            .subscribe(onNext: {
                GIDSignIn.sharedInstance.disconnect { error in
                    guard error == nil else { return }
                    print("구글로그인언링크 성공")
                    // Google Account disconnected from your app.
                    // Perform clean-up actions, such as deleting data associated with the
                    //   disconnected account.
                }
            })
            .disposed(by: disposeBag)

        kakaoLogoutButton.rx.tap
            .subscribe(onNext: { [self] in
                UserApi.shared.rx.logout()
                    .subscribe(onCompleted:{
                        print("logout() success.")
                    }, onError: {error in
                        print(error)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        kakaoEndLinkButton.rx.tap
            .subscribe(onNext: { [self] in
                UserApi.shared.rx.unlink()
                    .subscribe(onCompleted:{
                        print("unlink() success.")
                    }, onError: {error in
                        print(error)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
    }
    

}
