//
//  HomeViewController.swift
//  Overwatch Failure
//
//  Created by Jessica Wu on 3/21/21.
//

import Foundation
import UIKit

class templateCell: UITableViewCell{
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var totalMatchLabelOutlet: UILabel!
    @IBOutlet weak var lossInRowLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 20
    }
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var templateTableViewOutlet: UITableView!
    var gameTemplates: [GameSessionTemplate] = []
    
    override func viewDidLoad() {
        templateTableViewOutlet.dataSource = self
        templateTableViewOutlet.delegate = self
        
//        let template = GameSessionTemplate(name: "OW", totalMatch: 0, lossInRow: 9)
//        let template2 = GameSessionTemplate(name: "LOL", totalMatch: 0, lossInRow: 9)
//        let templates = GameSessionTemplates(templates: [template, template2])
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(templates) {
//            let defaults = UserDefaults.standard
//            defaults.set(encoded, forKey: defaultsKeys.GameSessionTemplatesKey)
//        }
        parseGameSessionTemplates()
    }
    
    func parseGameSessionTemplates(){
        let defaults = UserDefaults.standard
        if let savedTemplates = defaults.object(forKey: defaultsKeys.GameSessionTemplatesKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedTemplates = try? decoder.decode(GameSessionTemplates.self, from: savedTemplates) {
                gameTemplates = loadedTemplates.templates
                templateTableViewOutlet.reloadData()
            }
        }
    }
    
    // MARK: -UITableView Implementation
    // return number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameTemplates.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // actual cell
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "templateCell") as? templateCell ?? templateCell(style: .value1, reuseIdentifier: "templateCell")
            
            let index = indexPath.row/2
            cell.nameLabelOutlet.text = gameTemplates[index].name
            cell.lossInRowLabelOutlet.text = "Loss in Row: \( gameTemplates[index].lossInRow)"
            cell.totalMatchLabelOutlet.text = "Total Match: \( gameTemplates[index].totalMatch)"
            
            // style cell
            cell.layer.cornerRadius = 20
            return cell
        }
        // separator
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "separatorCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "separatorCell")
            
            cell.backgroundColor = UIColor.systemBackground
            cell.isUserInteractionEnabled = false
            
            // style cell
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            return cell
        }
    }
    
    // selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row / 2
        let selectedTemplate = gameTemplates[index]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let SessionViewController = storyboard.instantiateViewController(identifier: "SessionViewController") as? SessionViewController else {
            assertionFailure("cannot instantiate SessionViewController")
            return
        }
        SessionViewController.template = selectedTemplate
        navigationController?.pushViewController(SessionViewController, animated: true)
        
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            // remove the item from the data model
            gameTemplates.remove(at: indexPath.row/2)

            // update user default
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(GameSessionTemplates(templates: gameTemplates)) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: defaultsKeys.GameSessionTemplatesKey)
            }
            
            // delete the table view row
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section);
            tableView.deleteRows(at: [indexPath, nextIndexPath], with: .fade)
        }
    }
    
    // return table cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            // cell height
            return CGFloat(130)
        }
        else{
            // separator heigh
            return CGFloat(20)
        }
    }
    
    
}
