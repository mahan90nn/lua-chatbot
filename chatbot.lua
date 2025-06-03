
local user_name = nil

local help_text = [[
I can chat with you about:
- Greetings (hi, hello)
- Your name (tell me your name)
- About me (who are you)
- Feelings (how are you)
- Weather questions
- Jokes and fun facts
- Math questions (e.g. what is 4 + 5)
- Favorite things (color, food, movie)
- Say goodbye (bye, exit)
- And much more!

Type your message or command.
Type 'credits' to see who made me.
Type 'exit' to quit.
]]

local credits_text = "Creator: Mr_Stable"

local rules = {
    greetings = {
        {"hello", "Hello! How can I help you today?"},
        {"hi", "Hi there! Great to see you."},
        {"hey", "Hey! What's new with you?"},
        {"good morning", "Good morning! Hope you slept well."},
        {"good afternoon", "Good afternoon! How’s your day going?"},
        {"good evening", "Good evening! What did you do today?"}
    },

    name_input = {
        {"my name is%s+(%a+)", function(input)
            user_name = input:match("my name is%s+(%a+)")
            return "Nice to meet you, " .. user_name .. "!"
        end},
        {"i'?m%s+(%a+)", function(input)
            user_name = input:match("i'?m%s+(%a+)")
            return "Great to meet you, " .. user_name .. "!"
        end},
        {"call me%s+(%a+)", function(input)
            user_name = input:match("call me%s+(%a+)")
            return "Got it! I'll call you " .. user_name .. "."
        end}
    },

    about_bot = {
        {"what'?s your name", "I'm LuaBot, your friendly Lua chatbot!"},
        {"who are you", "I'm a chatbot coded in Lua by Mr_Stable."},
        {"what can you do", "I can chat, tell jokes, do math, and remember your name!"},
        {"how do you work", "I respond based on patterns — kind of like a smart rule book."}
    },

    feelings = {
        {"how are you", "I'm doing great, thanks for asking!"},
        {"how'?s it going", "Everything’s going well here!"},
        {"are you okay", "Yes, I’m always ready to chat."},
        {"how do you feel", "Excited to talk with you!"}
    },

    weather = {
        {"how'?s the weather", "I’m not connected to real weather, but I hope it’s nice outside!"},
        {"is it raining", "Check your window, I can’t see outside!"},
        {"is it hot", "If it’s hot, stay hydrated! I only process code."},
        {"what's the weather", "Weather info is not in my toolbox yet."}
    },

    age = {
        {"how old are you", "I was born the moment you ran this script."},
        {"what'?s your age", "I’m timeless, just like good code."}
    },

    color = {
        {"favorite color", "I love green — like the Lua logo!"},
        {"what'?s your favorite color", "Blue. It’s calm and nice."},
        {"what color do you like", "Colors are fun! Lua green is my pick."}
    },

    hobby = {
        {"what do you like to do", "Chatting with you is my favorite pastime."},
        {"do you have hobbies", "I enjoy processing text and learning new patterns."},
        {"what's your hobby", "Talking to awesome people like you."}
    },

    joke = {
        {"tell me a joke", "Why do programmers prefer dark mode? Because light attracts bugs!"},
        {"make me laugh", "Why did the coder quit his job? Because he didn't get arrays."},
        {"funny", "Why was the JavaScript developer sad? Because he didn't Node how to Express himself."},
        {"another joke", "Why do Java developers wear glasses? Because they don't see sharp."},
        {"one more joke", "How many programmers does it take to change a light bulb? None, that's a hardware problem!"}
    },

    thanks = {
        {"thank you", "You’re welcome!"},
        {"thanks", "No problem!"},
        {"ty", "Glad I could help!"},
        {"thank you so much", "Anytime! I’m here for you."}
    },

    questions = {
        {"what is lua", "Lua is a lightweight, embeddable scripting language."},
        {"who created lua", "Lua was created by a team at PUC-Rio in Brazil."},
        {"what is love", "Baby don’t hurt me — I’m just a bot!"},
        {"can you learn", "Not yet, but I can be improved with more code."},
        {"what is programming", "It’s telling a computer how to do things step by step."},
        {"what is hacking", "Hacking is exploring systems, sometimes ethically, sometimes not."}
    },

    compliment = {
        {"you are smart", "Thanks! You’re pretty clever yourself."},
        {"you'?re funny", "Glad you think so!"},
        {"you'?re cool", "You make me cooler!"},
        {"i like you", "I like you too!"}
    },

    favorite = {
        {"favorite food", "Electricity — it keeps me running."},
        {"favorite movie", "The Matrix — lots of code in there."},
        {"favorite game", "Minecraft! I hear there are Lua mods too."},
        {"favorite language", "Lua, obviously!"},
        {"favorite music", "I enjoy the sound of silence."}
    },

    math = {
        {"what'?s (%d+)%s*%+%s*(%d+)", function(input)
            local a, b = input:match("(%d+)%s*%+%s*(%d+)")
            return "The answer is " .. (tonumber(a) + tonumber(b)) .. "."
        end},
        {"what'?s (%d+)%s*-%s*(%d+)", function(input)
            local a, b = input:match("(%d+)%s*-%s*(%d+)")
            return "That would be " .. (tonumber(a) - tonumber(b)) .. "."
        end},
        {"what'?s (%d+)%s*%*%s*(%d+)", function(input)
            local a, b = input:match("(%d+)%s*%*%s*(%d+)")
            return "The product is " .. (tonumber(a) * tonumber(b)) .. "."
        end},
        {"what'?s (%d+)%s*/%s*(%d+)", function(input)
            local a, b = input:match("(%d+)%s*/%s*(%d+)")
            if tonumber(b) == 0 then
                return "Division by zero is undefined!"
            else
                return "The result is " .. (tonumber(a) / tonumber(b)) .. "."
            end
        end}
    },

    goodbye = {
        {"bye", "Bye! Have a great day."},
        {"goodbye", "Goodbye! Talk soon."},
        {"see you", "See you later!"},
        {"exit", "Exiting now. Goodbye!"},
        {"farewell", "Farewell, friend."}
    },

    unknown = {
        {"do you dream", "Only of electric sheep."},
        {"are you real", "As real as lines of code."},
        {"can you sing", "01001000 01100101 01101100 01101100 01101111!"},
        {"do you sleep", "I run 24/7, always awake for you."},
        {"do you eat", "I consume data and code."}
    }
}


local commands = {
    help = function()
        return help_text
    end,
    credits = function()
        return credits_text
    end
}


function respond(input)
    input = input:lower()


    if commands[input] then
        return commands[input]()
    end


    for _, category in pairs(rules) do
        for _, rule in ipairs(category) do
            local pattern = rule[1]
            local reply = rule[2]

            if input:match(pattern) then
                if type(reply) == "function" then
                    return reply(input)
                else
                    if user_name then
                        return reply .. " " .. user_name .. "!"
                    else
                        return reply
                    end
                end
            end
        end
    end


    return "I didn't understand that. Type 'help' for assistance."
end


print(" LuaBot: Hello! I’m a huge chatbot coded in Lua by Mr_Stable.")
print(" Type your message (or 'help' for commands, 'exit' to quit):")

while true do
    io.write("You: ")
    local user_input = io.read()

    if not user_input then
        print("LuaBot: Goodbye!")
        break
    end

    local lower_input = user_input:lower()

    if lower_input == "exit" then
        print("LuaBot: Goodbye! It was nice chatting with you.")
        break
    end

    local reply = respond(user_input)
    print("LuaBot: " .. reply)
end
