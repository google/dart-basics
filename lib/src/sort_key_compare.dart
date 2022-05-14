// Copyright (c) 2022, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Shared logic for ordering and sorting methods that compare their operands
/// using a calculated [sortKey].
///
/// This method obeys the contract of [Comparable].`compareTo`, except by
/// comparing `sortKey(a)` and `sortKey(b)`, rather than [a] and [b].
///
/// Note that the caller must provide a cache, to avoid repeatedly computing
/// the same [sortKey] values. This cache will be mutated by this function.
/// It is expected that all calls to this function within a single ordering
/// or sorting will provide the same cache instance with each call.
int sortKeyCompare<T>(
    T a, T b, Comparable Function(T) sortKey, Map<T, Comparable> sortKeyCache) {
  // Can't use putIfAbsent because that will evaluate sortKey every time,
  // which defeats the point of using a cache.
  final keyA = sortKeyCache[a] ?? sortKey(a);
  final keyB = sortKeyCache[b] ?? sortKey(b);
  if (!sortKeyCache.containsKey(a)) {
    sortKeyCache[a] = keyA;
  }
  if (!sortKeyCache.containsKey(b)) {
    sortKeyCache[b] = keyB;
  }
  return keyA.compareTo(keyB);
}
