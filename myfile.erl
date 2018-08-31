-module(myfile).
-compile(export_all).

read(FileName) ->
    try {ok, _} = file:open(FileName, [read])
        catch error:X ->
            {X, erlang:get_stacktrace()}
        % after file:close(Device)
    end.