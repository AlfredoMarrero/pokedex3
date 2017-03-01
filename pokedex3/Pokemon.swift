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
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
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
            
            guard let descriptions = dataDictionary["descriptions"] as? [Dictionary<String, AnyObject>] else {
                print("Cannot find key descriptions in \(dataDictionary)")
                return
            }
            
            if descriptions.count > 0 {
                guard let descriptionUrl = descriptions[0]["resource_uri"] as? String else{
                    print ("Cannot find key resource_url in \(descriptions)")
                    return
                }
                
                
                let url = URL(string: "\(URL_BASE)\(descriptionUrl)")!
                
                Alamofire.request(url).responseJSON { response in
                    
                    guard let responseDictionary = response.result.value as? Dictionary <String, AnyObject> else {
                        print("Cannot fetch data from \(response.result.value)")
                        return
                    }
                    
                    guard let description = responseDictionary["description"] as? String else {
                        
                        print ("Cannot fetch key description from \(responseDictionary))")
                        return
                    }
                    
                    self._description = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                    completed()
                }
            }
            
            guard let evolutionArray = dataDictionary["evolutions"] as?  [Dictionary<String, AnyObject>] else {
                print ("Cannot find key evolutions in \(dataDictionary)")
                return
            }
            
            if evolutionArray.count > 0 {
                
                
                guard let nextEvolutionName = evolutionArray[0]["to"] as? String else {
                    print("Cannot find key to in\(evolutionArray[0])")
                    return
                }
                
                if nextEvolutionName.range(of: "mega") == nil {
                    self._nextEvolutionName = nextEvolutionName
                    
                    guard var evolutionStr = evolutionArray[0]["resource_uri"] as? String else {
                        print ("Cannot find key resource_uri in \(evolutionArray[0])")
                        return
                    }
                    
                    evolutionStr = evolutionStr.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                    evolutionStr = evolutionStr.replacingOccurrences(of: "/", with: "")
                    self._nextEvolutionId = evolutionStr
                    
                    if let Level = evolutionArray [0]["level"] {
                        
                        if let lvl = Level as? Int {
                            self._nextEvolutionLevel = "\(lvl)"
                        }
                        
                    }
                    else {
                        self._nextEvolutionLevel = ""
                        
                    }
                    
                } else {
                    self._nextEvolutionId = ""
                    self._nextEvolutionLevel = ""
                }
                
                print (nextEvolutionName, self._nextEvolutionId, self._nextEvolutionLevel )
            }
            completed()
        }
    }
}
