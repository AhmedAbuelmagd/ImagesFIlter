//
//  Colors.swift
//  ImagesFIlter
//
//  Created by Ahmed Abuelmagd on 23/11/2022.
//

import UIKit

//MARK: - Colors Enum
enum Colors: String, CaseIterable {
    case C000000 = "#000000"
    case C7B8497 = "#7B8497"
    case CE5E6EA = "#E5E6EA"
    case CFFFFFF = "#FFFFFF"
    case C515D76 = "#515D76"
    case CBDC1CB = "#BDC1CB"
    case C485369 = "#485369"
    case CF6F7F8 = "#F6F7F8"
    case CD5F3FD = "#D5F3FD"
    case CA8AEBB = "#A8AEBB"
    case C828B9D = "#828B9D"
    case CB7BDC7 = "#B7BDC7"
    case C00FF00 = "#00FF00"
    case CFE8B8A = "#FE8B8A"
    case C3CB5B7 = "#3CB5B7"
    case C5D9AFF = "#5D9AFF"
    case CFEAD7E = "#FEAD7E"
    case C65D6B8 = "#65D6B8"
    case CF77DB7 = "#F77DB7"
    case C0DACE4 = "#0DACE4"
    case CD9F0E1 = "#D9F0E1"
    case CE5F4F9 = "#E5F4F9"
    case C007DAB = "#007DAB"
    case CEBEBEB = "#EBEBEB"
    case CF8F8F8 = "#F8F8F8"
    case CDEE0E5 = "#DEE0E5"
    case CEEF7FD = "#EEF7FD"
    case C00DE00 = "#00DE00"
    case C069ED3 = "#069ED3"
    case MainColor = "#2CC1F5"
    case CFF6767 = "#FF6767"
    case MGradient = "#######"
    case MainGBGOne = "#00AAE9"
    case MainGBGTwo = "#55D6FF"
    case C11B3EE = "#11B3EE"
    case CF5F5F5 = "#F5F5F5"
    case CDADADA = "#DADADA"
    case CF3F3F3 = "#F3F3F3"
    case CEDEDED = "#EDEDED"
    case CA08600 = "#A08600"
    case CFF6666 = "#FF6666"
    case CEAF9FE = "#EAF9FE"
   
    
    var hex: UIColor {
        return UIColor(hexString: self.rawValue)
    }
    var cgColor: CGColor {
        return UIColor(hexString: self.rawValue).cgColor
    }
}

