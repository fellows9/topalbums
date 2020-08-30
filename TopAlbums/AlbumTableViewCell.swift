//
//  AlbumTableViewCell.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    let albumIconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .aqua
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none

        contentView.addSubview(albumIconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(artistLabel)
        contentView.addSubview(containerView)
        
        albumIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        albumIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        albumIconImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        albumIconImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: albumIconImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        artistLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }

}
