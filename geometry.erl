-module(geometry).
-export([area/1, perimeter/1, test/0]).

test() ->
    144 = area({square, 12}), % DONE Ask Mark about usage of comma, difference with ;
    tests_worked.

area({circle, Radius}) -> math:pi() * Radius * Radius;
area({square, Side}) -> Side * Side;
area({rectangle, Width, Height}) -> Width * Height.

perimeter({circle, Radius}) -> math:pi() * Radius * 2.0;
perimeter({square, Side}) -> 4.0 * Side;
perimeter({rectangle, Width, Height}) -> 2 * (Width + Height).