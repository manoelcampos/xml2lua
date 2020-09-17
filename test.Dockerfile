FROM nickblah/lua:5.1-luarocks-ubuntu

RUN apt-get update -qq \
    && apt-get install build-essential -qq \
    && luarocks install luasocket \
    && luarocks install luacheck \
    && luarocks install luacov \
    && luarocks install xml2lua \
    && luarocks install luacov-coveralls \
    && luarocks install busted 

CMD ["busted"]

