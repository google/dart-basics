// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Logic shared between [ListBasics]`.slice` and [StringBasics]`.slice` for
/// converting user input values to normalized indices.
///
/// A null return value corresponds to an empty slice.
SliceIndices? sliceIndices(int? start, int? end, int step, int length) {
  if (step == 0) {
    throw ArgumentError('Slice step cannot be zero');
  }

  // Set default values for start and end.
  int _start = start != null ? start : (step > 0 ? 0 : length - 1);
  int _end = end != null
      ? end
      // Because end is exclusive, it should be the first unreachable value in
      // either step direction.
      : (step > 0 ? length : -(length + 1));

  // Convert any end-counted indices (i.e. negative indices) into real indices.
  if (_start < 0) {
    _start = length + _start;
  }
  if (_end < 0) {
    _end = length + _end;
  }

  // Return null for any invalid index orderings.
  //
  // Note that this must occur before index truncation, as truncation could
  // otherwise alter the ordering because start and end are not truncated to
  // the same bounds.
  if ((_start == _end) ||
      (step > 0 && _start > _end) ||
      (step < 0 && _start < _end)) {
    return null;
  }

  // Truncate indices to allowed bounds.
  if (_start < 0) {
    _start = 0;
  } else if (_start > length - 1) {
    _start = length - 1;
  }
  if (_end < -1) {
    _end = -1;
  } else if (_end > length) {
    _end = length;
  }

  return SliceIndices(_start, _end);
}

class SliceIndices {
  final int start;
  final int end;
  SliceIndices(this.start, this.end);
}
