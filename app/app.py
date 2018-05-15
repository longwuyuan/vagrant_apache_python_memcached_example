from flask import Flask, render_template, request
import logging, sys
from memcached_stats import MemcachedStats
from pprint import pprint

app = Flask(__name__)
logging.basicConfig(stream=sys.stderr)

@app.route('/')
def stats():
    logging.error("Sample error message")
    mem = MemcachedStats()
    stats_all = mem.stats()
    stats_get_hits_rate = float(mem.stats()['get_hits']) / float(mem.stats()['get_misses']) * 100
    stats_memcached_mem_used = mem.stats()['bytes']
    var_temp = (float(mem.stats()['bytes']) / 64000000.00) * 100.00
    stats_memcached_mem_used_percentage = format(var_temp, '.6f')

    return render_template("app.html.j2", placeholder_stats_all=stats_all, placeholder_stats_get_hits_rate=stats_get_hits_rate, placeholder_stats_memcached_mem_used=stats_memcached_mem_used, placeholder_stats_memcached_mem_used_percentage=stats_memcached_mem_used_percentage)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
