# http://paulirish.com/2011/requestanimationframe-for-smart-animating/


[ @requestAnimationFrame, @cancelAnimationFrame ] = do ->
    last = 0
    request = window?.requestAnimationFrame
    cancel = window?.cancelAnimationFrame
    for vendor in ["webkit", "moz", "o", "ms"]
        cancel ?= window?["#{vendor}cancelAnimationFrame"] or
                  window?["#{vendor}cancelRequestAnimationFrame"]
        break if (request ?= window?["#{vendor}RequestAnimationFrame"])
    # polyfill request
    isNative = request?
    request = request ? (callback) ->
        cur = new Date().getTime()
        time = Math.max(0, 16 + last - cur)
        id = setTimeout( ->
            callback?(cur + time)
        , time)
        last = cur + time
        return id
    request.isNative = isNative
    # polyfill cancel
    isNative = cancel?
    cancel = cancel ? (id) ->
        clearTimeout(id)
    cancel.isNative = isNative
    # export
    return [request, cancel]


