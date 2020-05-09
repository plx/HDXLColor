//
//  LCHColor.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport
import HDXLInterpolation

// -------------------------------------------------------------------------- //
// MARK: LCHColor - Definition
// -------------------------------------------------------------------------- //

public struct LCHColor<Representation:ColorComponentRepresentation> {
  
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
    l: Representation,
    c: Representation,
    h: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(l.isFiniteNonNegative)
    pedantic_assert(c.isFiniteNonNegative)
    pedantic_assert(h.isFiniteNonNegative)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = Storage(
      l,
      c,
      h
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - Property Exposure
// -------------------------------------------------------------------------- //

public extension LCHColor {
  
  @inlinable
  var l: Representation {
    get {
      return self._storage[LCHColorComponent.l]
    }
    set {
      self._storage[LCHColorComponent.l] = newValue
    }
  }
  
  @inlinable
  var c: Representation {
    get {
      return self._storage[LCHColorComponent.c]
    }
    set {
      self._storage[LCHColorComponent.c] = newValue
    }
  }

  @inlinable
  var h: Representation {
    get {
      return self._storage[LCHColorComponent.h]
    }
    set {
      self._storage[LCHColorComponent.h] = newValue
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - Validatable
// -------------------------------------------------------------------------- //

extension LCHColor : Validatable {
  
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
// MARK: LCHColor - Equatable
// -------------------------------------------------------------------------- //

extension LCHColor : Equatable {
  
  @inlinable
  public static func ==(
    lhs: LCHColor<Representation>,
    rhs: LCHColor<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage == rhs._storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - Hashable
// -------------------------------------------------------------------------- //

extension LCHColor : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._storage.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension LCHColor : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "lch: (\(self.l), \(self.c), \(self.h))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension LCHColor : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "LCHColor<\(String(reflecting: Representation.self))>(l: (\(self.l), c: \(self.h), h: \(self.h))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - Codable
// -------------------------------------------------------------------------- //

extension LCHColor : Codable where Representation:Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - ExpressibleByArrayLiteral
// -------------------------------------------------------------------------- //

extension LCHColor : ExpressibleByArrayLiteral {
  
  public typealias ArrayLiteralElement = Representation
  
  @inlinable
  public init(arrayLiteral elements: ArrayLiteralElement...) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    guard
      elements.count == 3,
      elements.allSatisfy({$0.isFiniteNonNegative}) else {
      fatalError("Tried to construct a literal `LCHColor<\(String(reflecting: Representation.self))>` with \(elements.count) elements (instead of 3): \(elements.description)!")
    }
    self.init(
      l: elements[0],
      c: elements[1],
      h: elements[2]
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColor - Blendable
// -------------------------------------------------------------------------- //

extension LCHColor : Blendable {
  
  public typealias BlendingWeight = Representation
  
  @inlinable
  public init(
    byBlending first: LCHColor<Representation>,
    weight firstWeight: Representation,
    with other: LCHColor<Representation>,
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
