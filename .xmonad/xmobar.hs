Config {
    font = "xft:SauceCodePro Nerd Font:size=10:hinting=true",
    additionalFonts   = ["xft:SauceCodePro Nerd Font:pixelsize=18:hinting=true" ],
    -- bgColor = "#000900",
    -- fgColor = "#009C00",
    bgColor = "#000000",
    fgColor = "#777777",
    alpha = 160,
    border = NoBorder,
    borderWidth = 1,
    borderColor = "#FF6600",
    pickBroadest = True,
    position = Top,
    textOffset = 26,
    lowerOnStart = False,
    overrideRedirect = False,
    hideOnStart = False,
    persistent = True,
    allDesktops = True,
    commands = [
        Run Locks,
        --Run Weather "EGLL" ["-t","<tempC>C <skyCondition>","-L","0","-H","25","-n","#ffca28","-h","#FFB6B0","-l","#96CBFE"] 36000,
        -- Run Weather "EGLL" ["-t","<fn=1>\xf0c2</fn> <tempC>°<skyCondition> ","-L","10","-H","25","-n","#FE8C1F","-h","#FF6600","-l","#FFD77C"] 3600,
        -- Run MultiCpu ["-t","<fn=1>\xf0e4</fn><total0> <vbar0><total1> <vbar1><total2> <vbar2><total3> <vbar3>","-L","30","-H","60","-h","#FF6600","-l","#FFD77C","-n","#FE8C1F","-w","3"] 10,
        -- Run Memory ["-t","<fn=1>\xf2db</fn> <usedratio>%","--High","80","--Low","10","--high","#FF6600","--low","#FFD77C","--normal","#FE8C1F"] 10,
        -- Run Swap ["-t","<fn=1>\xf019</fn> <usedratio>%","-H","1024","-L","512","-h","#FF6600","-l","#FFD77C","-n","#FE8C1F"] 10,
        -- Run Network "wlp2s0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FF6600","-l","#FFD77C","-n","#FE8C1F"] 10,
        -- Run Wireless "wlp2s0-w" [ "-t", "<fn=1>\xf1eb</fn> <fc=#FE8C1F><essid></fc> [<qualitybar>]","-L","0","-H","32","--normal","#FE8C1F","--high","#FF6600","--low","#FFD77C"] 10,
        Run Date "<fn=1>\xf073</fn> <fc=#aaaaaa>%a %b %d %H:%M</fc>" "date" 200,
        -- Run BatteryP ["BAT0"] ["-t", "<icon=/home/sarunas/.xmonad/icons/battery.xbm/> <fc=#ffca28><acstatus> <watts>(<left>%/<timeleft>)</fc>", "-L", "10", "-H", "80", "-p", "3", "--", "-L", "-15", "-H", "-5", "-l", "red", "-m", "#ffca28", "-h", "orange", "-f", "/sys/class/power_supply/AC0/online"] 600,
		Run BatteryP
			["BAT0"]
            [ "-t", "<fc=#999999><acstatus></fc>"
            , "-L", "10"
            , "-H", "85"
            , "-h", "#cccccc"
            , "-n", "#aaaaaa"
            , "-l", "#FF0000"
            , "--" -- battery specific options
            , "-p", "green"
            -- discharging status
            , "-o", "<fn=1>\xf242</fn> <left>% <leftvbar> (<timeleft>)"
            , "-m", "#FF6600"
            -- AC "on" status
            , "-O", "<fn=1>\xf1e6</fn> <left>%"
            -- charged status
            , "-i", "<fn=1>\xf1e6</fn> <left>%"
            , "--off-icon-pattern", "<fn=1>\xf1e6</fn>"
            , "--on-icon-pattern", "<fn=1>\xf1e6</fn>"
            ] 200
        , Run Volume "default" "Master"
            [ "-t", "<status>", "--"
                                  , "--on", "<fc=#999999><fn=1>\xf028</fn> <volume>%</fc>"
                                  , "--onc", "#cccccc"
                                  , "--off", "<fc=#aaaaaa><fn=1>\xf026</fn> MUTE</fc>"
                                  , "--offc", "#aaaaaa"
                                   ] 20
       , Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = " %StdinReader% }{%locks% %default:Master% %battery% %date% "
}
