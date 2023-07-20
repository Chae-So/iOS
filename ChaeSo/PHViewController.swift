import UIKit
import PhotosUI
import SnapKit

class PHViewController: UIViewController {
    

    lazy var imageView = UIImageView()
    
    //라이브러리에서 가져온 사진 저장할 공간
    var itemProviders: [NSItemProvider] = []
    var iterator: IndexingIterator<[NSItemProvider]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = .blue
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }


    func displayNextImage() {
        if let itemProvider = iterator?.next(), itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = imageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.imageView.image == previousImage else { return }
                    self.imageView.image = image
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        displayNextImage()
    }
}

extension PHViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in

                self.itemProviders = results.map(\.itemProvider)
                self.iterator = self.itemProviders.makeIterator()
                self.displayNextImage()
                
            }
        }
    }
}
