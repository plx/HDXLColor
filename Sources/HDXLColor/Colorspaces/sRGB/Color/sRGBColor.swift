//
//  sRGBColor.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport
import HDXLInterpolation

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Definition
// -------------------------------------------------------------------------- //

public struct sRGBColor<Representation:ColorComponentRepresentation> {
  
  public typealias Storage = SIMD3<Representation>
  
  @usableFromInline
  internal var _storage: Storage
  
  @inlinable
  public var storage: Storage {
    get {
      return self._storage
    }
  }
    
  @inlinable
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(storage.isFiniteNonNegative)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = storage
  }
  
  @inlinable
  public init(
    r: Representation,
    g: Representation,
    b: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(r.isFiniteNonNegative)
    pedantic_assert(g.isFiniteNonNegative)
    pedantic_assert(b.isFiniteNonNegative)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = Storage(
      r,
      g,
      b
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Property Exposure
// -------------------------------------------------------------------------- //

public extension sRGBColor {
  
  @inlinable
  var r: Representation {
    get {
      return self._storage[sRGBColorComponent.r]
    }
    set {
      self._storage[sRGBColorComponent.r] = newValue
    }
  }
  
  @inlinable
  var g: Representation {
    get {
      return self._storage[sRGBColorComponent.g]
    }
    set {
      self._storage[sRGBColorComponent.g] = newValue
    }
  }

  @inlinable
  var b: Representation {
    get {
      return self._storage[sRGBColorComponent.b]
    }
    set {
      self._storage[sRGBColorComponent.b] = newValue
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Validatable
// -------------------------------------------------------------------------- //

extension sRGBColor : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        self._storage.isFiniteNonNegative else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Equatable
// -------------------------------------------------------------------------- //

extension sRGBColor : Equatable {
  
  @inlinable
  public static func ==(
    lhs: sRGBColor<Representation>,
    rhs: sRGBColor<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage == rhs._storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Hashable
// -------------------------------------------------------------------------- //

extension sRGBColor : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._storage.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension sRGBColor : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "linear-rgb: (\(self.r), \(self.g), \(self.b))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension sRGBColor : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "sRGBColor<\(String(reflecting: Representation.self))>(r: (\(self.r), g: \(self.g), b: \(self.b))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Codable
// -------------------------------------------------------------------------- //

extension sRGBColor : Codable where Representation:Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - ExpressibleByArrayLiteral
// -------------------------------------------------------------------------- //

extension sRGBColor : ExpressibleByArrayLiteral {
  
  public typealias ArrayLiteralElement = Representation
  
  @inlinable
  public init(arrayLiteral elements: ArrayLiteralElement...) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    guard
      elements.count == 3,
      elements.allSatisfy({$0.isFiniteNonNegative}) else {
      fatalError("Tried to construct a literal `sRGBColor<\(String(reflecting: Representation.self))>` with \(elements.count) elements (instead of 3): \(elements.description)!")
    }
    self.init(
      r: elements[0],
      g: elements[1],
      b: elements[2]
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColor - Blendable
// -------------------------------------------------------------------------- //

extension sRGBColor : Blendable {
  
  public typealias BlendingWeight = Representation
  
  @inlinable
  public init(
    byBlending first: sRGBColor<Representation>,
    weight firstWeight: Representation,
    with other: sRGBColor<Representation>,
    weight otherWeight: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(first.isValid)
    pedantic_assert(firstWeight.isFiniteNonNegative)
    pedantic_assert(other.isValid)
    pedantic_assert(otherWeight.isFiniteNonNegative)
    // /////////////////////////////////////////////////////////////////////////
    self.init(
      storage: (
        (first._storage * firstWeight)
        +
        (other._storage * otherWeight)
      )
    )
  }
  
}
