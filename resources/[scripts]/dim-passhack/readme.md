To Use:

```lua
TriggerEvent("DimboPassHack:StartHack", difficulty, cb)

TriggerEvent("DimboPassHack:StartHack", 5, function(passed)
    if passed then
        print("PASSED")
    else
        print("FAILED")
    end
end)
```

Difficulty can be 1-10 (1 being the easiest and 10 being super hard (if not impossible))