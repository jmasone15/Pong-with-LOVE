function love.load()
    playerWidth = 10
    playerLength = 50
    maxY = (love.graphics.getHeight() - 5) - playerLength

    -- Player Locations
    playerOneY = 5
    playerTwoY = maxY

    love.keyboard.setKeyRepeat(true)
end

function love.draw()
    -- Player One
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle(
        'fill', 
        5, 
        playerOneY, 
        playerWidth, 
        playerLength
    )

    -- Player Two
    love.graphics.rectangle(
        'fill',
        (love.graphics.getWidth() - 5) - playerWidth,
        playerTwoY,
        playerWidth,
        playerLength
    )
end

function love.update(dt)
    local playerOneNewY
    local playerTwoNewY

    if love.keyboard.isDown('w') then
        playerOneNewY = playerOneY - (dt * 120)
        if playerOneNewY > 5 then
            playerOneY = playerOneNewY
        end
    elseif love.keyboard.isDown('s') then
        playerOneNewY = playerOneY + (dt * 120)
        if playerOneNewY < maxY then
            playerOneY = playerOneNewY
        end
    end

    if love.keyboard.isDown('up') then
        playerTwoNewY = playerTwoY - (dt * 120)
        if playerTwoNewY > 5 then
            playerTwoY = playerTwoNewY
        end
    elseif love.keyboard.isDown('down') then
        playerTwoNewY = playerTwoY + (dt * 120)
        if playerTwoNewY < maxY then
            playerTwoY = playerTwoNewY
        end
    end
end