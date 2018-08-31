-module(try_test).
-compile(export_all).

generate_exceptions(N) ->
    case N of
        1 -> a;
        2 -> throw(a);
        3 -> exit(a);
        4 -> {'EXIT', a};
        5 -> error(a)
    end.

demo3() ->
    try generate_exceptions(5)
    catch
        error:X ->
            {X, erlang:get_stacktrace()}
    end.

