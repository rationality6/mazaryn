-module(ae_wallet_server).
-export([start_link/0, create/4]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
  code_change/3]).

-include_lib("kernel/include/logger.hrl"). 
-include("../../records.hrl").

-behaviour(gen_server).
-record(state, {}).

start_link() ->
  ?LOG_NOTICE("Aeternity Wallet server has been started - ~p", [self()]),
  gen_server:start_link({global, ?MODULE}, ?MODULE, [], []).

create(Name, Password, Size, Token) ->
  gen_server:call({global, ?MODULE}, {create, Name, Password, Size, Token}).

init([]) ->
  {ok, []}.

handle_call({create, Name, Password, Size, Token}, _From, State) ->
  Address = ae_walletdb:insert(Name, Password, Size, Token),
  {reply, Address, State};

handle_call(_Request, _From, State) ->
    {noreply, State}.
      
handle_cast(_Request, State) ->
    {noreply, State}.
      
handle_info(_Info, State) ->
    {noreply, State}.
      
terminate(_Reason, _State) ->
    ok.
      
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.