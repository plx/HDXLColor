//
//  View+IndirectColor.swift
//

import Foundation
import SwiftUI

public extension View {
  
  @inlinable
  func foregroundColor<K:IndirectColor>(_ indirectColor: K?) -> some View {
    return self.foregroundColor(indirectColor?.body)
  }
  
  @inlinable
  func foregroundColor<K:ColorProvider>(_ colorProvider: K?) -> some View {
    return self.foregroundColor(colorProvider?.toSwiftUIColor())
  }

}
