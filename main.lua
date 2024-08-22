function love.load()
    -- Screen Properties
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    padding = 5

    -- Game Properties
    playerWidth = 10
    playerLength = 50
    playerSpeed = 250
    countdownTimer = 3
    extraTimer = 0
    debugMode = true
    gameStart = false
    maxY = (screenHeight - padding) - playerLength

    -- Player Location
    playerOneY = padding
    playerTwoY = maxY

    function coinFlip(T, F)
        num = math.floor(love.math.random() * 100)
        if num < 50 then return T else return F end
    end

    function resetBall(isInitial)
        ballX = screenWidth / 2
        ballY = screenHeight / 2
        ballSpeed = 0

        if isInitial then
            gameStart = true
            ballXDirection = 'right'
            ballYDirection = 'down'
        else 
            ballXDirection = coinFlip('left', 'right')
            ballYDirection = coinFlip('up', 'down')
        end
    end
end

function love.draw()
    -- Debug
    if debugMode then
        if gameStart then
            love.graphics.setColor(1, 1, 1)
            love.graphics.print('ballSpeed: ' ..ballSpeed, 300, 40)
            love.graphics.print('ballX: ' ..ballX, 300, 60)
            love.graphics.print('ballY: ' ..ballY, 300, 80)
            love.graphics.print('ballXDirection: ' ..ballXDirection, 300, 100)
            love.graphics.print('ballYDirection: ' ..ballYDirection, 300, 120)
        end
    end

    love.graphics.setColor(255, 255, 255)

    if gameStart then
        -- Player One
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
    else
        love.graphics.print(countdownTimer, (screenWidth / 2) - 10, screenHeight / 2)
    end
end

function love.update(dt)
    local playerOneNewY
    local playerTwoNewY
    local newBallX
    local newBallY

    -- Countdown
    if not gameStart then
        extraTimer = extraTimer + dt
        if extraTimer >= 1 then
            if countdownTimer == 1 then
                countdownTimer = 'Start!'
            elseif countdownTimer == 'Start!' then
                resetBall(true)
            else 
                countdownTimer = countdownTimer - 1
            end
            extraTimer = 0
        end
        return
    end

    if ballSpeed < 1.5 then
        ballSpeed = ballSpeed + 0.005
    end


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
            ballX = ballX + 1.5
            ballSpeed = ballSpeed + 0.1
        elseif newBallX < 0 then
            resetBall(false)
        else
            ballX = newBallX
        end
    elseif ballXDirection == 'right' then
        newBallX = ballX + ballSpeed
        
        if newBallX > (screenWidth - playerWidth - 10 - padding) and ballY >= playerTwoY and ballY <= playerTwoY + playerLength then
            ballXDirection = 'left'
            ballX = ballX - 1.5
            ballSpeed = ballSpeed + 0.1
        elseif newBallX > (screenWidth - 10) then
            resetBall(false)
        else
            ballX = newBallX
        end
    end
end