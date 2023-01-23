//
//  CollectionReusableView.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 27/12/22.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
        
    lazy var headerLabel = {
        
        let label  = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment  = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview(headerLabel)
        
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo:  topAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
