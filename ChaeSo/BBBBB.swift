import UIKit
import RxSwift
import RxCocoa
import Alamofire

import Foundation




class BBBBB: UIViewController {
    
    private let baseURL = "https://apis.data.go.kr/B551011/GreenTourService1/areaBasedList1"
        private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters: [String: String] = [
            "MobileOS": "IOS",
            "MobileApp": "Chaeso",
            "areaCode": "6",
            "_type": "json",
            "serviceKey": "baUzHe88eAYK43DCQFlep1DxNZUQyLnobW3qM0mq9o1IL2h5CAZTaQsiF+hyXr8NJVJvYs5lQnCh+CQft6zuZQ=="
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        

        
        AF.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print(String(data: data, encoding: .utf8) ?? "Invalid data")
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    



