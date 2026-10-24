#!/usr/bin/env sh
set -eu
test "$(command -v erl)" = /opt/emqx-otp/bin/erl
test -s /opt/emqx-otp/share/licenses/erlang/LICENSE.txt
test -s /opt/emqx-otp/share/licenses/erlang/COPYRIGHT
test -s /opt/emqx-otp/share/licenses/erlang/README.emqx-oss.md
erl +S 2:2 -noshell -eval '
    "27" = erlang:system_info(otp_release),
    "15.2.7.14" = erlang:system_info(version),
    {ok, <<"27.3.4.19-emqx-oss.1\n">>} = file:read_file(
        filename:join([code:root_dir(), "releases", "27", "OTP_VERSION"])),
    mnesia_hook = mnesia_hook:module_info(module),
    {ok, _} = application:ensure_all_started(ssl),
    16 = byte_size(crypto:strong_rand_bytes(16)),
    {module, compile} = code:ensure_loaded(compile),
    {module, public_key} = code:ensure_loaded(public_key),
    io:format("PASS custom OTP27, ERTS15.2.7.14, Mnesia hook, SSL and compiler~n"),
    halt().'
