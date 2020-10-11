//
//  ImageViewController.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import UIKit

fileprivate struct Constants {
    static let imageCellReuseIdentifier = "ItemsCell"
    static let refreshControlTitle = "Pull down to refresh..."
}

class ImageViewController: MainViewController {
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    weak var coorodinator: MainCoordinator? //Coordinator that handles navigation
    private let imageTableView = UITableView()
    private var safeArea: UILayoutGuide!
    private let imageListViewModel = FactListViewModel()
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: Constants.refreshControlTitle)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    //--------------------------------------------------------------------------
    // MARK: - View lifecycle
    //--------------------------------------------------------------------------
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFactsData()
    }
}

private extension ImageViewController {
    
    //--------------------------------------------------------------------------
    // MARK: - Private methods
    //--------------------------------------------------------------------------
    
    func configureView() {
        view.addSubview(imageTableView)
        
        imageTableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.imageCellReuseIdentifier)
        
        imageTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageTableView.topAnchor.constraint(equalTo:safeArea.topAnchor),
            imageTableView.leftAnchor.constraint(equalTo:view.leftAnchor),
            imageTableView.rightAnchor.constraint(equalTo:view.rightAnchor),
            imageTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor),
        ])
        
        imageTableView.dataSource = self
        imageTableView.delegate = self
        
        imageTableView.rowHeight = UITableView.automaticDimension
        imageTableView.estimatedRowHeight = 300
        
        imageTableView.refreshControl = refreshControl
    }
    
    func getFactsData() {
        guard self.isConnectionAvailable() else {
            self.showAlert(with: NetworkError.noInternetConnection.errorDescription ?? "No Connectivity Available")
            return
        }
        
        self.showLoader()
        imageListViewModel.getImages(completion: { [weak self] error in
            guard error == nil else {
                self?.hideLoader()
                self?.showAlert(with: error?.localizedDescription ?? "Something went wrong")
                return
            }

            ThreadHelper.mainThreadAsync {
                self?.hideLoader()
                self?.imageTableView.reloadData()
                self?.updateTitle()
            }
        })
    }
    
    @objc
    private func pullToRefresh() {
        getFactsData()
        refreshControl.endRefreshing()
    }
    
    private func updateTitle() {
        self.title = imageListViewModel.factTitle
    }
}

extension ImageViewController: UITableViewDataSource, UITableViewDelegate {
    
    //--------------------------------------------------------------------------
    // MARK: - Tableview methods
    //--------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageListViewModel.facts.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ImageTableViewCell else { return }
        
        cell.loadImage(with: imageListViewModel.facts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.imageCellReuseIdentifier, for: indexPath) as! ImageTableViewCell
        
        cell.configureCell(with: imageListViewModel.facts[indexPath.row])
        
        return cell
    }
}
