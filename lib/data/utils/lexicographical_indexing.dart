String generateNextIndex(String? lastIndex) {
  const indexPadding = 5; // Determines the length, e.g., 5 -> "00001"
  if (lastIndex == null) {
    return '1'.padLeft(indexPadding, '0');
  } else {
    final lastIndexInt = int.parse(lastIndex);
    return (lastIndexInt + 1).toString().padLeft(indexPadding, '0');
  }
}
