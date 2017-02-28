//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Alfredo M. on 2/27/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!

    
    //@IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        
        nameLbl.text = pokemon.name.capitalized
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImage.image = img
        currentEvoImg.image = img
        pokedexLbl.text = "\(pokemon.pokedexId)"
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
        

    }

    func updateUI(){
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLabel.text = pokemon.type
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    

}
