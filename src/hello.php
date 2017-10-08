<?php
$cache = new Memcached();
$cache->addServer(getenv('MEMCACHED_PORT_11211_TCP_ADDR'), getenv('MEMCACHED_PORT_11211_TCP_PORT'));

$seconds = $_GET['s'] ?? 5;
$cacheKey = $_SERVER['QUERY_STRING'];

if($cacheKey) {
  if($cache->get($cacheKey)) {
    echo $cache->get($cacheKey);
  } else {
    $cache->set($cacheKey, "$seconds has been retrieved from the cache.");

    # pretend we have a long running task
    sleep($seconds);

    echo "$seconds has been stored in the cache.";
  }
} else {
  sleep($seconds);
}
?>
