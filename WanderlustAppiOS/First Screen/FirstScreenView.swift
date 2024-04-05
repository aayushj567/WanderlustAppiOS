//
//  FirstScreenView.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class FirstScreenView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var tableViewExpense: UITableView!
        

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white

            setupTableViewExpense()

            initConstraints()
        }
        
        func setupTableViewExpense(){
            tableViewExpense = UITableView()
            tableViewExpense.separatorStyle = .none
            tableViewExpense.layer.borderColor = UIColor.white.cgColor
            tableViewExpense.separatorColor = .white
            tableViewExpense.layer.borderColor = .none
            tableViewExpense.register(TableViewContactsCell.self, forCellReuseIdentifier: "contacts")
            tableViewExpense.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tableViewExpense)
        }
        
        func initConstraints(){
            NSLayoutConstraint.activate([
                tableViewExpense.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
                tableViewExpense.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                tableViewExpense.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                tableViewExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
