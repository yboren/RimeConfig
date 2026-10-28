-- rime.lua

-- Pre-load glossary at startup
local glossary = {}
local appdata = os.getenv("APPDATA")
if appdata then
  local f = io.open(appdata .. "/Rime/glossary_data.tsv", "r")
  if f then
    for line in f:lines() do
      line = line:gsub("\r", "")
      if line:sub(1,1) ~= "#" and line ~= "" then
        local word, pos, sense = line:match("^(%S+)\t(%S+)\t(.+)\t%d+$")
        if word and pos and sense then
          if glossary[word] then
            glossary[word] = glossary[word] .. "; " .. pos .. ". " .. sense
          else
            glossary[word] = pos .. ". " .. sense
          end
        end
      end
    end
    f:close()
  end
end
GLOSSARY = glossary

-- Symbol help: type "fh" to see all categories
local symbol_cats = {
  {"szq", "圆圈数字"}, {"szh", "括号数字"}, {"szd", "点数字"},
  {"1", "数字1各种形式"}, {"2", "数字2"}, {"3", "数字3"},
  {"4", "数字4"}, {"5", "数字5"}, {"6", "数字6"},
  {"7", "数字7"}, {"8", "数字8"}, {"9", "数字9"},
  {"10", "数字10"}, {"0", "数字0"},
  {"hzq", "汉字圈号"}, {"hzh", "汉字括号"},
  {"zmq", "圈字母"}, {"lm", "罗马小写"}, {"lmd", "罗马大写"},
  {"xh", "星号"}, {"jh", "几何图形"}, {"jt", "箭头"},
  {"sx", "数学符号"}, {"fh", "特殊符号"}, {"bq", "表情"},
  {"tq", "天气"}, {"hb", "货币"}, {"dw", "单位"},
  {"fk", "方块"}, {"sb", "上标"}, {"xb", "下标"},
  {"xl", "希腊小写"}, {"xld", "希腊大写"}, {"ey", "俄语"},
  {"py", "拼音带调"}, {"zy", "注音"}, {"jm", "日文"},
  {"tg", "天干"}, {"dz", "地支"}, {"jq", "节气"},
  {"yf", "月份"}, {"rq", "日期"}, {"yr", "星期"},
  {"xz", "星座"}, {"pk", "扑克"}, {"mj", "麻将"},
  {"bg", "八卦"}, {"bd", "标点"}, {"fs", "分数"},
}

function symbol_help_translator(input, seg)
  if input == "fhlb" then
    for _, cat in ipairs(symbol_cats) do
      yield(Candidate("help", seg.start, seg._end, "/" .. cat[1], cat[2]))
    end
  end
end
