//
//  TrispectralBlend.swift
//

import Foundation
import SwiftUI
import HDXLCommonUtilities
import HDXLSIMDSupport

@frozen
public struct TrispectralBlend<Representation:ColorComponentRepresentation> {
  
  @usableFromInline
  internal typealias Storage = SIMD3<Representation>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  public init() {
    self.init(storage: Storage())
  }
  
  @inlinable
  public init(
    _ x: Representation,
    _ y: Representation,
    _ z: Representation) {
    self.init(
      storage: Storage(x,y,z)
    )
  }
  
  @inlinable
  public init(x: Representation) {
    self.init(
      x,.zero,.zero
    )
  }

  @inlinable
  public init(y: Representation) {
    self.init(
      .zero,y,.zero
    )
  }

  @inlinable
  public init(z: Representation) {
    self.init(
      .zero,.zero,z
    )
  }

}

extension TrispectralBlend : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isFinite
    }
  }
  
}

extension TrispectralBlend : RealizableValue {
  
  @inlinable
  public var isRealizableValue: Bool {
    get {
      return self.storage.isFiniteNonNegative
    }
  }
  
}

extension TrispectralBlend : Equatable {
  
  @inlinable
  public static func ==(
    lhs: TrispectralBlend<Representation>,
    rhs: TrispectralBlend<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }
  
}

extension TrispectralBlend : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.storage.hash(into: &hasher)
  }
  
}

extension TrispectralBlend : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(\(self.storage[0]), \(self.storage[1]), \(self.storage[2]))"
    }
  }
  
}

extension TrispectralBlend : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "TrispectralBlend<\(String(reflecting: Representation.self))>(storage: \(String(reflecting: self.storage)))"
    }
  }
  
}

extension TrispectralBlend : Codable {

  // synthesized ok
  
}

extension TrispectralBlend : AdditiveArithmetic {
  
  @inlinable
  public static var zero: TrispectralBlend<Representation> {
    get {
      return TrispectralBlend<Representation>()
    }
  }
  
  @inlinable
  public static func +(
    lhs: TrispectralBlend<Representation>,
    rhs: TrispectralBlend<Representation>) -> TrispectralBlend<Representation> {
    return TrispectralBlend<Representation>(
      storage: lhs.storage + rhs.storage
    )
  }

  @inlinable
  public static func +=(
    lhs: inout TrispectralBlend<Representation>,
    rhs: TrispectralBlend<Representation>) {
    lhs.storage += rhs.storage
  }

  @inlinable
  public static func -(
    lhs: TrispectralBlend<Representation>,
    rhs: TrispectralBlend<Representation>) -> TrispectralBlend<Representation> {
    return TrispectralBlend<Representation>(
      storage: lhs.storage - rhs.storage
    )
  }

  @inlinable
  public static func -=(
    lhs: inout TrispectralBlend<Representation>,
    rhs: TrispectralBlend<Representation>) {
    lhs.storage -= rhs.storage
  }

}

extension TrispectralBlend : VectorArithmetic {
  
  @inlinable
  public var magnitudeSquared: Double {
    get {
      return Double(
        (self.storage * self.storage).sum()
      )
    }
  }
  
  @inlinable
  public mutating func scale(by factor: Double) {
    self.storage *= Representation(factor)
  }

}
