import UIKit

// CollectionViewController
class CollectionViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set up the collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        
        // register a cell class for the collection view
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // set the collection view data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // add the collection view as a subview
        view.addSubview(collectionView)
        
        // set the collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of images
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeue a cell from the collection view
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // create an image view if not exists
        if cell.imageView == nil {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            cell.contentView.addSubview(imageView)
            
            // set the image view constraints
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
            
            // store the image view in the cell property
            cell.imageView = imageView
        }
        
        // get the image from the array and set it to the image view
        let image = images[indexPath.item]
        cell.imageView?.image = image
        
        // return the cell
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // get the selected image from the array and show it in a new view controller
        let image = images[indexPath.item]
        let vc = ImageViewController()
        vc.image = image
        present(vc, animated: true)
    }
}

// ImageViewController
class ImageViewController: UIViewController {
    let imageView = UIImageView()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the image view
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        // add the image view as a subview
        view.addSubview(imageView)
        
        // set the image view constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // add a tap gesture recognizer to dismiss the view controller when tapped on the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissSelf() {
        // dismiss the view controller
        dismiss(animated: true)
    }
}

// UICollectionViewCell extension to store a weak reference to an image view
extension UICollectionViewCell {
    private struct AssociatedKeys {
      static var imageViewKey = "imageViewKey"
    }

    weak var imageView: UIImageView? {
      get {
          return objc_getAssociatedObject(self, &AssociatedKeys.imageViewKey) as? UIImageView
      }
      set(newValue) {
          objc_setAssociatedObject(self, &AssociatedKeys.imageViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
      }
    }
}
