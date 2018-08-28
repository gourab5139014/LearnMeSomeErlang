-module(lib_misc).
-export([qsort/1, pythag/1, perms/1, my_time_func/1]).

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X > Pivot]) ++ [Pivot] ++ qsort([X || X <- T, X < Pivot]).

pythag(N) -> 
    [{P, Q, R} || 
    P <- lists:seq(1, N), % TODO Again, ask about the comma here. Are all of these qualifiers supposed to return true? How about the lists:seq() then ?
    Q <- lists:seq(1, N),
    R <- lists:seq(1, N),
    P + Q + R =< N,
    P*P + Q*Q =:= R*R
 ].

perms([]) -> [[]];
perms(L) -> [ [H|T] || H <- L, T <- perms(L -- [H])].

my_time_func(F) -> 
    T1=erlang:timestamp(),
    % io:format('~p~n',T1),
    F, % TODO Ask marc about the different between F and F() -- throws bad function error here
    T2=erlang:timestamp(),
    % io:format('~p~n',T2),   
    timer:now_diff(T2, T1).

% TODO Ask marc about managing multiple erlang runtimes on a development system? Is something like a virtualenv available ?
% TODO My head hurts after looking at the io:format documentation. Can we have a simple thumb rule to summarize most common use cases?
