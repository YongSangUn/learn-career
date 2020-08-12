# using python as a claculator

## number and expression

Arithmetic operator: `- + * / // % **`

- integer division(floored division) & modulo operation

  In nearly all computing systems, the quotient q and the remainder r of a divided by n satisfy:

      a/n = q with remainder r
      a = n\*q + r
      |r| < |n|

  two possible choices for the remainder occur: negative and positive,
  Usually, in number theory, the positive remainder is always chosen,
  But programming languages choose depending on the language and th signs of a or n.

- integer division(floored division)

  the quotient(商) is defined by th floor function [q = a // n],
  the remainder would have the **same sign as** the diviso.
  Duo to the floor function, the quotient is always rounded downwards, even if it is already negative.

        r = a - n \* (a // b)
