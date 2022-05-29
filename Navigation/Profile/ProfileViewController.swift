//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Timur on 30.04.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let imageNameList: [String] = ["83051881-df79-4c2a-897d-4e3c8ee326d3", "9add457d-9f51-4d8f-a7f6-2f0bc7a25d34", "c19ce1bf-e323-491d-99bc-f9867caf1052", "2c537e75-db79-435e-92e9-c564d6b156fc", "11166a73-426d-48c1-840f-c20e6ed325f5", "610b7bf2-27a6-4401-b145-c077298683f3", "c54a8355-46bb-4a74-b4ef-802fba169c5b", "efb5b24c-3a2f-4b6c-875a-0084d6062b38", "b0e20333-3dfc-489f-b70a-35f378be3814", "a6dc92db-1961-452e-b258-00f290c566c9", "7a2f86df-9f68-43e7-a8e9-a98b07d35968", "d11688d8-379e-4371-bcc7-ecd4eb97ec5f", "589e1d76-11ac-4ba9-992f-0724848b6c71", "d1ab3bbf-6022-4583-9050-97019963a78b", "91821987-65ba-472e-b8d3-72388e52c15a", "610b7bf2-27a6-4401-b145-c077298683f3", "c54a8355-46bb-4a74-b4ef-802fba169c5b", "efb5b24c-3a2f-4b6c-875a-0084d6062b38", "b0e20333-3dfc-489f-b70a-35f378be3814", "a6dc92db-1961-452e-b258-00f290c566c9"]
    
    var section: [String] {["Photos", "News"]}
    var posts: [Post] = Post.makeMockModel()
    
    private lazy var profileHeaderView: UIView = {
        let pfView = ProfileHeaderView()
        pfView.translatesAutoresizingMaskIntoConstraints = false
        pfView.backgroundColor = .systemGroupedBackground
        return pfView
    }()
    
    private lazy var postTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
        //setupGestures()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Новости"
    }
    
    private func configure() {
        view.addSubview(postTable)

        NSLayoutConstraint.activate([
            postTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            postTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            postTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            postTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            
            profileHeaderView.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            //profileHeaderView.heightAnchor.constraint(equalToConstant: self.view.bounds.width / 2)
            
        ])
    }
}

//MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? profileHeaderView : nil
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            cell.photos = imageNameList
            cell.delegate = self
            cell.update(section[0])
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.update(posts[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        if indexPath.section == 0 {
            buttonTap()
        } else {
            posts[indexPath.row].views += 1
            postTable.reloadRows(at: [indexPath], with: .none)
            showPost(indexPath: indexPath)
        }
    }
    
    private func showPost(indexPath: IndexPath) {
        let postVC = PostViewController()
        postVC.setup(post: posts[indexPath.row])
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ProfileViewController: PostTableViewCellDelegate {
    func likeLabelTapping(indexPath: IndexPath) {
        posts[indexPath.row].likes += 1
        postTable.reloadRows(at: [indexPath], with: .none)
    }
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func buttonTap() {
        let photosVC = PhotosViewController()
        photosVC.photos = imageNameList
        navigationController?.pushViewController(photosVC, animated: true)
    }
}
