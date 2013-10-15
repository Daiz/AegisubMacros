script_name        = "Autoreplacer"
script_description = "Alter lines according to syntax."
script_author      = "Daiz"
script_version     = "1.0.0"

function autoreplacer(subs, selected, active)
  for _, i in ipairs(selected) do
    
    local l = subs[i]
    l.text = l.text

      -- Convert "{*}foo{*bar}" to "{*}bar{*foo}"
      :gsub("{%*}([^{]*){%*([^%*]?[^}]*)}", "{%*}%2{%*%1}")
      
      -- Convert "foo{**-bar}" to "foo{*}-bar{*}"
      :gsub("{%*%*([^}]*)}", "{%*}%1{%*}")
      
      -- Convert "foo{*}{*-bar}" to "foo{**-bar}"
      :gsub("{%*}{%*", "{%*%*")

    subs[i] = l

  end
  aegisub.set_undo_point(script_name)
  return selected
end

aegisub.register_macro(script_name, script_description, autoreplacer)