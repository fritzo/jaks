
// Define a term type enum.
#pragma once

#include <cstdint>

enum struct TermType : std::uint8_t {
  TOP = 0,
  APP = 1,
  K = 2,
  LIN = 3,
  ABS = 4,
  VAR = 5,
  A = 6,
  AJ = 7,
  RVAR = 8,
  SVAR = 9,
  NONE=255
};