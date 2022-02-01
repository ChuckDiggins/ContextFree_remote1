//
//  JSONWordCollectionStructs.swift
//  JSONWordCollectionStructs
//
//  Created by Charles Diggins on 1/26/22.
//

import Foundation



var carpenterWordCollection = JSONCollectionStruct(idNum: 0, collectionName: "Carpenter1", wordList: CarpenterWordList)

var threeSimpleVerbsCollection = JSONCollectionStruct(idNum: 1, collectionName: "3 simple verbs",
                                                wordList: [
                                                    JSONWord(spanish: "comer", english: "eat", french: "manger", wordType: "verb"),
                                                    JSONWord(spanish: "hablar", english: "talk", french: "boire", wordType : "verb"),
                                                    JSONWord(spanish: "vivir", english: "live", french: "habiter", wordType : "verb"),
                                                ])

var ThreeSimpleVerbs: [JSONWord] = [
    JSONWord(spanish: "comer", english: "eat", french: "manger", wordType: "verb"),
    JSONWord(spanish: "hablar", english: "talk", french: "boire", wordType : "verb"),
    JSONWord(spanish: "vivir", english: "live", french: "habiter", wordType : "verb"),
]

var TenCommonVerbs: [JSONWord] = [
    JSONWord(spanish: "buscar", english: "look for",    french: "chercher", wordType: "verb"),
    JSONWord(spanish: "comprar", english: "buy",    french: "acheter", wordType: "verb"),
    JSONWord(spanish: "conocer", english: "know",    french: "connaître", wordType: "verb"),
    JSONWord(spanish: "dar", english: "give",    french: "donner", wordType: "verb"),
    JSONWord(spanish: "decir", english: "say",   french: "dire", wordType: "verb"),
    JSONWord(spanish: "escribir", english: "write",    french: "écrire", wordType: "verb"),
    JSONWord(spanish: "esperar", english: "wait",    french: "attendre", wordType: "verb"),
    JSONWord(spanish: "pedir", english: "ask",    french: "demander", wordType: "verb"),
    JSONWord(spanish: "querer", english: "want",    french: "vouloir", wordType: "verb"),
    JSONWord(spanish: "tener", english: "have", french: "avoir", wordType: "verb"),
]

var CarpenterWordList: [JSONWord] = [
    JSONWord(spanish: "siempre", english: "always", french: "toujours", wordType: "adverb"),
    JSONWord(spanish: "nunca", english: "never", french: "jamais", wordType: "adverb"),
    JSONWord(spanish: "todos los dias", english: "everyday", french: "tous les jours", wordType: "adverb"),
    
    JSONWord(spanish: "dulce", english: "sweet", french: "douce", wordType: "adjective"),
    JSONWord(spanish: "salado", english: "salty", french: "salé", wordType: "adjective"),
    JSONWord(spanish: "sabroso", english: "tasty", french: "délicieux", wordType: "adjective"),
    JSONWord(spanish: "picante", english: "spicy", french: "épicé", wordType: "adjective"),
    
    JSONWord(spanish: "con", english: "with", french: "avec", wordType: "preposition"),
    JSONWord(spanish: "sin", english: "without", french: "sans",wordType: "preposition"),
    
    JSONWord(spanish: "desayuno", english: "breakfast",    french: "petir déjeuner", wordType: "noun"),
    JSONWord(spanish: "cereal", english: "cereal",    french: "céréale", wordType: "noun"),
    JSONWord(spanish: "huevo", english: "egg",    french: "œef", wordType: "noun"),
    JSONWord(spanish: "pan", english: "bread",    french: "pain", wordType: "noun"),
    JSONWord(spanish: "pan tostado", english: "toast",    french: "toast", wordType: "noun"),
    JSONWord(spanish: "plátano", english: "banana",    french: "banane", wordType: "noun"),
    JSONWord(spanish: "salchicha", english: "sausage",    french: "sausisse", wordType: "noun"),
    JSONWord(spanish: "tocino", english: "bacon",    french: "bacon", wordType: "noun"),
    JSONWord(spanish: "yogur", english: "yogurt",    french: "yaourt", wordType: "noun"),
    JSONWord(spanish: "almuerzo", english: "lunch",    french: "déjeuner", wordType: "noun"),
    JSONWord(spanish: "ensalada", english: "salad",    french: "salade", wordType: "noun"),
    JSONWord(spanish: "fresa", english: "strawberry",    french: "fraisier", wordType: "noun"),
    JSONWord(spanish: "galleta", english: "cookie",    french: "gâteau", wordType: "noun"),
    JSONWord(spanish: "hamburguesa", english: "hamburger",    french: "hamburger", wordType: "noun"),
    JSONWord(spanish: "jamón", english: "ham",    french: "jambon", wordType: "noun"),
    JSONWord(spanish: "papas fritas", english: "French fries",    french: "frites", wordType: "noun"),
    JSONWord(spanish: "manzana", english: "apple",    french: "pomme", wordType: "noun"),
    JSONWord(spanish: "naranja", english: "orange",    french: "orange", wordType: "noun"),
    JSONWord(spanish: "perro caliente", english: "hot dog",    french: "hot-dog", wordType: "noun"),
    JSONWord(spanish: "pizza", english: "pizza",    french: "pizza", wordType: "noun"),
    JSONWord(spanish: "queso", english: "cheese",    french: "fromage", wordType: "noun"),
    JSONWord(spanish: "sándwich de jamón y queso", english: "ham and cheese sandwich",    french: "sandwich jambon-fromage", wordType: "noun"),
    JSONWord(spanish: "sopa", english: "soup",    french: "soupe", wordType: "noun"),
    JSONWord(spanish: "sopa de verduras", english: "vegetable soup",    french: "soupe aux légumes", wordType: "noun"),
    JSONWord(spanish: "pollo", english: "chicken",    french: "poulet", wordType: "noun"),
    JSONWord(spanish: "sal", english: "salt",    french: "sel", wordType: "noun"),
    JSONWord(spanish: "pimienta", english: "pepper",    french: "poivre", wordType: "noun"),
    JSONWord(spanish: "azúcar", english: "sugar",    french: "sucre", wordType: "noun"),

    JSONWord(spanish: "comer", english: "eat", french: "manger", wordType: "verb"),
    JSONWord(spanish: "beber", english: "drink", french: "boire", wordType: "verb"),
    JSONWord(spanish: "gustar", english: "be pleasing to", french: "aimer", wordType: "verb"),
    ]
