-module(lib_misc).
-compile(export_all).
% -export([qsort/1, pythag/1, perms/1, my_time_func/1, my_tuple_to_list/1, my_tuple_to_list2/1, my_date_string/0, my_counter/1, map_search_pred/2]).

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X > Pivot]) ++ [Pivot] ++ qsort([X || X <- T, X < Pivot]).

pythag(N) -> 
    [{P, Q, R} || 
    P <- lists:seq(1, N), % DONE Again, ask about the comma here. Are all of these qualifiers supposed to return true? How about the lists:seq() then ?
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

% TODO Ask marc about managing multiple erlang runtimes on a development system? Is something like a virtualenv available ? -- Use a Docker container to built for specific Erlang distributions

% DONE My head hurts after looking at the io:format documentation. Can we have a simple thumb rule to summarize most common use cases? ~p~w any Erlang term , ~s io_list as string, ~b integer, ~n newline.

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

my_counter(Str) -> my_counter(Str, #{}).

% my_counter([H|T], 
% #{H := N} = X) -> 
    % my_counter(T, X#{ H := N+1 }); % TODO Ask Marc about the error : 'H' is unbound
% my_counter([H|T], X) when maps:is_key(H, X) -> N = maps:get(H, X), my_counter(T, X#{H := N+1}); % TODO Is this some 'hangover' coding style from other languages?
% my_counter([H|T], X) -> my_counter(T, X#{H => 1});

my_counter([H|T], X) ->
    case maps:is_key(H, X) of
        % #{H := N}  -> io:format("Increment",[]),
        true  -> io:format("Increment",[]),
        my_counter(T, X#{ H := maps:get(H, X)+1 });
        false -> io:format("New",[]), my_counter(T, X#{H => 1})
    end;
my_counter([], X) -> X.

map_search_pred(Map, Pred) when is_function(Pred, 2), is_map(Map) ->
    map_search_pred(maps:to_list(Map), Pred);
map_search_pred([],_) -> error;
map_search_pred([{Key, Value}=H|T], Pred) ->
    case Pred(Key, Value) of
        true -> {ok, H};
        false -> map_search_pred(T, Pred)
    end.

% json_to_map(FileName) ->
%     tuples