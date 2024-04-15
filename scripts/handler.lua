print "handler.lua is being loaded!"

mypipe = CFE.CreatePipe(5, "LUAPIPE")
print ("Pipe ID is: " .. tostring(mypipe))

inintf = EdsDB.GetInterface("CFE_ES/Application/HK_TLM")
assert(inintf)
outintf = EdsDB.GetInterface("CFE_ES/Application/CMD")
assert(outintf)

handlercount = 0

function TestMessageSender(cmdtype)
    local outmsg = EdsDB.NewMessage(outintf, cmdtype)

    print(string.format("Sending %s, content=%s", cmdtype, tostring(outmsg)))
    CFE.SendMsg(outmsg)
end

function TestMessageReply(inmsg)
    local intlm = CFE.WaitFor(inintf, mypipe, 5000)

    print ("Waiting for input on: " .. tostring(inintf))
    if (intlm) then
        print ("Got a TLM: " .. tostring(intlm))
        print ("CommandCounter: " .. tostring(intlm.Payload.CommandCounter()))
    end

    TestMessageSender("NoopCmd")
end

function TestMessageHandler(inmsg)

    handlercount = 1 + handlercount
    print ("This is TestMessageHandler() count=" .. tostring(handlercount))

    if (inmsg) then
        print ("Input Message: " .. tostring(inmsg))

        -- Using the "call" syntax returns the actual value
        print (string.format("In LUA script, params are: ValU32=%u, ValI16=%d, ValStr=%s\n",
            inmsg.ValU32(), inmsg.ValI16(), inmsg.ValStr()))
    end
end

function TestExampleMessageSend(msg)
    print "This is TestFunc2()"

    if (msg) then
        print ("Got A Message: " .. tostring(msg))

        -- Using the "call" syntax returns the actual value
        print ("The Input value is: " .. msg.Value())
    end

    testobj = EdsDB.NewMessage(outintf, "NoopCMD")

    print("obj=" .. EdsDB.ToHexString(testobj))

    CFE.SendMsg(testobj)
end
