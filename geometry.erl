-module(geometry).
-export([area/1]).

area({circle, Radius}) -> math:pi() * Radius * Radius;
area({square, Side}) -> Side * Side;
area({rectangle, Width, Height}) -> Width * Height.
