-module(wc_erl).
-export([io_get_line/0]).

% Wraps io:get_line to return `{ok, Data}` on success instead of just `Data`
io_get_line() ->
    case io:get_line("") of
        eof -> eof;
        {error} -> {error};
        Data -> {ok, Data}
    end.