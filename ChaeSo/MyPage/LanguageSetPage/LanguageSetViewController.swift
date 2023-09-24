//
//  LanguageSetViewController.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/08/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class LanguageSetViewController: UIViewController {
    let disposeBag = DisposeBag()
    let languageSetViewModel: LanguageSetViewModel
    
    private lazy var titleLabel = UILabel()
    private lazy var leftButton = UIButton()
    private lazy var separateView = UIView()
    private lazy var koButton = UIButton()
    private lazy var enButton = UIButton()
    
    // MARK: - Initializers
    
    init(languageSetViewModel: LanguageSetViewModel) {
        self.languageSetViewModel = languageSetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
        leftButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        languageSetViewModel.titleText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        languageSetViewModel.koText
            .bind(to: koButton.rx.title())
            .disposed(by: disposeBag)
        
        languageSetViewModel.enText
            .bind(to: enButton.rx.title())
            .disposed(by: disposeBag)
        
        koButton.rx.tap
            .map { "ko" }
            .bind(to: languageSetViewModel.languageSelected)
            .disposed(by: disposeBag)
        
        enButton.rx.tap
            .map { "en" }
            .bind(to: languageSetViewModel.languageSelected)
            .disposed(by: disposeBag)
        
        languageSetViewModel.languageSelected
            .subscribe(onNext: { [weak self] language in
                guard let self = self else { return }
                print(language)
                if language == "ko"{
                    self.koButton.setImage(UIImage(named: "checkFill"), for: .normal)
                    self.enButton.setImage(UIImage(named: "check"), for: .normal)
                }
                else{
                    self.enButton.setImage(UIImage(named: "checkFill"), for: .normal)
                    self.koButton.setImage(UIImage(named: "check"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    
    
    
    
    func attribute(){
        view.backgroundColor = UIColor(named: "sbgColor")
        
        titleLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        }
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")
        
        koButton.do{
            $0.backgroundColor = .white
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(.black, for: .normal)
            $0.semanticContentAttribute = .forceLeftToRight
            $0.sizeToFit()
            $0.layer.cornerRadius = 8 * Constants.standardHeight
            $0.contentHorizontalAlignment = .left
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: -180)
        }
        
        enButton.do{
            $0.backgroundColor = .white
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.setTitleColor(.black, for: .normal)
            $0.semanticContentAttribute = .forceLeftToRight
            $0.sizeToFit()
            $0.layer.cornerRadius = 8 * Constants.standardHeight
            $0.contentHorizontalAlignment = .left
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: -180)
        }
        
    }
    
    func layout(){
        [titleLabel,leftButton,separateView,koButton,enButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
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
        
        koButton.snp.makeConstraints { make in
            make.width.equalTo(342*Constants.standardWidth)
            make.height.equalTo(50*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom).offset(22*Constants.standardHeight)
        }
        
        enButton.snp.makeConstraints { make in
            make.width.equalTo(342*Constants.standardWidth)
            make.height.equalTo(50*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(koButton.snp.bottom).offset(10*Constants.standardHeight)
        }
        
    }
}
