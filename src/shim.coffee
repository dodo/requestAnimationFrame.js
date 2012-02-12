
@requestAnimationFrame = do ->
    last = 0
    request = window?.requestAnimationFrame
    for vendor in ["webkit", "moz", "o", "ms"]
        break if (request ?= window?["#{vendor}RequestAnimationFrame"])
    isNative = request?
    request = request ? (callback) ->
        cur = new Date().getTime()
        time = Math.max(0, 16 - cur + last)
        setTimeout(callback, time)
    request.isNative = isNative
    return request
