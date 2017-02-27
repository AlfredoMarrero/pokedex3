//
//  Pokemon.swift
//  pokedex3
//
//  Created by Alfredo M. on 2/27/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    
    var name: String {
        return _name
    }

    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }

}
