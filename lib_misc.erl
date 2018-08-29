-module(lib_misc).
-export([qsort/1, pythag/1, perms/1, my_time_func/1, odds_evens/1, my_tuple_to_list/1, my_tuple_to_list2/1, my_date_string/0]).

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
    io:format('~p~n',[T1]),
    F,
    T2=erlang:timestamp(),
    io:format('~p~n',[T2]),   
    timer:now_diff(T2, T1).

% TODO Ask (DONE) marc about managing multiple erlang runtimes on a development system? Is something like a virtualenv available ? -- Use a Docker container to built for specific Erlang distributions

% TODO (DONE) My head hurts after looking at the io:format documentation. Can we have a simple thumb rule to summarize most common use cases? ~p~w any Erlang term , ~s io_list as string, ~b integer, ~n newline.

odds_evens(L) ->
    odds_evens_acc(L, [], []).

odds_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_evens_acc(T, [H|Odds], Evens);
        0 -> odds_evens_acc(T, Odds, [H|Evens])
    end;
odds_evens_acc([], Odds, Evens) ->
    {Odds, Evens}.

% c4q2
my_tuple_to_list_helper(T, Lim, Lim, L) ->
    [element(Lim, T) | L];
my_tuple_to_list_helper(T, Pos, Lim, L) ->
    H=element(Pos, T),
    my_tuple_to_list_helper(T, Pos+1, Lim, [H|L]).

my_tuple_to_list(T) ->
    lists:reverse(my_tuple_to_list_helper(T, 1, tuple_size(T), [])).

my_tuple_to_list2(T) ->
    [element(Pos, T) || Pos <- lists:seq(1, tuple_size(T))]. % Cool solution from https://stackoverflow.com/questions/16220993/erlang-elegant-tuple-to-list-1

my_date_string() ->
    D=erlang:date(),
    T=erlang:time(),
    io_lib:format("~b-~b-~b ~b:~b ~n",[element(1, D), element(2, D),element(3, D), element(1, T), element(2, T)]). % Refer https://gist.github.com/dergraf/2216802

% TODO Personal Solve the c4q5 advanced question

