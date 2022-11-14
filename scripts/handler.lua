print "handler.lua is being loaded!"

mypipe = CFE.CreatePipe(5, "LUAPIPE")
print ("Pipe ID is: " .. tostring(mypipe))

inintf = EdsDB.GetInterface("CFE_ES/Application/HK_TLM")
assert(inintf)
outintf = EdsDB.GetInterface("CFE_ES/Application/CMD")
assert(outintf)

function TestMessageHandler(inmsg)
    print "This is TestMessageHandler()"

    if (inmsg) then
        print ("Input Message: " .. tostring(inmsg))

        -- Using the "call" syntax returns the actual value
        print ("The Input value is: " .. inmsg.Value())
    end

    intlm = CFE.WaitFor(inintf, mypipe, 5000)
    if (intlm) then
        print ("Got a TLM: " .. tostring(intlm))
        print ("CommandCounter: " .. tostring(intlm.Payload.CommandCounter()))
    end

    outmsg = EdsDB.NewMessage(outintf, "NoopCMD")
    CFE.SendMsg(outmsg)
end
