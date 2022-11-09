print "handler.lua is being loaded!"

function TestFunc2(msg)
    print "This is TestFunc2()"

    if (msg) then
        print ("Got A Message: " .. tostring(msg))

        -- Using the "call" syntax returns the actual value
        print ("The Input value is: " .. msg.Value())
    end

    cmd = EdsDB.GetInterface("CFE_ES/Application/CMD")
    testobj = EdsDB.NewMessage(cmd, "NoopCMD")

    print("obj=" .. EdsDB.ToHexString(testobj))

    CFE.SendMsg(testobj)
end
