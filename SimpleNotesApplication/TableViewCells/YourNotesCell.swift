//
//  YourNotesCell.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 19/12/22.
//

import UIKit

class YourNotesCell: UITableViewCell {
    
    
    var date: String?
    
    lazy var titleLabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold, width: .standard)
        label.textColor = .systemBlue
        
        return label
        
    }()
    
    lazy var descriptionLabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 6
      
        return label
        
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        activateConstraints()
    }

    
   
    func activateConstraints() {
        

        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
            
        ])
        
    
    }
    
    
    func setTitleAndDesc(_ title:String,_ description:String,_ date:String) {
        
        titleLabel.text = title
        descriptionLabel.text = description
        self.date = date
    }
 }


