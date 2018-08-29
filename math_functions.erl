-module(math_functions).
-export([even/1, odd/1, filter/2, split/1, split2/1]).
% c4q5,6,7

even(N) ->
    case (N rem 2) of
        0 -> true;
        1 -> false
    end.

odd(N) -> not even(N).

filter(F, L) -> [X || X <- L, F(X)]. % TODO Ask marc if there is a cleaner syntax to call  -- math_functions:filter(fun math_functions:odd/1, L). 

split(L) ->
    split_acc(L, [], []).

split_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> split_acc(T, [H|Odds], Evens);
        0 -> split_acc(T, Odds, [H|Evens])
    end;
split_acc([], Odds, Evens) ->
    {Odds, Evens}.

split2(L) -> {filter(fun odd/1, L), filter(fun even/1, L)}.