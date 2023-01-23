//
//  Header.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 19/12/22.
//

import UIKit

class Header: UITableViewHeaderFooterView {
    
    lazy var headerLabel = {
        
        let label  = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment  = .left
        
        return label
        
    }()
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerLabel)
     
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    

    func setText(_ priority:Priority) {
       
        switch priority {
      
        case .high:
            headerLabel.textColor = .black
        case .medium:
            headerLabel.textColor = .systemGray
        case .pinned:
            headerLabel.textColor = .systemPink
        }
      
        headerLabel.text = priority.rawValue
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
