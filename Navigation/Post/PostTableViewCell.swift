//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Timur on 30.04.2022.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func likeLabelTapping(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    public var indexPath: IndexPath?
    weak var delegate: PostTableViewCellDelegate?
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "authorLabel"
        return label
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "lakeLabel"
        return label
    }()
    
    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "viewLabel"
        return label
    }()
    
    private lazy var stackViewLikesAndViewsHorizontal: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .clear
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "descriptionLabel"
        return label
    }()
    
    func update(_ post: Post) {
        authorLabel.text = post.author
        postImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likeLabel.text = "Likes: \(post.likes)"
        viewLabel.text = "Views: \(post.views)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupLikeLabelTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLikeLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.likeLabel.isUserInteractionEnabled = true
        self.likeLabel.addGestureRecognizer(labelTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
        delegate?.likeLabelTapping(indexPath: self.indexPath!)
    }
    
    private func configure() {
        let inset: CGFloat = 16
        
        [likeLabel, viewLabel].forEach {
            stackViewLikesAndViewsHorizontal.addArrangedSubview($0)
        }
        
        [authorLabel, postImageView, descriptionLabel, stackViewLikesAndViewsHorizontal].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            //author
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            //image
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            //description
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            //stack
            stackViewLikesAndViewsHorizontal.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            stackViewLikesAndViewsHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            stackViewLikesAndViewsHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            stackViewLikesAndViewsHorizontal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
