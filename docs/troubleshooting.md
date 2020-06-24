# Troubleshooting

## HTTP status code failure

A common test failure is `HTTP status code 550 (RestClient::RequestFailed)`. This is a result of the BrowserUp Proxy java process running as part of a previously aborted smokey-loop and the new smoke tests cannot start a new proxy.

It's necessary to kill the existing java process (replace process numbers as appropriate).

```sh
$ ps -ef | grep java
> smokey    6385  6380 26 14:58 ?        00:00:54 java -Dapp.name=browserup-proxy -Dbasedir=/opt/smokey -jar /opt/smokey/lib/browserup-dist-2.0.1.jar --port 3222
$ sudo kill -9 6385
```

You can even set up an alias in your `~/.bash_profile`:

```sh
alias killbrowserup="ps xu | grep [b]rowserup-proxy | grep -v grep | awk '{ print \$2 }' | xargs kill -9"
```
