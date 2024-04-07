import Foundation

struct Menu: Codable {
    let coldApetizersAndSalads: [MenuItem]
    let hotApetizers: [MenuItem]
    let pizzaRossa: [MenuItem]
    let pizzaBianca: [MenuItem]
    let pizzaSpecial: [MenuItem]
    let calzoni: [MenuItem]
    let pastaFresca: [MenuItem]
    let desserts: [MenuItem]
    let drinks: DrinkMenu
    
    init(
        coldApetizersAndSalads: [MenuItem] = [],
        hotApetizers: [MenuItem] = [],
        pizzaRossa: [MenuItem] = [],
        pizzaBianca: [MenuItem] = [],
        pizzaSpecial: [MenuItem] = [],
        calzoni: [MenuItem] = [],
        pastaFresca: [MenuItem] = [],
        desserts: [MenuItem] = [],
        drinks: DrinkMenu = DrinkMenu()
    ) {
        self.coldApetizersAndSalads = coldApetizersAndSalads
        self.hotApetizers = hotApetizers
        self.pizzaRossa = pizzaRossa
        self.pizzaBianca = pizzaBianca
        self.pizzaSpecial = pizzaSpecial
        self.calzoni = calzoni
        self.pastaFresca = pastaFresca
        self.desserts = desserts
        self.drinks = drinks
    }
}

struct MenuItem: Codable {
    let name: String
    let price: Int
    let description: String
}

struct DrinkMenu: Codable {
    let coldDrinks: [DrinkMenuItem]
    let italianColdDrinks: [DrinkMenuItem]
    let hotDrinks: [DrinkMenuItem]
    let alcoholFreeDrinks: [DrinkMenuItem]
    let wine: [DrinkMenuItem]
    
    init(
        coldDrinks: [DrinkMenuItem] = [],
        italianColdDrinks: [DrinkMenuItem] = [],
        hotDrinks: [DrinkMenuItem] = [],
        alcoholFreeDrinks: [DrinkMenuItem] = [],
        wine: [DrinkMenuItem] = []
    ) {
        self.coldDrinks = coldDrinks
        self.italianColdDrinks = italianColdDrinks
        self.hotDrinks = hotDrinks
        self.alcoholFreeDrinks = alcoholFreeDrinks
        self.wine = wine
    }
}

struct DrinkMenuItem: Codable {
    let name: String
    let price: Int
}

