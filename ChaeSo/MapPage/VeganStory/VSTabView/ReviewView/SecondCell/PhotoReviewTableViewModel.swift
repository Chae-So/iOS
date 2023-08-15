//
//  PhotoReviewTableViewModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/08/13.
//

import RxSwift
import RxCocoa

class PhotoReviewTableViewModel{
    let images = BehaviorRelay<[UIImage]>(value: [])
    
    private let disposeBag = DisposeBag()

        init() {
            images.subscribe(onNext: { _ in
                print("이미지들어옴")
            }).disposed(by: disposeBag)
        }
}
