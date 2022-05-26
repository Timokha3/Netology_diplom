//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Timur on 02.05.2022.
//

import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func buttonTap()
}

class PhotosTableViewCell: UITableViewCell {
    weak var delegate: PhotosTableViewCellDelegate?
    
    var photos: [String] = []
    
    private let photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(PhotosCollectionViewCellForTableView.self, forCellWithReuseIdentifier: PhotosCollectionViewCellForTableView.identifier)
        return collection
    }()
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "headingLabel"
        return label
    }()
    
    func update(_ heading: String) {
        headingLabel.text = heading
    }
    
    private lazy var allPhotosBottom: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .clear
        b.tintColor = .black
        b.addTarget(self, action: #selector(goToPhotos), for: .touchUpInside)
        return b
    }()
    
    @objc private func goToPhotos() {
        delegate?.buttonTap()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        photoCollection.delegate = self
        photoCollection.dataSource = self
        let inset: CGFloat = 12
        
        [headingLabel, photoCollection, allPhotosBottom].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            //label
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            //button
            allPhotosBottom.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor),
            allPhotosBottom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            //collection
            photoCollection.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: inset),
            photoCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset - 8),
            photoCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset + 8),
            photoCollection.heightAnchor.constraint(equalToConstant: 100),
            photoCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
// MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCellForTableView.identifier, for: indexPath) as! PhotosCollectionViewCellForTableView
        cell.update(photos[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.width - sideInset * 3) / 4
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.item)
    }
}
