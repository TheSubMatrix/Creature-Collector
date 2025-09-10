//
//  main.swift
//  Creature Collector
//
//  Created by Colin Whiteford on 9/10/25.
//

import Foundation
enum CreatureType : String
{
    case Fire = "Fire"
    case Water = "Water"
    case Air = "Air"
    case Earth = "Earth"
}
class Creature : Equatable
{
    static func == (lhs: Creature, rhs: Creature) -> Bool
    {
        return lhs.NameOfCreature == rhs.NameOfCreature
    }
    
    var NameOfCreature: String
    var LevelOfCreature: UInt
    var TypeOfCreature: CreatureType
    
    init(nameOfCreature:String, typeOfCreature: CreatureType)
    {
        NameOfCreature = nameOfCreature
        LevelOfCreature = 1
        TypeOfCreature = typeOfCreature
    }
    
    func Train()
    {
        LevelOfCreature += 1
        print(NameOfCreature + " is now level " + String(LevelOfCreature))
    }
    
    func DisplayCreatureInfo()
    {
        print("Name: " + NameOfCreature)
        print("Level: " + String(LevelOfCreature))
        print("Type: " + TypeOfCreature.rawValue)
    }
}

var possibleCreatures =
[
    Creature(nameOfCreature: "Dragon", typeOfCreature: CreatureType.Fire),
    Creature(nameOfCreature: "Phoenix", typeOfCreature: CreatureType.Fire),
    Creature(nameOfCreature: "Shark", typeOfCreature: CreatureType.Water),
    Creature(nameOfCreature: "Octopus", typeOfCreature: CreatureType.Water),
    Creature(nameOfCreature: "Eagle", typeOfCreature: CreatureType.Air),
    Creature(nameOfCreature: "Bat", typeOfCreature: CreatureType.Air),
    Creature(nameOfCreature: "Worm", typeOfCreature: CreatureType.Earth),
    Creature(nameOfCreature: "Mole", typeOfCreature: CreatureType.Earth),
]

func TryAndCatchCreature() -> Creature?
{
    let chanceToCatch = 50
    let caught = Int.random(in: 0...100) <= chanceToCatch
    if !caught { return nil; }
    let creature = possibleCreatures[Int.random(in: 0...possibleCreatures.count - 1)]
    possibleCreatures.removeAll(where: {$0 == creature})
    return creature
}

func ShowInventory()
{
    for i in playerInventory
    {
        i.DisplayCreatureInfo()
        print("-----------------------")
    }
}

//---------------------------------------------
var gameOver = false
var playerInventory:Array<Creature> = []
print("Welcome to Creature Collector! Type 1 to try and catch a creature. Type 2 to view your inventory. Type 3 to select a creature to train. Collect 3 creatures to win!")
repeat
{
    var inputValid = false
    repeat
    {
        if let playerInput = Int(readLine()!)
        {
            switch playerInput
            {
            case 1:
                inputValid = true
                if possibleCreatures.count > playerInventory.count, let creature = TryAndCatchCreature()
                {
                    print("You caught a " + creature.NameOfCreature)
                    playerInventory.append(creature)
                }
                else
                {
                    print("You failed to catch a creature")
                }
            case 2:
                ShowInventory()
                inputValid = true
            case 3:
                var selectionValid = false
                repeat
                {
                    print("Select a creature to train")
                    if let selection = Int(readLine()!), case 0...playerInventory.count-1 = selection
                    {
                        playerInventory[selection].Train()
                        selectionValid = true
                    }
                    else
                    {
                        print("Could not train")
                        break;
                    }
                }while selectionValid == false
                inputValid = true
            default:
                inputValid = false
            }
        }
    }while !inputValid
}while playerInventory.count < 3
