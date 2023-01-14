def fib(n):
    if n == 0 or n == 1:
        return n
    else:
        return fib(n-2) + fib(n-1)


def count(f):
    def counted(*args):
        counted.call_count += 1
        return f(*args)
    counted.call_count = 0
    return counted


def memo(f):
    # keys are arguments that map to return values.
    cache = {}

    def memoized(n):
        if n not in cache:
            cache[n] = f(n)
        return cache[n]
    # memozied has same behavior as f, if f is a pure function.
    return memoized
