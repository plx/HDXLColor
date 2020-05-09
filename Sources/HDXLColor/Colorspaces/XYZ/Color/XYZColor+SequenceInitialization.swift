//
//  XYZColor+SequenceInitialization.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport
import HDXLAlgebraicUtilities

public extension XYZColor {
  
  @inlinable
  init<S:Sequence>(colors: S)
    where S.Element == XYZColor<Representation> {
      var storage: Storage = Storage()
      for color in colors {
        storage += color.storage
      }
      self.init(
        storage: storage
      )
  }
    
  @inlinable
  init<S:Sequence>(weightedColors: S)
    where S.Element == (Representation,XYZColor<Representation>) {
      var storage: Storage = Storage()
      for (weight,color) in weightedColors {
        storage.addProduct(weight, color.storage)
      }
      self.init(
        storage: storage
      )
  }

  @inlinable
  init<S:Sequence>(weightedColors: S)
    where
    S.Element: AlgebraicProduct2,
    S.Element.A == Representation,
    S.Element.B == XYZColor<Representation> {
      var storage: Storage = Storage()
      for weightedPair in weightedColors {
        storage.addProduct(weightedPair.a, weightedPair.b.storage)
      }
      self.init(
        storage: storage
      )
  }

  @inlinable
  init<S:Sequence>(colors: S)
    where S.Element == XYZColor<Representation>.Storage {
      var storage: Storage = Storage()
      for color in colors {
        storage += color
      }
      self.init(
        storage: storage
      )
  }
    
  @inlinable
  init<S:Sequence>(weightedColors: S)
    where S.Element == (Representation,XYZColor<Representation>.Storage) {
      var storage: Storage = Storage()
      for (weight,color) in weightedColors {
        storage.addProduct(weight, color)
      }
      self.init(
        storage: storage
      )
  }

  @inlinable
  init<S:Sequence>(weightedColors: S)
    where
    S.Element: AlgebraicProduct2,
    S.Element.A == Representation,
    S.Element.B == XYZColor<Representation>.Storage {
      var storage: Storage = Storage()
      for weightedPair in weightedColors {
        storage.addProduct(weightedPair.a, weightedPair.b)
      }
      self.init(
        storage: storage
      )
  }

}
