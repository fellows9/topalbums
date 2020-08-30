//
//  AlbumsViewController.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView: UITableView = .init()
    let viewModel: AlbumsViewModel = .init()
    var overlayView: UIView?
    var activityView: UIActivityIndicatorView?
    
    override func loadView() {
        super.loadView()

        view.backgroundColor = .white
        navigationItem.title = "Top 100 Albums"
        setupTableView()
        showActivityIndicator()
        viewModel.loadDataSource { [weak self] (result) in
            self?.activityView?.stopAnimating()
            switch result {
            case .success(_):
                self?.tableView.reloadData()
                self?.overlayView?.isHidden = true
            case .failure(_):
                let alert = UIAlertController(title: "Oops", message: "Something went wrong, please try again!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func showActivityIndicator() {
        let overView = UIView(frame: view.frame)
        overView.backgroundColor = .white
        overlayView = overView
        view.addSubview(overView)

        let atvView = UIActivityIndicatorView(style: .large)
        atvView.center = overView.center
        activityView = atvView
        overlayView?.addSubview(atvView)
        activityView?.startAnimating()
    }

    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        let album = viewModel.dataSource[indexPath.row]
        cell.titleLabel.text = album.name
        cell.artistLabel.text = album.artistName
        cell.albumIconImageView.loadThumbnail(with: album.artworkUrl100)
        
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.dataSource[indexPath.row]
        let albumDetailsVC = AlbumDetailsViewController()
        albumDetailsVC.album = album
        navigationController?.pushViewController(albumDetailsVC, animated: true)
    }
}

