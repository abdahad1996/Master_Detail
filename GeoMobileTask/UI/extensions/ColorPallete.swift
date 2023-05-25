//
//  ColorPallete.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 25/05/2023.
//

import Foundation
import SwiftUI

protocol Palette {
    static var primary: Color { get }
//    static var primaryVariant: Color { get }
    static var secondary: Color { get }
//    static var secondaryVariant: Color { get }
    static var accentColor: Color { get }
    static var background: Color { get }
//    static var frame: Color { get }
    static var error: Color { get }
}
struct LightColorPalette: Palette {
    static var primary = Color(UIColor.black)
//    static var primaryVariant = UIColor.grayDark
    static var secondary = Color(UIColor.gray)
//    static var secondaryVariant = UIColor.grayLight
    static var accentColor = Color(UIColor.green)
    static var background = Color(UIColor.white)
//    static var frame = UIColor.grayDark
    static var error = Color(UIColor.orange)
}
struct DarkColorPalette: Palette {
    static var primary = Color(UIColor.white)
//    static var primaryVariant = ColorPalette.grayLight
    static var secondary = Color(UIColor.gray)
//    static var secondaryVariant = ColorPalette.grayMid
    static var accentColor = Color(UIColor.green)
    static var background = Color(UIColor.black)
//    static var frame = ColorPalette.grayLight
    static var error = Color(UIColor.orange)
}

struct OSModeThemeProvider<Content>: View where Content: View {
    @Environment(\.colorScheme) var colorScheme
    let content: (Palette.Type) -> Content
    init(@ViewBuilder content: @escaping (Palette.Type) -> Content) {
        self.content = content
    }
    var body: some View {
        content(colorScheme == .dark ? DarkColorPalette.self : LightColorPalette.self)
    }
}
