script_name = "CPS Calculator"
script_description = "Calculates characters per second for lines."
script_author = "Daiz"
script_version = "1.1.0"

-- warning character
local c = "*"

function pad(n,p)
  n = ""..n
  while n:len() < p do
    n = "0"..n
  end
  return n
end

function repeat_text(text, times)
  local res = ""
  if times > 10 then times = 10 end
  for i = 1, times do
    res = res .. text
  end
  return res
end

function cps(subs, sel)
  for i = 1, #subs do
    if subs[i].class == "dialogue" then
      local l = subs[i]
      local t = l.text
      local s = l.style
      local proceed = false

      if s:match("Default") then proceed = true end
      if s:match("Alternative") then proceed = true end
      if s:match("Overlap") then proceed = true end

      if proceed then
        -- clean up the line so only characters remain
        t = t
          :gsub("\\N","")
          :gsub("\\n","")
          :gsub("\\h","")
          :gsub("[%.,%?!—–]","")
          :gsub("{[^}]-}","")
          :gsub(" ","")
  
        local chars = t:len()
        local seconds = (l.end_time - l.start_time) / 1000
        local cps = math.floor((chars / seconds) + 0.5)
        local res = "("..pad(cps,2)..")"
        if cps > 18 then
          res = res .. " (" .. repeat_text(c, cps - 18) .. ")"
        end
        l.effect = res
        subs[i] = l
      end
    end
  end

  aegisub.set_undo_point("CPS Calculator")

end

function cleancps(subs, sel)
  for i = 1, #subs do
    if subs[i].class == "dialogue" then
      local l = subs[i]
      local t = l.text
      local s = l.style
      local proceed = false

      if s:match("Default") then proceed = true end
      if s:match("Alternative") then proceed = true end
      if s:match("Overlap") then proceed = true end

      if proceed then
        l.effect = ""
        subs[i] = l
      end
    end
  end

  aegisub.set_undo_point("Clean effect field")

end

aegisub.register_macro(
  script_name,
  script_description,
  cps
)

aegisub.register_macro(
  "Clean effect field",
  "Cleans the effect field used by CPS Calculator.",
  cleancps
)