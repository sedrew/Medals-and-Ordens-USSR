local M = {}

M.score = 0  -- Set the score to 0 initially

function M.init( options )

    local customOptions = options or {}
    local opt = {}
    opt.fontSize = customOptions.fontSize or 24
    opt.font = customOptions.font or native.systemFont
    opt.x = customOptions.x or display.contentCenterX
    opt.y = customOptions.y or opt.fontSize*0.5
    opt.maxDigits = customOptions.maxDigits or 6
    opt.leadingZeros = customOptions.leadingZeros or false

    local prefix = ""
    if ( opt.leadingZeros ) then
        prefix = "0"
    end
    M.format = "%" .. prefix .. opt.maxDigits .. "d"
    -- Create the score display object
    M.scoreText = display.newText( string.format( M.format, 0 ), opt.x, opt.y, opt.font, opt.fontSize )
    return M.scoreText
end

function M.set( value )
    M.score = tonumber(value)
    M.scoreText.text = string.format( M.format, M.score )
end

function M.get()
    return M.score
end

function M.add( amount )
    M.score = M.score + tonumber(amount)
    M.scoreText.text = string.format( M.format, M.score )
end

function M.save()
    local saved = system.setPreferences( "app", { currentScore=M.score } )
    if ( saved == false ) then
        print( "ERROR: could not save score" )
    end
end

function M.load()
    local score = system.getPreference( "app", "currentScore", "number" )
    if ( score ) then
        return tonumber(score)
    else
        print( "ERROR: could not load score (score may not exist in storage)" )
    end
end

return M
