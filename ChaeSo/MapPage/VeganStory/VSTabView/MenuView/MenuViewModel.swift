//
//  MenuViewModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/08/20.
//

import RxSwift
import RxCocoa

class MenuViewModel{
    let disposeBag = DisposeBag()
    
    let menuList = BehaviorRelay<[Menu]>(value: [])
    
    init(){
        menuList.accept([Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000"),Menu(menuImage: UIImage(named: "tomato")!, menuName: "토마토", menuPrice: "6,000")])
    }
    
}
