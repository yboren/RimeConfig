local function english_glossary_filter(input, env)
  if not GLOSSARY then
    for cand in input:iter() do yield(cand) end
    return
  end
  for cand in input:iter() do
    local t = cand.text
    -- Only lookup for 2+ char words (skip single chars for speed)
    if #t > 1 and GLOSSARY[t] then
      cand.comment = GLOSSARY[t]
    end
    yield(cand)
  end
end
return english_glossary_filter
