//
//  AccountInfoViewModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/26.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewModel{
    
    let validator:Validator = Validator()
    
    let idInput = PublishRelay<String>()
    let pwInput = PublishRelay<String>()
    let pwConfirmInput = PublishRelay<String>()
    
    // MARK: - Output
    var idValid: Observable<Bool> = Observable.just(false)
    var pwValid: Observable<Bool> = Observable.just(false)
    var pwConfirmValid: Observable<Bool> = Observable.just(false)
    var allValid: Observable<Bool> = Observable.just(false)
    
    // MARK: - Initializer
    init() {
        
        idValid = idInput
            .map { [weak self] in self?.validator.validateId($0) ?? false}
            
        pwValid = pwInput
            .map { [weak self] in self?.validator.validatePassword($0) ?? false}
        
        pwConfirmValid = Observable.combineLatest(pwInput, pwConfirmInput)
            .map { $0 == $1 }
        
        allValid = Observable.combineLatest(idValid, pwValid, pwConfirmValid)
            .map { $0 && $1 && $2 }
    }
    
}


