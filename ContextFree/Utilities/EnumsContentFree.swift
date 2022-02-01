//
//  EnumsContentFree.swift
//  EnumsContentFree
//
//  Created by Charles Diggins on 11/26/21.
//

import Foundation

public enum ContextFreeFunction : String, CaseIterable {
    case Subject = "Subject"
    case DirectObject = "Direct Object"
    case IndirectObject = "Indirect Object"
    case Prepositional = "Prepositional"
    case HeadVerb = "Head Verb"
    case None = "Undefined"
}


public enum ContextFreeSymbol : String, CaseIterable {
    case arrow = "->"
    case AMB
    case UNK = "UNK"
    case punct = "Punct"
    case comma = ","
    case period = "."
    case colon = ":"
    case semiColon = ";"
    case singleQuote = "'"
    case doubleQuote = "\""
    case questionMark = "?"
    case exclamationMark = "!"
    
    case N = "N"
    case ProperName = "PropN"
    case PersPro = "PersPro"
    case Pronoun = "Pronoun"

    case ReflP = "ReflP"
    case ImpP = "ImpP"
    case RelP = "RelP"
    case IntP = "IntP"
    case DemP = "DemP"
    
    case Part = "Participle"
    case Art = "ART"
    case Det = "DET"
    case Adj = "ADJ"
    case Num = "NUM"
    case Adv = "ADV"
    case P = "PREP"
    case PrepToA = "PREP2A"
    case C = "CONJ"
    
    case V = "V"
    case AuxV = "AuxV"
    case ModalAuxV = "ModalAuxV"
    case PassiveAuxV = "PassiveAuxV"
    case PerfV = "PerfV"
    case ProgV = "ProgV"
    case PastPV = "PPV"
    case GV = "GV"
    case SV = "SV"

    case AP = "AP"
    case NP = "NP"
    case PP = "PP"
    case VP = "VP"
    case VinfP = "VinfP"
    case Vger = "VgerP"
    case AdvP = "AdvP"

    case Cls = "Clause"
    case InDCls = "InDepCls"
    case DCls = "DepCls"
    case RCls = "RelCls"
    case AdjCls = "AdjCls"
    case AdvCls = "AdvCls"
    case NCls = "NCls"
    case S = "S"   //sentence
    
    public func isSingle()->Bool{
        switch self{
        case .N, .ProperName, .PersPro, .ReflP, .ImpP, .RelP, .IntP, .DemP:return true
        case .V, .AuxV, .PerfV, .ProgV, .PastPV, .GV, .SV: return true
        case .Art, .Det, .Adj, .Num, .Adv, .P, .PrepToA, .C: return true
        default: return false
        }
    }

    public func isPhrase()->Bool{
        switch self{
        case .AP, .NP, .PP, .VP, .VinfP, .Vger, .AdvP: return true
        default: return false
        }
    }
    
    public func isClause()->Bool{
        switch self{
        case .DCls, .RCls, .AdjCls, .AdvCls, .NCls, .S: return true
        default: return false
        }
    }
    
    public func getWordType(str: String)->ContextFreeSymbol{
        switch str{
        case "NP":  return .NP
        case "VP": return  .VP
        case "PP": return .PP
        case "Art": return .Art
        case "Adj": return .Adj
        case "Adv": return .Adv
        case "C": return .C
        case "N": return .N
        case "V": return .V
        case "P": return .P
        case "PersPro": return .PersPro
        case "?": return .questionMark
        default: return .AMB
        }
    }
    
   }
