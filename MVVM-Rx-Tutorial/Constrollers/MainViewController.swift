//
//  MainViewController.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import UIKit
import RxSwift
// observer로 받은 데이터를 subscribe 하기 위해 BehaviorRelay로 담아 준다.
// accept 메서드를 통해 데이터를 받을 수 있다.
import RxRelay

class MainViewController: UIViewController {

    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel: MainViewModel
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero,
                                  collectionViewLayout: UICollectionViewFlowLayout())
        
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        
        return cv
    }()
    
    // 초기값 필요 error나 complete이 발생해도 작업을 계속 이어나간다.
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    
    // 외부에서 접근할 수 있게 Observable로 변환 (구독)
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    // MARK: - LifeCycles
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configureCollectionView()
        fetchArticles()
        subscribe()
    }

    // MARK: - Configure
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        self.title = self.viewModel.title
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
    }
    
    // MARK: - Helpers
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }).disposed(by: disposeBag)
    }

}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        
        cell.imageView.image = nil
        
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    
}
