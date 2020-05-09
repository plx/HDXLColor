//
//  RealizableValue.swift
//

import Foundation

/// Protocol like `Validatable`: `self.isRealizableValue` should be `true` iff
/// the contents of `self` *can* be displayed as-is.
///
/// The motivating use case is that, unfortunately, for this package's colors to
/// be *animatable* within `SwiftUI`'s system, they need to conform to `VectorArithmetic`,
/// but conforming to `VectorArithmetic` requires support of negation (and subtraction).
///
/// This makes a strict conformanace to `Validatable` a non-starter, because we'll
/// often produce invalid colors as intermediate states within our calculations. We
/// can still have a loose `Validatable` that checks only for the component finiteness,
/// but that's a fairly useless check for non-intermediate values.
///
/// For colors, at least, I think it makes sense to have this protocol: `isRealizableValue`
/// is the deeper check--are components in acceptable ranges?--and so I added it.
///
/// I am on the fence with adding property like `nearestRealizableValue: RealizableValue?`
/// that would return the closest-available displayable color--that's useful, but it's also
/// not always defined...and for this and other considerations perhaps an explicit,
/// type-specific API would be the way to go.
///
/// The name of this protocol seems wrong, and I'll need to fix it once I have
/// a better idea.
public protocol RealizableValue {
  
  /// `true` iff the components are within an acceptable range.
  var isRealizableValue: Bool { get }
  
}
