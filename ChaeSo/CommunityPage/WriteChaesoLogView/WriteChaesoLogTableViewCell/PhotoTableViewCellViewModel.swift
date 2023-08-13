//
//  PhotoTableViewCellViewModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/08/10.
//

import Foundation
import RxSwift
import RxCocoa

class PhotoTableViewCellViewModel: PhotoViewModelProtocol{
    
    var selectedPhotosRelay: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
}
