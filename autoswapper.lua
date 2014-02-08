script_name        = "Autoswapper"
script_description = "Perform swap operations on a script."
script_author      = "Daiz"
script_version     = "1.0.1"

function replace(c, subs)

  local re1 = "{%"..c.."}([^{]*){%"..c.."([^%"..c.."]?[^}]*)}"
  local fn1 = "{%"..c.."}%2{%"..c.."%1}"
  local re2 = "{%"..c.."%"..c.."([^}]*)}"
  local fn2 = "{%"..c.."}%1{%"..c.."}"
  local re3 = "{%"..c.."}{%"..c
  local fn3 = "{%"..c.."%"..c
  local re4 = "^%"..c.."%"..c.."%"..c.."$" 

  for i = 1, #subs do

    local l = subs[i]

    -- don't touch any non-event parts of the script
    if l.class == "dialogue" then

      local s = l.style
      local e = l.effect
      local proceed = false

      -- replacements shouldn't happen for non-dialogue lines
      -- in order to avoid any unfortunate accidents
      if s:match("Default") then proceed = true end
      if s:match("Alternative") then proceed = true end
      if s:match("Overlap") then proceed = true end

      --- toggle line comment status if effect field matches '***'
      if e:match(re4) then l.comment = not l.comment end

      if proceed then

        l.text = l.text

          -- Convert "{*}foo{*bar}" to "{*}bar{*foo}"
          :gsub(re1, fn1)
          
          -- Convert "foo{**-bar}" to "foo{*}-bar{*}"
          :gsub(re2, fn2)
          
          -- Convert "foo{*}{*-bar}" to "foo{**-bar}"
          :gsub(re3, fn3)

      end

      subs[i] = l

    end

  end

end

function honorifics(subs, selected, active)
  replace("*", subs)
  aegisub.set_undo_point("Swap honorifics")
end

function mahjong(subs, selected, active)
  replace("/", subs)
  aegisub.set_undo_point("Swap mahjong terms")
end

function verbal_tics(subs, selected, active)
  replace("<", subs)
  aegisub.set_undo_point("Swap verbal tics")
end

aegisub.register_macro(
  "Swap honorifics ( * )",
  "Swap the state of honorifics in the script. Character: *",
  honorifics
)

aegisub.register_macro(
  "Swap mahjong terms ( / )",
  "Swap the state of mahjong terms in the script. Character: /",
  mahjong
)

aegisub.register_macro(
  "Swap verbal tics ( < )",
  "Swap the state of verbal tics in the script. Character: <",
  verbal_tics
)