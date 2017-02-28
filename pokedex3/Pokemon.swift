//
//  Pokemon.swift
//  pokedex3
//
//  Created by Alfredo M. on 2/27/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!//
    private var _height: String!//
    private var _weight: String!//
    private var _attack: String!//
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var pokedexId: Int {
        
        if _pokedexId == nil {
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String{
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolution: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    
    
    init (name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    
    func downloadPokemonDetail( completed: @escaping DownloadComplete) {
        
        let url = URL(string: _pokemonURL)!
        //print (_pokemonURL!)
        Alamofire.request(url).responseJSON { response in
            guard let dataDictionary = response.result.value as? Dictionary<String, AnyObject> else {
                print ("Unable to get dictionary from \(response.result)")
                return
            }
            
            guard let attack = dataDictionary ["attack"] as? Int else {
                print ("Can not find key attack in \(dataDictionary)")
                return
            }
            self._attack = "\(attack)"
            
            
            
            guard let height = dataDictionary ["height"] as? String else {
                print("Cannot find key height in \(dataDictionary)")
                return
            }
            self._height = height
            
            guard let weight = dataDictionary["weight"] as? String else {
                print ("Cannot find key weight in \(dataDictionary))")
                return
            }
            self._weight = weight
            
            guard let defense = dataDictionary ["defense"] as? Int else {
                print("Cannot find key defense in \(dataDictionary)")
                return
            }
            self._defense = "\(defense)"
            
            guard let types = dataDictionary["types"] as? [Dictionary <String, AnyObject>] else {
                print ("Cannot find key types in \(dataDictionary)")
                return
            }
            
            var text = ""
            for type in types {
                guard let name = type["name"] as? String else {
                    print("Cannot find key type in \(type)")
                    return
                }
                if text == "" {
                    text = "\(name)"
                }else {
                    text += "/\(name)"
                }
            }
            
            self._type = text.capitalized
            
            print ("+++++++++++++++++++++++++++++++++++++++++    +++++++++++++++   +++")
            print (self._type)
            
            
            completed()
        }
        
        
    }
    
}
