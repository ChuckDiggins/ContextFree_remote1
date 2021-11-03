//
//  SemanticsEnum.swift
//  SemanticsEnum
//
//  Created by Charles Diggins on 11/1/21.
//

import Foundation
//"Lexical Semantics of Adjectives.  A microtheory of Adjectival Meaning"  by Raskin and Nirenburg


enum AdjectiveSemanticsEnums{
    enum Dimension {
        case big, large, little, small, long, short, wide, narrow, thick, fat, thin
    }
    
    enum PhysicalProperty {
        case hard, soft, heavy, light, rough, smooth, hot, cold, sweet, sour
    }
    
    enum Color {
        case black, white, red, green, yellow, orange, purple, gray, maroon
    }
    
    enum Age {
        case old, young, ancient, new
    }
    
    enum Value {
        case good, bad, proper, perfect, excellent, fine, delicious, attrocious, poor, great
    }
    
    enum HumanPropensity {
        case jealous, happy, kind, clever, generous, gay, cruel, rude, proud, wicked, evil
    }
}

var ase = AdjectiveSemanticsEnums.Dimension.big
