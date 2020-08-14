# floored division & modulo operation

Arithmetic operator: `// %`

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

The creator of python wrote a blog post about his reasoning [here](http://python-history.blogspot.com/2010/08/why-pythons-integer-division-floors.html):

I chose a part:

> In mathematical number theory, mathematicians always prefer the latter choice [floor q towards negative infinity] (see e.g. [Wikipedia](http://en.wikipedia.org/wiki/Modulo_operation)). For Python, I made the same choice because there are some interesting applications of the modulo operation where the sign of a is uninteresting. Consider taking a POSIX timestamp (seconds since the start of 1970) and turning it into the time of day. Since there are 24\*3600 = 86400 seconds in a day, this calculation is simply t % 86400. But if we were to express times before 1970 using negative numbers, the "truncate towards zero" rule would give a meaningless result! Using the floor rule it all works out fine.
