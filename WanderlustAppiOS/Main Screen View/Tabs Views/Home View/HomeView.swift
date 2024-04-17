//
//  MainScreenView.swift
//  WA5_Jaiswal_6534
//
//  Created by Aayush Jaiswal on 2/17/24.
//

import UIKit

class HomeView: UIView {
    var contactsTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupContactTableView()
        initConstraints()
    }
    
    func setupContactTableView(){
        contactsTableView = UITableView()
        contactsTableView.register(PlansTableViewCell.self, forCellReuseIdentifier: "Plan info")
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contactsTableView)
    }
    
    //MARK: setting the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            contactsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            contactsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contactsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

