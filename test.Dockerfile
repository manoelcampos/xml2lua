FROM nickblah/lua:5.4-luarocks-ubuntu

RUN apt-get update -qq > /dev/null \
    && apt-get install build-essential git zip -qq > /dev/null \
    && luarocks install dkjson --local > /dev/null \
    && luarocks install luacheck > /dev/null  \
    && luarocks install luacov > /dev/null  \
    && luarocks install luacov-coveralls > /dev/null  \
    && luarocks install busted > /dev/null

CMD ["busted"]

