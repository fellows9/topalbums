//
//  AlbumDetailsViewController.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    var album: Album?

    let albumIconImageView: DownloadableImageView = {
        let img = DownloadableImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .aqua
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    let viewAlbumButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .aqua
        button.setTitleColor(.white, for: .normal)
        button.setTitle("View album in Apple Music", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(viewAlbumButtonTapped),for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let spaceView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func loadView() {
        super.loadView()

        navigationController?.navigationBar.tintColor = .aqua
        setupView()
        configureAlbumInfo()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(albumIconImageView)
        view.addSubview(additionalInfoLabel)
        view.addSubview(spaceView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(artistLabel)
        view.addSubview(containerView)
        view.addSubview(viewAlbumButton)

        albumIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        albumIconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        albumIconImageView.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        additionalInfoLabel.topAnchor.constraint(equalTo: albumIconImageView.bottomAnchor, constant: 5).isActive = true
        additionalInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        additionalInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        spaceView.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor).isActive = true
        spaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        spaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        containerView.centerYAnchor.constraint(equalTo: spaceView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: spaceView.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: spaceView.trailingAnchor, constant: -15).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        artistLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        viewAlbumButton.topAnchor.constraint(equalTo: spaceView.bottomAnchor).isActive = true
        viewAlbumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        viewAlbumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        viewAlbumButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        viewAlbumButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func configureAlbumInfo() {
        guard let album = album else { return }
        albumIconImageView.loadThumbnail(with: album.artworkUrl100)
        additionalInfoLabel.text = album.otherInfo
        titleLabel.text = album.name
        artistLabel.text = album.artistName
    }
    
    @objc func viewAlbumButtonTapped() {
        if let url = album?.url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
