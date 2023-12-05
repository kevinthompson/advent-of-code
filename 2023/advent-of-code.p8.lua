function _init()
	cls()
	routine=cocreate(solution)
end

function _update60()
  if costatus(routine) ~= "dead" then
	  assert(coresume(routine))
  end
end

class = setmetatable({
  new = function(_ENV, tbl)
    return setmetatable(tbl or {}, _ENV)
  end
}, { __index = _ENV })

bigint = {
  __index = _ENV,

  __add = function(self, other)
    if type(other) == "number" then
      other = bigint:new(other)
    end

    local result = bigint:new(0)
    for i=1, max(#self.values,#other.values) do
      result.values[i] = result.values[i] or 0
      result.values[i] += self.values[i] or 0
      result.values[i] += other.values[i] or 0

      if result.values[i] >= 10 then
        result.values[i+1] = result.values[i] \ 10
        result.values[i] = result.values[i] % 10
      end
    end

    return result
  end,

  __tostring = function(_ENV)
    local str = ""
    for value in all(values) do
      str = value..str
    end
    return str
  end,

  new = function(_ENV, int)
    local str = tostr(int)
    local obj = {
      values = {}
    }

    for i=#str,1,-1 do
      add(obj.values, str[i])
    end

    return setmetatable(obj,_ENV)
  end
}

setmetatable(bigint,bigint)
