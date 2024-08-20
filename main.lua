function love.load()
    playerWidth = 10
    playerLength = 50

    -- Player Locations
    playerOneY = 5
    playerTwoY = (love.graphics.getHeight() - 5) - playerLength

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
    if love.keyboard.isDown('w') then
        playerOneY = playerOneY - (dt * 120)
    elseif love.keyboard.isDown('s') then
        playerOneY = playerOneY + (dt * 120)
    end

    if love.keyboard.isDown('up') then
        playerTwoY = playerTwoY - (dt * 120)
    elseif love.keyboard.isDown('down') then
        playerTwoY = playerTwoY + (dt * 120)
    end
end