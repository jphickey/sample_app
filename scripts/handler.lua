print "handler.lua is being loaded!"

function TestMessageHandler(inmsg)
    print "This is TestMessageHandler()"

    if (inmsg) then
        print ("Input Message: " .. tostring(inmsg))

        -- Using the "call" syntax returns the actual value
        print ("The Input value is: " .. inmsg.Value())
    end

    intf = EdsDB.GetInterface("CFE_ES/Application/CMD")
    outmsg = EdsDB.NewMessage(intf, "NoopCMD")

    CFE.SendMsg(outmsg)
end
