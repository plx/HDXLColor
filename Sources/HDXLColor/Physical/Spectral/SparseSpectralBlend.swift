//
//  SparseSpectralBlend.swift
//

import Foundation
import SwiftUI
import HDXLCommonUtilities
import HDXLAlgebraicUtilities

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - Definition
// -------------------------------------------------------------------------- //

@frozen
public struct SparseSpectralBlend<Representation:ColorComponentRepresentation> {
  
  @usableFromInline
  internal typealias Storage = [VisibleWavelength<Representation>:Representation]
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.storage = storage
  }
  
  @inlinable
  public init() {
    self.init(storage: [:])
  }
  
  @inlinable
  public init(
    visibleWavelength wavelength: VisibleWavelength<Representation>,
    weight: Representation = 1) {
    self.init(
      storage: [wavelength: weight]
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - Validatable
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.allSatisfy() {
        (wavelength,weight) -> Bool
        in
        return weight.isFinite && wavelength.isValid
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - RealizableValue
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : RealizableValue {
  
  @inlinable
  public var isRealizableValue: Bool {
    get {
      return self.storage.allSatisfy() {
        (wavelength,weight) -> Bool
        in
        return weight.isFiniteNonNegative && wavelength.isRealizableValue
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - Equatable
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : Equatable {
  
  @inlinable
  public static func ==(
    lhs: SparseSpectralBlend<Representation>,
    rhs: SparseSpectralBlend<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - Hashable
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.storage.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "blend of [ \(self.componentDescription) ]"
    }
  }
  
  @inlinable
  internal var componentDescription: String {
    get {
      return self.storage
        .lazy
        .map() {
          (wavelength, weight) -> String
          in
          "\(wavelength.description) @ \(weight)"
        }
        .joined(separator: ", ")
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "SparseSpectralBlend<\(String(reflecting: Representation.self))>(storage: \(self.storage.debugDescription))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - Codable
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - AdditiveArithmetic
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : AdditiveArithmetic {
  
  @inlinable
  public static var zero: SparseSpectralBlend<Representation> {
    get {
      return SparseSpectralBlend<Representation>()
    }
  }
 
  @inlinable
  public static func +(
    lhs: SparseSpectralBlend<Representation>,
    rhs: SparseSpectralBlend<Representation>) -> SparseSpectralBlend<Representation> {
    var larger: SparseSpectralBlend<Representation>.Storage
    let smaller: SparseSpectralBlend<Representation>.Storage
    if lhs.storage.count >= rhs.storage.count {
      larger = lhs.storage
      smaller = rhs.storage
    } else {
      larger = rhs.storage
      smaller = lhs.storage
    }
    guard !smaller.isEmpty else {
      return SparseSpectralBlend<Representation>(storage: larger)
    }
    for (wavelength,weight) in smaller {
      larger[wavelength, default: 0] += weight
    }
    return SparseSpectralBlend<Representation>(
      storage: larger
    )
  }
  
  @inlinable
  public static func +=(
    lhs: inout SparseSpectralBlend<Representation>,
    rhs: SparseSpectralBlend<Representation>) {
    lhs = lhs + rhs
  }

  @inlinable
  public static func -(
    lhs: SparseSpectralBlend<Representation>,
    rhs: SparseSpectralBlend<Representation>) -> SparseSpectralBlend<Representation> {
    var result: SparseSpectralBlend<Representation> = lhs
    result -= rhs
    return result
  }

  @inlinable
  public static func -=(
    lhs: inout SparseSpectralBlend<Representation>,
    rhs: SparseSpectralBlend<Representation>) {
    for (wavelength,weight) in rhs.storage {
      lhs.storage[wavelength, default: 0] -= weight
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: SparseSpectralBlend - VectorArithmetic
// -------------------------------------------------------------------------- //

extension SparseSpectralBlend : VectorArithmetic {
  
  @inlinable
  public var magnitudeSquared: Double {
    get {
      var result: Double = 0
      for weight in self.storage.values {
        let d = Double(weight)
        result += d * d
      }
      return result
    }
  }
  
  @inlinable
  public mutating func scale(by factor: Double) {
    let f = Representation(factor)
    for index in self.storage.indices {
      self.storage.values[index] *= f
    }
  }

}
