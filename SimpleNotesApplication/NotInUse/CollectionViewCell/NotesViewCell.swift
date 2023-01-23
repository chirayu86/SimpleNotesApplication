//
//  NotesViewCell.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 26/12/22.
//

import UIKit

class NotesViewCell: UICollectionViewCell {
    
    var date: String?
    
    lazy var titleLabel = {
       
        let view  = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
        view.textColor = .systemBlue
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
        
    }()
    
    lazy var descriptionView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var descriptionLabel = {
        
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 5
        view.textAlignment = .justified
        return view
        
    }()
    
   
    
    
   
    
    
    override init(frame: CGRect) {
        
       super.init(frame: .zero)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 4
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionView)
        descriptionView.addSubview(descriptionLabel)
        
        setLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor,constant: -5),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor,constant: 5),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: descriptionView.bottomAnchor, constant: -5)
            
     

        ])
    
      
    }
    
    func setTitleAndDescription(_ title:String,_ description:String,_ date:String) {
      
        titleLabel.text = title
        descriptionLabel.text = description
        self.date = date
        
    }
    
    
   
}
