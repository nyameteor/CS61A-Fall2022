# References:
# http://composingprograms.com/pages/17-recursive-functions.html
# https://www.youtube.com/watch?v=DvgT4dnSMVM
# https://www.youtube.com/watch?v=MG5lJNfMjFA

def count_partitions(n, m):
    """Count the ways to partition n using parts up to m.

    >>> count_partitions(6, 4)
    9
    >>> count_partitions(5, 5)
    7
    >>> count_partitions(10, 10)
    42
    >>> count_partitions(15, 15)
    176
    >>> count_partitions(20, 20)
    627
    """
    if n == 0:
        return 1
    elif n < 0:
        return 0
    elif m == 0:
        return 0
    else:
        with_m = count_partitions(n-m, m)
        without_m = count_partitions(n, m-1)
        return with_m + without_m


def list_partitions(n, m):
    """List partitions.

    >>> for p in list_partitions(6, 4): print(p)
    [2, 4]
    [1, 1, 4]
    [3, 3]
    [1, 2, 3]
    [1, 1, 1, 3]
    [2, 2, 2]
    [1, 1, 2, 2]
    [1, 1, 1, 1, 2]
    [1, 1, 1, 1, 1, 1]
    """
    if n < 0 or m == 0:
        return []
    else:
        exact_match = []
        if n == m:
            exact_match = [[m]]
        with_m = [p + [m] for p in list_partitions(n-m, m)]
        without_m = list_partitions(n, m-1)
        return exact_match + with_m + without_m


def yield_partitions(n, m):
    """Yield partitions.

    >>> for p in yield_partitions(6, 4): print(p)
    [2, 4]
    [1, 1, 4]
    [3, 3]
    [1, 2, 3]
    [1, 1, 1, 3]
    [2, 2, 2]
    [1, 1, 2, 2]
    [1, 1, 1, 1, 2]
    [1, 1, 1, 1, 1, 1]
    """
    if n == 0:
        yield []
    elif n > 0 and m > 0:
        for p in yield_partitions(n-m, m):
            yield p + [m]
        yield from yield_partitions(n, m-1)
