VERSION = "1.0.0"

local buffer = import("micro/buffer")
local config = import("micro/config")

function preinit()
    config.AddRuntimeFile("bqn", config.RTSyntax, "syntax/bqn.yaml")
end

local keymap = {
    ["1"]="˘",["2"]="¨",["3"]="⁼",["4"]="⌜",["5"]="´",
    ["6"]="˝",["7"]="7",["8"]="∞",["9"]="¯",["0"]="•",
    ["!"]="⎉",["@"]="⚇",["#"]="⍟",["$"]="◶",["%"]="⊘",
    ["^"]="⎊",["&"]="⍎",["*"]="⍕",["("]="⟨",[")"]="⟩",
    ["`"]="˜",["-"]="÷",["="]="×",["~"]="¬",["_"]="√",["+"]="⋆",
    ["q"]="⌽",["w"]="𝕨",["e"]="∊",["r"]="↑",["t"]="∧",["u"]="⊔",
    ["Q"]="↙",["W"]="𝕎",["E"]="⍷",["R"]="𝕣",["T"]="⍋",
    ["i"]="⊏",["o"]="⊐",["p"]="π",["["]="←",["]"]="→",
    ["I"]="⊑",["O"]="⊒",["P"]="⍳",["{"]="⊣",["}"]="⊢",
    ["a"]="⍉",["s"]="𝕤",["d"]="↕",["f"]="𝕗",["g"]="𝕘",
    ["A"]="↖",["S"]="𝕊",          ["F"]="𝔽",["G"]="𝔾",
    ["h"]="⊸",["j"]="∘",["k"]="○",["l"]="⟜",
    ["H"]="«",          ["K"]="⌾",["L"]="»",
    ["z"]="⥊",["x"]="𝕩",["c"]="↓",["v"]="∨",["b"]="⌊",["m"]="≡",
    ["Z"]="⋈",["X"]="𝕏",          ["V"]="⍒",["B"]="⌈",["M"]="≢",
    [";"]="⋄",["'"]="↩" ,[","]="∾",["."]="≍",["/"]="≠",
    [":"]="·",["\""]="˙",["<"]="≤",[">"]="≥",["?"]="⇐",
    [" "]="‿",
}

local autoclose
function onBufPaneOpen(bp)
    autoclose = bp.Buf.Settings["autoclose"]
end

local pstate = 0
local leader = "\\"
function onRune(bp, r)
    if bp.Buf:FileType() == "bqn" then
        if pstate == 2 then
            pstate = 0
            if autoclose then
                bp.Buf:SetOption("autoclose", "true")
            end
        end
        if pstate == 1 then
            pstate = 2
            bp:Backspace()
            if keymap[r] then
                r = keymap[r]
            end
            local loc = bp.Cursor.Loc
            bp.Buf:Replace(-loc, buffer.Loc(loc.X+1, loc.Y), r)
        elseif r == leader then
            pstate = 1
            bp:CursorLeft()
            if autoclose then
                bp.Buf:SetOption("autoclose", "false")
            end
        end
    end
end
