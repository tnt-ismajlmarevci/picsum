//
//  PicsumController.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import UIKit
import UIScrollView_InfiniteScroll
import Combine
import Kingfisher

class PicsumController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = PicsumViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    lazy var pullRefresher: UIRefreshControl = {
        let r = UIRefreshControl()
        r.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        r.tintColor = .accentColor
        r.addTarget(self, action: #selector(pullRefresherReload), for: .valueChanged)
        return r
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewModel()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(ImageCCell.self)
        collectionView.registerHeader(HeaderRView.self)
        collectionView.refreshControl = pullRefresher
        collectionView.prefetchDataSource = self
        collectionView.addInfiniteScroll { [weak self] collectionView in
            if let indicator = collectionView.infiniteScrollIndicatorView as? UIActivityIndicatorView {
                indicator.style = .medium
                indicator.color = .accentColor
            }
            self?.viewModel.loadImages()
        }
        collectionView.setShouldShowInfiniteScrollHandler { [weak self] collectionView -> Bool in
            return self?.viewModel.pagination.hasNextPage ?? false
        }
    }
    
    func loadViewModel() {
        viewModel.loadImages(reset: true)
        
        viewModel.$images
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                self?.endReload()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let error = error else { return }
                self?.endReload()
                self?.showErrorAlert(message: error.message)
            }
            .store(in: &cancellables)
    }
    
    func endReload() {
        self.pullRefresher.endRefreshing()
        self.collectionView.reloadData()
        self.collectionView.finishInfiniteScroll()
    }
    
    func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
        if viewModel.pagination.currPage == 1 {
            alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { action in
                self.viewModel.loadImages(reset: true)
            }))
        }
        self.present(alert, animated: true)
    }
    
    @objc
    func pullRefresherReload(_ refreshControl: UIRefreshControl) {
        viewModel.loadImages(reset: true)
    }
}

extension PicsumController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ImageCCell.self, for: indexPath)
        cell.image = viewModel.images[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PicsumDetailsController.create(image: viewModel.images[indexPath.item]), animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return collectionView.dequeueHeader(HeaderRView.self, for: indexPath)
        default:
            fatalError("Error Loading Header...")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 144)
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let url = viewModel.images[indexPath.row].getNormalURL() else { return }
            ImagePrefetcher(urls: [url]).start()
        }
    }
}
