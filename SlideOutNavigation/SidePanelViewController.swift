//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import LBTAComponents

protocol SidePanelViewControllerDelegate {
  func animalSelected(_ animal: Animal)
}

class SidePanelViewController: UIViewController {
  
    let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var delegate: SidePanelViewControllerDelegate?
  
  var animals: Array<Animal>!
  
  struct TableView {
    struct CellIdentifiers {
      static let AnimalCell = "AnimalCell"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add to view
    view.addSubview(tableView)
    
    //place in view
    tableView.fillSuperview()
    
    tableView.reloadData()
  }
  
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return animals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.AnimalCell, for: indexPath) as! AnimalCell
    
    cell.configureForAnimal(animals[indexPath.row])
    return cell
  }
  
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedAnimal = animals[indexPath.row]
    
    delegate?.animalSelected(selectedAnimal)
  }
  
}

class AnimalCell: UITableViewCell {
    
    var animalImageView: UIImageView? = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    weak var imageNameLabel: UILabel? = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    weak var imageCreatorLabel: UILabel? = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let padding: CGFloat = 5
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .blue
        
        contentView.addSubview(animalImageView!)
        contentView.addSubview(imageNameLabel!)
        contentView.addSubview(imageCreatorLabel!)
        
        animalImageView?.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        imageNameLabel?.anchor(topAnchor, left: animalImageView?.rightAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 20)
        imageCreatorLabel?.anchor(imageNameLabel?.bottomAnchor, left: imageNameLabel?.leftAnchor, bottom: nil, right: nil, topConstant: 2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 20)
    }
    
    func configureForAnimal(_ animal: Animal) {
        animalImageView!.image = animal.image
        imageNameLabel!.text = animal.title
        imageCreatorLabel!.text = animal.creator
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
