function love.load()
    -- Screen Properties
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    padding = 5

    -- Game Properties
    playerWidth = 10
    playerLength = 50
    playerSpeed = 200
    ballSpeed = 1
    debugMode = true
    maxY = (screenHeight - padding) - playerLength

    -- Player Location
    playerOneY = padding
    playerTwoY = maxY

    function resetBall()
        ballX = screenWidth / 2
        ballY = screenHeight / 2
        ballXDirection = 'right'
        ballYDirection = 'down'
    end

    resetBall()

end

function love.draw()
    -- Debug
    if debugMode then
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('ballX: ' ..ballX, 300, 60)
        love.graphics.print('ballY: ' ..ballY, 300, 80)
        love.graphics.print('ballXDirection: ' ..ballXDirection, 300, 100)
        love.graphics.print('ballYDirection: ' ..ballYDirection, 300, 120)
    end

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
        (screenWidth - padding) - playerWidth,
        playerTwoY,
        playerWidth,
        playerLength
    )

    -- Ball
    love.graphics.rectangle(
        'fill',
        ballX,
        ballY,
        10,
        10
    )
end

function love.update(dt)
    local playerOneNewY
    local playerTwoNewY
    local newBallX
    local newBallY

    -- Player One Movement
    if love.keyboard.isDown('w') then
        playerOneNewY = playerOneY - (dt * playerSpeed)
        if playerOneNewY > padding then
            playerOneY = playerOneNewY
        end
    elseif love.keyboard.isDown('s') then
        playerOneNewY = playerOneY + (dt * playerSpeed)
        if playerOneNewY < maxY then
            playerOneY = playerOneNewY
        end
    end

    -- Player Two Movement
    if love.keyboard.isDown('up') then
        playerTwoNewY = playerTwoY - (dt * playerSpeed)
        if playerTwoNewY > padding + playerWidth then
            playerTwoY = playerTwoNewY
        end
    elseif love.keyboard.isDown('down') then
        playerTwoNewY = playerTwoY + (dt * playerSpeed)
        if playerTwoNewY < maxY then
            playerTwoY = playerTwoNewY
        end
    end

    -- Ball Vertical Movement
    if ballYDirection == 'up' then
        newBallY = ballY - ballSpeed
        if newBallY <= padding then
            ballY = ballY + ballSpeed
            ballYDirection = 'down'
        else
            ballY = newBallY
        end
    elseif ballYDirection == 'down' then
        newBallY = ballY + ballSpeed
        if newBallY >= (screenHeight - padding - 10) then
            ballY = ballY - ballSpeed
            ballYDirection = 'up'
        else
            ballY = newBallY
        end
    end

    -- Ball Horizontal Movement
    if ballXDirection == 'left' then
        newBallX = ballX - ballSpeed
        if newBallX < (playerWidth + padding) and ballY >= playerOneY and ballY <= playerOneY + playerLength then
            ballXDirection = 'right'
            ballX = ballX + ballSpeed
        elseif newBallX < 0 then
            resetBall()
            ballXDirection = ''
            ballYDirection = ''
        else
            ballX = newBallX
        end
    elseif ballXDirection == 'right' then
        newBallX = ballX + ballSpeed
        
        if newBallX > (screenWidth - playerWidth - 10 - padding) and ballY >= playerTwoY and ballY <= playerTwoY + playerLength then
            ballXDirection = 'left'
            ballX = ballX - ballSpeed
        elseif newBallX > (screenWidth - 10) then
            resetBall()
            ballXDirection = ''
            ballYDirection = ''
        else
            ballX = newBallX
        end
    end
end