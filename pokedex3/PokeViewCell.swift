//
//  PokeViewCell.swift
//  pokedex3
//
//  Created by Alfredo M. on 2/27/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

class PokeViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(_ pokemon: Pokemon) {
    
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
}
