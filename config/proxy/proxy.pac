function FindProxyForURL(url, host) {
  if (dnsDomainIs(host, 'staging-trace.ddbj.nig.ac.jp')) {
    return 'SOCKS5 localhost:1080';
  } else {
    return 'DIRECT';
  }
}
